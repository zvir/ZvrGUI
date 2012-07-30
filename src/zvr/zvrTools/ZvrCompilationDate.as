package zvr.zvrTools
{
	import com.flexcapacitor.utils.LeadingZeros;
	import flash.display.DisplayObject;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	
	/**
	 * Direct reading of SWF file to gather the SWF Compile information
	 *
	 * Distributed under the new BSD License
	 * @author Paul Sivtsov - ad@ad.by
	 * @author Igor Costa,
	 * @author Judah Frangipane
	 * @author Zvir
	 *
	 **/
	public class ZvrCompilationDate
	{
		private var _documentClass:DisplayObject;
		
		// date SWF was compiled
		public var compilationDate:Date = new Date();
		
		// date SWF was compiled last
		// this date is set to the same compilation date when it is run the client the first time
		public var previousCompiliationDate:Date = new Date();
		
		// difference in milliseconds from last compile
		// only works when the application has been previously visited on your computer
		public var timeDifference:Number = 0;
		
		// flag that indicates the swf has changed since last time you viewed it in the browser
		public var changed:Boolean = false;
		
		// flag that indicates the swf has changed since last time you viewed it in the browser
		public var cached:Boolean = false;
		
		// track changes in a shared object
		// allows you to know if and how long ago changes were made 
		public var trackChanges:Boolean = true;
		
		// local version number unique to the computer the application is run on 
		public var version:String = "";
		
		// serial number
		public var serialNumber:ByteArray = new ByteArray();
		
		// reference to reload button
		
		public function ZvrCompilationDate(documentClass:DisplayObject)
		{
			_documentClass = documentClass;
			init();
		}
		
		///////////////////////////////////////////////////////////////////////////
		// Set the compilation date variable after SWF is loaded
		private function init():void
		{
			var leadingZeros:LeadingZeros = new LeadingZeros();
			
			compilationDate = readCompilationDate();
			
			var sharedObjectName:String = "CompilationDate";
			var sharedObject:SharedObject = SharedObject.getLocal(sharedObjectName);
			var localVersion:int = int(version);
			
			// previous changes found
			if (sharedObject.size != 0)
			{
				// get last saved compilation date
				previousCompiliationDate = new Date(sharedObject.data.compilationDate);
				// get last version number
				localVersion = sharedObject.data.version;
				// get time difference
				timeDifference = compilationDate.time - previousCompiliationDate.time;
				
				if (timeDifference > 0)
				{
					changed = true;
					localVersion++;
				}
				else
				{
					cached = true;
				}
			}
			
			// save changes
			if (compilationDate) sharedObject.data.compilationDate = compilationDate.time;
			sharedObject.data.version = localVersion;
			version = String(localVersion);
			
			// save changes
			if (trackChanges)
			{
				try
				{
					sharedObject.flush();
				}
				catch (e:Event)
				{
					// can't save info for some reason
				}
			}
			
			// if we have button and the file hasn't changed we show the reload button
			
		}
		
		///////////////////////////////////////////////////////////////////////////
		// Returns compilation date of current module
		public function readCompilationDate(serialNumber:ByteArray = null):Date
		{
			const compilationDate:Date = new Date;
			const DATETIME_OFFSET:uint = 18;
			
			if (serialNumber == null)
				serialNumber = readSerialNumber();
			
			/* example of filled SWF_SERIALNUMBER structure
			   struct SWF_SERIALNUMBER
			   {
			   UI32 Id;         // "3"
			   UI32 Edition;    // "6"
			   // "flex_sdk_4.0.0.3342"
			   UI8 Major;       // "4."
			   UI8 Minor;       // "0."
			   UI32 BuildL;     // "0."
			   UI32 BuildH;     // "3342"
			   UI32 TimestampL;
			   UI32 TimestampH;
			   };
			 */
			
			// the SWF_SERIALNUMBER structure exists in FLEX swfs only, not FLASH
			if (serialNumber == null)
				return null;
			
			// date stored as uint64
			serialNumber.position = DATETIME_OFFSET;
			serialNumber.endian = Endian.LITTLE_ENDIAN;
			compilationDate.time = serialNumber.readUnsignedInt() + serialNumber.readUnsignedInt() * (uint.MAX_VALUE + 1);
			
			return compilationDate;
		}
		
		///////////////////////////////////////////////////////////////////////////
		// Returns contents of Adobe SerialNumber SWF tag
		public function readSerialNumber():ByteArray
		{
			const TAG_SERIAL_NUMBER:uint = 0x29;
			return findAndReadTagBody(TAG_SERIAL_NUMBER);
		}
		
		///////////////////////////////////////////////////////////////////////////
		// Returns the tag body if it is possible
		public function findAndReadTagBody(theTagCode:uint):ByteArray
		{
			// getting direst access to unpacked SWF file
			// reported to cause security sandbox errors ->
			//const src:ByteArray = LoaderInfo.getLoaderInfoByDefinition(SWF).bytes;
			// erg this one throughs an error too TypeError: Error #1009: Cannot access a property or method of a null object reference.
			//const src:ByteArray = Application(Application.application).loaderInfo.bytes;
			var src:ByteArray = new ByteArray();
			var loaderInfo:LoaderInfo = _documentClass.loaderInfo;
			
			// the swf has not loaded yet - wait until application complete
			if (loaderInfo.bytesLoaded != loaderInfo.bytesTotal)
			{
				return null;
			}
			const test:* = _documentClass.loaderInfo.bytes;
			src = _documentClass.loaderInfo.bytes;
			
			/*
			   SWF File Header
			   Field      Type  Offset   Comment
			   -----      ----  ------   -------
			   Signature  UI8   0        Signature byte: “F” indicates uncompressed, “C” indicates compressed (SWF 6 and later only)
			   Signature  UI8   1        Signature byte always “W”
			   Signature  UI8   2        Signature byte always “S”
			   Version    UI8   3        Single byte file version (for example, 0x06 for SWF 6)
			   FileLength UI32  4        Length of entire file in bytes
			   FrameSize  RECT  8        Frame size in twips
			   FrameRate  UI16  8+RECT   Frame delay in 8.8 fixed number of frames per second
			   FrameCount UI16  10+RECT  Total number of frames in file
			 */
			
			// skip AVM2 SWF header
			// skip Signature, Version & FileLength
			src.position = 8;
			// skip FrameSize
			const RECT_UB_LENGTH:uint = 5;
			const RECT_SB_LENGTH:uint = src.readUnsignedByte() >> (8 - RECT_UB_LENGTH);
			const RECT_LENGTH:uint = Math.ceil((RECT_UB_LENGTH + RECT_SB_LENGTH * 4) / 8);
			src.position += (RECT_LENGTH - 1);
			// skip FrameRate & FrameCount
			src.position += 4;
			
			while (src.bytesAvailable > 0)
			{
				with (readTag(src, theTagCode))
				{
					if (tagCode == theTagCode)
						return tagBody;
				}
			}
			
			return null;
		}
		
		///////////////////////////////////////////////////////////////////////////
		// Returns tag from current read position
		private function readTag(src:ByteArray, theTagCode:uint):Object
		{
			src.endian = Endian.LITTLE_ENDIAN;
			
			const tagCodeAndLength:uint = src.readUnsignedShort();
			const tagCode:uint = tagCodeAndLength >> 6;
			const tagLength:uint = function():uint
			{
				const MAX_SHORT_TAG_LENGTH:uint = 0x3F;
				const shortLength:uint = tagCodeAndLength & MAX_SHORT_TAG_LENGTH;
				return (shortLength == MAX_SHORT_TAG_LENGTH) ? src.readUnsignedInt() : shortLength;
			}();
			
			const tagBody:ByteArray = new ByteArray;
			if (tagLength > 0)
				src.readBytes(tagBody, 0, tagLength);
			
			return {tagCode: tagCode, tagBody: tagBody};
		}
	}
}
