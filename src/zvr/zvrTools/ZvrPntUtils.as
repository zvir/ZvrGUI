package zvr.zvrTools 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPntUtils 
	{
		
		public static function createFromPoint(p:Point):ZvrPnt
		{
			return new ZvrPnt(p.x, p.y);
		}
		
		public static function toPoint(p:ZvrPnt):Point
		{
			return new Point(p.x, p.y);
		}
		
	}

}