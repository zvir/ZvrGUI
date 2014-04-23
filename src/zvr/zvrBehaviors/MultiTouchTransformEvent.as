package zvr.zvrBehaviors
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class MultiTouchTransformEvent extends Event 
	{
		
		public static const UPDATE:String = "update";
		public static const BEGIN:String = "begin";
		public static const END:String = "end";
		
		private var _rotationDelta:Number;
		private var _xPositinDelta:Number;
		private var _yPositinDelta:Number;
		private var _scaleDelta:Number;
		private var _centerX:Number;
		private var _centerY:Number;
		
		
		
		public function MultiTouchTransformEvent(type:String, rotationDelta:Number = 0, centerX:Number = 0, centerY:Number = 0, xPositinDelta:Number = 0, yPositinDelta:Number = 0,  scaleDelta:Number = 0, bubbles:Boolean = false, cancelable:Boolean = false) 
		{ 
			super(type, bubbles, cancelable);
			_centerX = centerX;
			_centerY = centerY;
			_scaleDelta = scaleDelta;
			_yPositinDelta = yPositinDelta;
			_xPositinDelta = xPositinDelta;
			_rotationDelta = rotationDelta;
		} 
		
		public override function clone():Event 
		{ 
			return new MultiTouchTransformEvent(type, _rotationDelta, _centerX, _centerY, xPositinDelta, yPositinDelta, _scaleDelta,bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("MultiTouchTransformEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get rotationDelta():Number 
		{
			return _rotationDelta;
		}
		
		public function get xPositinDelta():Number 
		{
			return _xPositinDelta;
		}
		
		public function get yPositinDelta():Number 
		{
			return _yPositinDelta;
		}
		
		public function get centerX():Number 
		{
			return _centerX;
		}
		
		public function get centerY():Number 
		{
			return _centerY;
		}
		
		public function get scaleDelta():Number 
		{
			return _scaleDelta;
		}
		
	}
	
}