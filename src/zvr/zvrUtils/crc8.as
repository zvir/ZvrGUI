package zvr.zvrUtils
{
	import flash.utils.ByteArray;
	/**
	   Determines if two Arrays contain the same objects at the same index.

	   @param first: First Array to compare to the <code>second</code>.
	   @param second: Second Array to compare to the <code>first</code>.
	   @return Returns <code>true</code> if Arrays are the same; otherwise <code>false</code>.
	 */
	public function crc8(v:ByteArray):uint
	{
		v.position = 0;
		
		var c:uint = 0;
		
		while (v.position < v.length)
		{
			var s:int = v.readUnsignedByte();
			c += s;
			c %= 256;
		}
		return c;
	}
}