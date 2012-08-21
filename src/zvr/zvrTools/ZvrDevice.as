package zvr.zvrTools 
{
	import flash.system.Capabilities;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDevice 
	{
		
		public static const IPAD_1	:String = "ipad1";
		public static const IPAD_2	:String = "ipad2";
		public static const IPAD_3	:String = "ipad3";
		
		public static const IPHONE_1	:String = "IPHONE1";
		public static const IPHONE_2	:String = "IPHONE2";
		public static const IPHONE_3	:String = "IPHONE3";
		public static const IPHONE_4	:String = "IPHONE4";
		
		private static function getDevice():String
		{	
			var myOS:String = Capabilities.os;
			var myOSLowerCase:String = myOS.toLowerCase();
			 
			if (myOSLowerCase.indexOf("ipad3,") != -1)
			{
				return IPAD_3;
			}
			else if (myOSLowerCase.indexOf("ipad2,")  != -1)
			{
				return IPAD_2;
			}
			else if (myOSLowerCase.indexOf("ipad1,")  != -1)
			{
				return IPAD_1;
			}
			else if (myOSLowerCase.indexOf("iphone4,")  != -1)
			{
				return IPHONE_4;
			}
			else
			{
				return myOS;
			}
		}
		
		public static const DEVICE:String = getDevice();
		
	}

}