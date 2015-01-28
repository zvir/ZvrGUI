package zvr.zvrUtils.byteArray 
{
	import flash.utils.ByteArray;
	/**
	 * ...
	 * @author Zvir
	 */
	public class QuickByteArray extends ByteArray
	{
		
		public function QuickByteArray() 
		{
			super();
		}
		
		public function int8(v:int):QuickByteArray
		{
			writeByte(v);
			return this;
		}
		
		public function int16(v:int):QuickByteArray
		{
			writeShort(v);
			return this;
		}
		
		public function boolean(v:Boolean):QuickByteArray 
		{
			writeBoolean(v);
			return this;
		}
		
	}

}

/*

var ba:ByteArray = new ByteArray();
var bf:uint = 0;

bf = 1<<7;  //Set bit 8 to true
bf |= 1<<6; //Set bit 7 to true 
bf |= 0<<5; //Set bit 6 to false
bf |= 1<<4; //Set bit 5 to true
bf |= 1<<3; //Set bit 4 to true
bf |= 1<<2; //Set bit 3 to true
bf |= 1<<1; //Set bit 2 to true
bf |= 1;    //Set bit 1 to true

ba.writeByte(bf);
trace(ba[0].toString(2)); //11011111

if(ba[0]&32) trace("Bit 6 is true"); //Won't trace anything


*/