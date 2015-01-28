package zvr.zvrTools 
{
	import flash.geom.Point;
		
	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrVec
	{/*
		CONFIG::debug			
		public static var counter:int = 0;
		*/
		public var x:Number;
		public var y:Number;
		public var z:Number;
		
		public var name:String;
		
		public function ZvrVec(x:Number = 0, y:Number = 0, z:Number = 0)
		{/*
			CONFIG::debug
			{
				counter++;
				if (counter % 100 == 0) wch("ZvrPnt", "counter", counter);
			}
			*/
			this.x = x;
			this.y = y;
			this.z = z;
			
		}
		
		public function copyFrom(p:ZvrVec):void
		{
			x = p.x;
			y = p.y;
			z = p.z;
		}
		
		public function clone():ZvrVec
		{
			return new ZvrVec(x, y, z);
		}
		
		public function toString():String
		{
			return "x:" + x + ", y:" + y + ", z:" + z;
		}
		
	}

}