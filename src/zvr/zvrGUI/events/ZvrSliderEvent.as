package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrSlider;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSliderEvent extends Event 
	{
		
		public static const MIN_CHANGED				:String = "minChanged";
		public static const MAX_CHANGED				:String = "maxChanged";
		public static const RANGE_CHANGED			:String = "rangeChanged";
		public static const DYNAMIC_RANGE_CHANGED	:String = "dynamicRangeChanged";
		public static const POSITION_CHANGED		:String = "positionChanged";
		public static const STATE_CHANGE			:String = "scrollStateChange";
		
		private var _slider:ZvrSlider;
		private var _delta:Number;
		
		public function ZvrSliderEvent(type:String, slider:ZvrSlider, delta:Number, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);	
			_delta = delta;
			_slider = slider;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrSliderEvent(type, _slider, _delta, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrScrollEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get slider():ZvrSlider 
		{
			return _slider;
		}
		
		public function get delta():Number 
		{
			return _delta;
		}
		
	}
	
}