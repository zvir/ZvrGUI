package zvr.zvrTweener 
{
	import flash.events.Event;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTweenOld
	{
		
		private var _currentSpeed:Number = 0;
		private var _speed:Number = 10;
		private var _fade:Number = 0.1;
		private var _cfade:Number = 0.1;
		private var _valueTo:Number = 0;
		private var _value:Number = 0;
		private var _maxSpeed:Number = 100;
		private var _onComplete:Function;
		
		public var property:Object;
		public var scope:Object;
		public var propertyName:String;
		
		private var _complete:Boolean;
		
		public function ZvrTweenOld(scope:Object, property:Object, fade:Number = 0.1, maxSpeed:Number = 100)
		{
			this.scope = scope;
			updateProperty(property, fade, maxSpeed);
		}
		
		public function updateProperty(property:Object, fade:Number = 0.1, maxSpeed:Number = 100):void
		{
			this.property = property;
			
			_fade = fade;
			_maxSpeed = maxSpeed;
			
			for (var name:String in property) 
			{
				if (name == "onComplete")
				{
					_onComplete = property[name];
				}
				else
				{
					propertyName = name;
					_value = scope[propertyName];
					valueTo = property[name];
				}
			}
			
			//ZvrTweener.frameDispather.addEventListener(Event.ENTER_FRAME, enterFrame);
			_complete = false;
		}
		
		private function enterFrame(e:Event):void 
		{
			step();
		}
		
		public function step(step:Number = 1):void
		{
			if (Math.abs(_valueTo - _value) == 0) return;
			
			var fadeOutOn:Number;
			
			if (!isNaN(_valueTo))
			{
				_speed = _value < _valueTo ? Math.abs(_speed) : -Math.abs(_speed);	
			}
			else
			{
				return;
			}
			
			_currentSpeed = _currentSpeed + (_speed > _currentSpeed ? _cfade : -_cfade);
			
			_value += _currentSpeed;
			
			updataValue();
			
			fadeOutOn = getFadeOutOn();
			
			
			
			if (Math.abs(_valueTo - fadeOutOn) < Math.abs(_currentSpeed))
			{
				if (Math.abs(_speed) > 0)
				{
					_speed = 0;
				}
				
				trace("FADE OUT");
				
				_cfade = getFadeOn();
			}
			
			if (Math.abs(_valueTo - _value) < 0.00005)
			{
				if (_speed == 0)
				{
					_value = _valueTo;
					updataValue();
					_currentSpeed = 0;
					_valueTo = NaN;
					trace("ok!!!!!!");
					complete();
				}
			}
			
			
			trace(fadeOutOn.toFixed(), valueTo, getFadeOn().toFixed(), _cfade);
			
		}
		
		private function updataValue():void 
		{
			scope[propertyName] = _value;
		}
		
		private function complete():void 
		{
			_complete = true;
			ZvrTweener.frameDispather.removeEventListener(Event.ENTER_FRAME, enterFrame);
			if (_onComplete != null) _onComplete();
			
			if (_complete)
			{
				ZvrTweener.disposeTween(this);
			}
			
		}
		
		public function getFadeOutOn():Number
		{
			var s:Number = (_currentSpeed * _currentSpeed) / (2 * _cfade);
			return _value + (_currentSpeed > 0 ? s : -s);
		}
		
		public function getFadeOn():Number
		{
			var f:Number = ((_currentSpeed * _currentSpeed) / (_valueTo - _value)) / 2;
			return (_currentSpeed > 0 ? f : -f);
		}
		
		public function get valueTo():Number 
		{
			return _valueTo;
		}
		
		public function set valueTo(value:Number):void 
		{	
			if (_valueTo == value) return;
			
			_valueTo = value;
			
			
			//_currentSpeed = _currentSpeed + (_speed > _currentSpeed ? _cfade : -_cfade);
			
			if (Math.abs(_valueTo - getFadeOutOn()) < Math.abs(_currentSpeed))
			{
				if (Math.abs(_speed) > 0)
				{
					_speed = 0;
				}
				
				trace("FADE OUT");
				
				_cfade = getFadeOn();
			}
			else
			{
				_speed = _value < _valueTo ? _maxSpeed : -_maxSpeed;
				_cfade = _fade;
			}
			//var c:Number = getFadeOn();
			
			/*if (Math.abs(c) > _fade)
			{
				_cfade = _fade;
			}
			else
			{
				_cfade = c;
			}*/
			
		}
		
		public function get steps():Number 
		{
			return _value;
		}
		
		public function get fade():Number 
		{
			return _fade;
		}
		
		public function set fade(value:Number):void 
		{
			_fade = value;
		}
	}

}