package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrObject 
	{
		
		public static function setParam(obj:Object, param:String, value:*):void
		{
			var a:Array = param.split(".");
			
			var o:Object = obj;
			
			for (var i:int = 0; i < a.length - 1; i++) 
			{
				o = o[a[i]];
			}
			
			o[a[a.length - 1]] = value;
			
		}
		
		
		public function ZvrObject() 
		{
			
		}
		
	}

}