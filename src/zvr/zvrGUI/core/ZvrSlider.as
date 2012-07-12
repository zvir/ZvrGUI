package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.components.minimalDark.HScrollMD;
	import zvr.zvrGUI.components.minimalDark.VScrollMD;
	import zvr.zvrGUI.events.ZvrSliderEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name ="minChanged",			type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	[Event(name ="maxChanged",			type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	[Event(name ="rangeChanged",		type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	[Event(name ="dynamicRangeChanged",	type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	[Event(name ="positionChanged",		type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	[Event(name ="scrollStateChange",	type = "zvr.zvrGUI.events.ZvrSliderEvent")]
	
	
	public class ZvrSlider extends ZvrContainer
	{
		
		public static const MAX	:String = "max";
		public static const MIN	:String = "min";
		
		private var _step:Number = 0;
		
		private var _max:Number = 100;
		private var _min:Number = 0;
		
		private var _position:Number = 0;
		
		private var _rangeBegin:Number = 0;
		private var _rangeEnd:Number = 0;
		
		private var _enabled:Boolean = true;
		
		private var _dynamicRange:Boolean = false;
		
		private var _dispatch:Boolean = true;
		
		public function ZvrSlider(skinClass:Class) 
		{
			super(skinClass);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
		}
		
		public function get max():Number 
		{
			return _max;
		}
		
		public function set max(value:Number):void 
		{
			if (_max == value) return;
			
			if (isNaN(value)) value = 0;
			
			if (value < _min) value = _min;
			
			_max = value;
			
			_dispatchEvent(ZvrSliderEvent.MAX_CHANGED);
			
			position = validatePosition(position);
			
		}
		
		public function get min():Number 
		{
			return _min;
		}
		
		public function set min(value:Number):void 
		{
			if (_min == value) return;
			
			if (isNaN(value)) value = 0;
			
			if (value > _max) value = _max;
			
			_min = value;
			
			_dispatchEvent(ZvrSliderEvent.MIN_CHANGED);
			
			position = validatePosition(position);
		}
		
		//------------------------------
		
		
		// range ---------------------
		
		public function get rangeArea():Number 
		{
			return _rangeEnd - _rangeBegin;
		}
		
		
		//------------------------------
		
		
		// rangeBegin ---------------------
		
		public function get rangeBegin():Number
		{
			return _rangeBegin;
		}
		
		public function set rangeBegin(value:Number):void 
		{
			if (_rangeBegin == value) return;
			
			if (_dynamicRange)
			{
				if (value < _min) value = _min;
				if (value > rangeEnd) value = rangeEnd;
				_rangeBegin = value;
				position = value;
				_dispatchEvent(ZvrSliderEvent.RANGE_CHANGED);
			}
			else
			{
				value = validatePosition(value);
				_rangeEnd = value;
				_rangeBegin = value;
				position = value;
			}
			
			
		}
		
		//------------------------------
		
		// percentageRangeBeginPosition
		
		
		
		//------------------------------
		
		
		// rangeEnd ---------------------
		
		public function get rangeEnd():Number
		{
			return _rangeEnd;
		}
		
		public function set rangeEnd(value:Number):void
		{
			if (_rangeBegin == value) return;
			
			if (_dynamicRange)
			{
				if (value > _max) value = _max;
				if (value < _rangeBegin ) value = _rangeBegin;
				_rangeEnd = value;
				_dispatchEvent(ZvrSliderEvent.RANGE_CHANGED);
			}
			else
			{
				value = validatePosition(value);
				_rangeEnd = value;
				_rangeBegin = value;
				position = value;
			}
			
		}
		
		//------------------------------
		
		
		// percentageRangeEnd -------------
		
		//------------------------------
		
		protected function get positionDelta():Number
		{
			return (_max - _min);
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled == value) return;
			_enabled = value;
			_dispatchEvent(ZvrSliderEvent.STATE_CHANGE);
		}
		
		public function get dynamicRange():Boolean 
		{
			return _dynamicRange;
		}
		
		public function set dynamicRange(value:Boolean):void 
		{
			_dynamicRange = value;
			_dispatchEvent(ZvrSliderEvent.DYNAMIC_RANGE_CHANGED);
		}
		
		private function _dispatchEvent(type:String):void
		{
			if (!_dispatch) return;
			dispatchEvent(new ZvrSliderEvent(type, this));
		}
		
		// UTILS TO MAKE LIFE EASIER :D
		
		public function get percentageRange():Number 
		{
			return rangeArea / positionDelta;
		}
		
		public function get position():Number
		{
			return _rangeBegin;
		}
		
		public function set position(value:Number):void
		{
			if (isNaN(value)) value = 0;
			
			value = validatePosition(value);
			
			if (value == _position) return;
			
			if (dynamicRange)
			{
				var r:Number = rangeArea;
				
				if (value < min) value = _min;
				if (value > max - r) value = _max - r;
				_position = value;
				_rangeBegin = value;
				_rangeEnd = _rangeBegin + r;
				_dispatchEvent(ZvrSliderEvent.RANGE_CHANGED);
			}
			else
			{
				_position = value;
				_rangeBegin = _position;
				_rangeEnd = _position;
				
				_dispatchEvent(ZvrSliderEvent.POSITION_CHANGED);
			}
			
		}
		
		private function validatePosition(value:Number):Number
		{
			if (value > _max) value =  _max;
			if (value < _min) value =  _min;
			
			return value;
		}
		
		public function get percentagePosition():Number
		{
			var p:Number = (_position - _min) / positionDelta;
			p = Math.round(p * 1000000) / 1000000;
			return p;
		}
		
		public function get percentageRangeBegin():Number
		{
			var p:Number = (_rangeBegin - _min) / positionDelta;
			p = Math.round(p * 1000000) / 1000000;
			return p;
		}
		
		public function get percentageRangeEnd():Number
		{
			var p:Number = (_rangeEnd - _min) / positionDelta;
			p = Math.round(p * 1000000) / 1000000;
			return p;
		}
		
		public function set percentagePosition(value:Number):void
		{
			position = value * (positionDelta) + _min;
		}
		
		public function set percentageRangeBegin(value:Number):void
		{
			rangeBegin = value * (positionDelta) + _min;
		}
		
		public function set percentageRangeEnd(value:Number):void
		{
			rangeEnd = value * (positionDelta) + _min;
		}
		
		public function get step():Number 
		{
			return _step;
		}
		
		public function set step(value:Number):void 
		{
			_step = value;
		}
		
		
		private function debug(name:String = ""):void
		{
			return;
			
			if (!(this is VScrollMD)) return;
			
			trace("-----------------------------");
			
			trace(name);
			
			trace("min				:", min);
			trace("max				:", max);
			trace("range				:", range);
			trace("positionDelta			:", positionDelta);
			trace("rangeBegin			:", rangeBegin);
			trace("rangeEnd			:", rangeEnd);
			trace("percentageBeginPosition	:", percentageRangeBegin);
			trace("percentageEndPosition	:", percentageRangeEnd);
			trace("percentagePosition		:", percentagePosition);
		}
		
		
		
	}

}