package zvr.zvrGUI.vo.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.vo.charts.Chart;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ChartEvent extends Event 
	{
		private var _chart:Chart;
		
		public static const LIMIT_CHANGE		:String = "limitChange";
		public static const DATA_CHANGE			:String = "dataChange";
		public static const DATA_POINT_ADDED	:String = "dataPointAdded";
		
		public function ChartEvent(type:String, chart:Chart, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_chart = chart;
		} 
		
		public override function clone():Event 
		{ 
			return new ChartEvent(type, _chart, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ChartEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get chart():Chart 
		{
			return _chart;
		}
		
		public function set chart(value:Chart):void 
		{
			_chart = value;
		}
		
	}
	
}