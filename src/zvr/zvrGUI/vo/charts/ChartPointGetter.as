package zvr.zvrGUI.vo.charts 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ChartPointGetter 
	{
		
		private static const points:Vector.<ChartPoint> = new Vector.<ChartPoint>();
		
		public static function getPoint(x:Number, y:Number):ChartPoint
		{
			
			var p:ChartPoint = points.length > 0 ? points.pop() : new ChartPoint(0,0);
			
			p.x = x;
			p.y = y;
			
			return p;
		}
		
		public static function utilizePoint(chartPoint:ChartPoint):void
		{
			points.push(chartPoint);
		}
		
	}

}