package zvr.zvrLocalization 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	internal class ZvrLocContentFile extends ZvrLocContent
	{
		
		internal var file:File;
		//internal var xml:XML;
		
		public function ZvrLocContentFile() 
		{
			
		}
		
		override internal function save():void 
		{
			
			var f:File = new File(file.nativePath);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(f, FileMode.WRITE);
			fileStream.writeUTFBytes(xml.toXMLString());
			fileStream.close();
			
		}
		
	}

}