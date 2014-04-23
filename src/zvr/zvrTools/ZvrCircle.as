package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrCircle 
	{
		
		public var center:ZvrPnt;
		public var radius:Number;
		
		public function ZvrCircle(x:Number,y:Number,radius:Number) 
		{
			center = new ZvrPnt(x, y);
			this.radius = radius;
		}
		
		public function clone():ZvrCircle
		{
			return new ZvrCircle(center.x, center.y, radius);
		}
		
		public function copyFrom(circle:ZvrCircle):void
		{
			center.x = circle.center.x;
			center.y = circle.center.y;
			radius = circle.radius;
		}
		
		
	}

}