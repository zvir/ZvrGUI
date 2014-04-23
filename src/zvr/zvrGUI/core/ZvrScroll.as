package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.components.minimalDark.HScrollMD;
	import zvr.zvrGUI.components.minimalDark.VScrollMD;
	import zvr.zvrGUI.events.ZvrScrollEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name ="minChanged",			type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	[Event(name ="maxChanged",			type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	[Event(name ="rangeChanged",		type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	[Event(name ="dynamicRangeChanged",	type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	[Event(name ="positionChanged",		type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	[Event(name ="scrollStateChange",	type = "zvr.zvrGUI.events.ZvrScrollEvent")]
	
	
	public class ZvrScroll extends ZvrContainer implements IZvrScroll
	{
		
		public static const MAX	:String = "max";
		public static const MIN	:String = "min";
		
		private var _step:Number = 10;
		
		private var _max:Number = 100;
		private var _min:Number = 0;
		private var _range:Number = 10;
		private var _minRange:Number = 10;
		private var _rangeBegin:Number = 0;
		
		private var _enabled:Boolean = true;
		private var _dynamicRange:Boolean = false;
		
		private var _dispatch:Boolean = true;
		public var boundsSnap:Boolean = false;
		public var snapPrority:String = MAX;
		
		public function ZvrScroll(skinClass:Class) 
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
			
			var snap:Boolean
			
			if (snapPrority == MAX)
			{
				snap = percentagePosition >= 1 || percentageRange >= 1;
			} 
			else
			{
				snap = percentagePosition >= 1;
			}
			
			_max = value;
			
			_dispatchEvent(ZvrScrollEvent.MAX_CHANGED);

			position = validatePosition(position);

			if (boundsSnap && snap) percentagePosition = 1;
			
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
			
			var snap:Boolean
			
			if (snapPrority == MIN)
			{
				snap = percentagePosition <= 0 || percentageRange >= 1;
			} 
			else
			{
				snap = percentagePosition <= 0;
			}
			
			_min = value;
			
			_dispatchEvent(ZvrScrollEvent.MIN_CHANGED);
			
			position = validatePosition(position);
			
			if (boundsSnap && snap && percentagePosition != 1) percentagePosition = 0;
			
		}
		
		//------------------------------
		
		
		// range ---------------------
		
		public function get range():Number 
		{
			return _range;
		}
		
		public function set range(value:Number):void 
		{
			if (_range == value) return;
			
			var snap:Boolean = percentagePosition == 1;
			
			_range = value;
			
			if (_range < _minRange) _range = _minRange;
			
			if (boundsSnap && snap) percentagePosition = 1;
			
			_dispatchEvent(ZvrScrollEvent.RANGE_CHANGED);
			
			position = validatePosition(position);
			
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
				
				_range = rangeEnd - value;
				_rangeBegin = value;
				
				_dispatchEvent(ZvrScrollEvent.RANGE_CHANGED);
				return;
			}
			else
			{
				_rangeBegin = validatePosition(value);
			}
			
			_dispatchEvent(ZvrScrollEvent.POSITION_CHANGED);
			
		}
		
		//------------------------------
		
		// percentageRangeBeginPosition
		
		public function get percentageRangeBegin():Number 
		{
			return (rangeBegin - _min) / positionDelta;
		}
		
		public function set percentageRangeBegin(value:Number):void 
		{
			rangeBegin = value * positionDelta + _min;
			
		}
		
		//------------------------------
		
		
		// rangeEnd ---------------------
		
		public function get rangeEnd():Number
		{
			return _rangeBegin + _range;
		}
		
		public function set rangeEnd(value:Number):void
		{
			if (value > _max) value = _max;
			if (value < _rangeBegin ) value = _rangeBegin;
			
			if (_dynamicRange)
			{
				range = value - _rangeBegin;
			}
			else
			{
				rangeBegin = value - range;
			}
			
		}
		
		//------------------------------
		
		
		// percentageRangeEnd -------------
		
		public function set percentageRangeEnd(value:Number):void
		{
			rangeEnd = value * positionDelta + _min;
		}
		
		public function get percentageRangeEnd():Number
		{
			return (rangeEnd - _min) / (positionDelta);
		}
		
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
			_dispatchEvent(ZvrScrollEvent.STATE_CHANGE);
		}
		
		public function get dynamicRange():Boolean 
		{
			return _dynamicRange;
		}
		
		public function set dynamicRange(value:Boolean):void 
		{
			_dynamicRange = value;
			_dispatchEvent(ZvrScrollEvent.DYNAMIC_RANGE_CHANGED);
		}
		
		private function _dispatchEvent(type:String):void
		{
			if (!_dispatch) return;
			dispatchEvent(new ZvrScrollEvent(type, this));
		}
		
		// UTILS TO MAKE LIFE EASIER :D
		
		public function get percentageRange():Number 
		{
			return range / positionDelta;
		}
		
		public function get position():Number
		{
			return _rangeBegin;
		}
		
		public function set position(value:Number):void
		{
			value = validatePosition(value);
			if (value == _rangeBegin) return;
			_rangeBegin = value;
			_dispatchEvent(ZvrScrollEvent.POSITION_CHANGED);
		}
		
		private function validatePosition(value:Number):Number
		{
			if (value > _max - _range) value =  _max - _range;
			if (value < _min) value =  _min;
			return value;
		}
		
		private function get validRange():Number
		{
			return (_range > positionDelta ? positionDelta : _range);
		}
		
		public function get percentagePosition():Number
		{
			var p:Number = (_rangeBegin - _min) / (positionDelta - _range);
			
			p = Math.round(p * 1000000) / 1000000;
			
			return p;
		}
		
		public function set percentagePosition(value:Number):void
		{
			position = value * (positionDelta - _range) + _min;
		}
		
		public function get minRange():Number 
		{
			return _minRange;
		}
		
		public function set minRange(value:Number):void 
		{
			if (value == _minRange) return;
			_minRange = value;
			if (_range < _minRange) range = _minRange;
		}
		
		public function get step():Number 
		{
			return _step;
		}
		
		public function set step(value:Number):void 
		{
			_step = value;
		}
		
		public function setUp(contentBegin:Number, contentEnd:Number, size:Number):void
		{	
			min = contentBegin;
			max = contentEnd;
			range = size;
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