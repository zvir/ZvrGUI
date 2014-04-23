package zvr.zvrTools 
{
	import flash.geom.Point;
		
	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrPnt
	{/*
		CONFIG::debug			
		public static var counter:int = 0;
		*/
		public var x:Number;
		public var y:Number;
		
		public var name:String;
		
		public function ZvrPnt(x:Number = 0, y:Number = 0)
		{/*
			CONFIG::debug
			{
				counter++;
				if (counter % 100 == 0) wch("ZvrPnt", "counter", counter);
			}
			*/
			this.x = x;
			this.y = y;
			
		}
		
		public function copyFrom(p:ZvrPnt):void
		{
			x = p.x;
			y = p.y;
		}
		
		public function clone():ZvrPnt
		{
			return new ZvrPnt(x, y);
		}
		
		public function toString():String
		{
			return "x:" + x + ", y:" + y;
		}
		
	}

}