package zvr.zvrTweener 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class AnimationItem 
	{
		
		private var _parameters:Vector.<AnimationParameter> = new Vector.<AnimationParameter>();
		
		private var _complete:Boolean;
		
		private var transition:Function;
		private var currentTransition:Function;
		
		private var pingPongTransition:Function;
		private var pingPongDuration:Number;
		private var pingPongDelayIn:Number;
		private var pingPongDelayOut:Number;
		
		private var duration:Number = 0;
		private var currentDuration:Number = 0;
		private var elapsed:Number = 0;
		private var delay:Number = 0;
		
		public var scope:Object;
		
		private var _loop:int;
		private var _onCompleteHandler:Function;
		private var _repeats:int = -1;
		
		private var _inverse:Boolean;
		
		public function AnimationItem(scope:Object, parameters:Object, duration:Number, delay:Number, transition:String)
		{
			this.scope = scope;
			this.transition = AnimationEquations[transition];
			currentTransition = this.transition;
			this.delay = delay;
			this.duration = duration;
			this.elapsed = - delay;
			currentDuration = this.duration;
			
			for (var name:String in parameters)
			{
				var ap:AnimationParameter = new AnimationParameter(name, scope[name], parameters[name]);
				_parameters.push(ap);
			}
			
		}
		
		public function update(time:Number):void
		{
			if (_complete) return;
			
			if (elapsed < 0)
			{
				elapsed += time;
				return;
			}
			
			if (elapsed + time <= currentDuration)
			{
				for (var i:int = 0; i < _parameters.length; i++) 
				{
					var p:AnimationParameter = _parameters[i];
					scope[p.parameterName] = transition(elapsed, p.startValue, p.endValue - p.startValue, currentDuration);
					elapsed += time;
				}
			}
			else
			{
				
				for (i = 0; i < _parameters.length; i++) 
				{
					p = _parameters[i];
					scope[p.parameterName] = p.endValue;
				}
				
				if (_loop && _repeats != 0)
				{
					if (_loop == 2)
					{
						for (i = 0; i < _parameters.length; i++) 
						{
							var s:* = p.startValue;
							var e:* = p.endValue;
							
							p.endValue = s;
							p.startValue = e;
							
							_inverse = !_inverse;
							
						}
					}
					if (_inverse)
					{
						elapsed = -pingPongDelayOut;
						currentDuration = pingPongDuration;
						if (pingPongTransition != null) currentTransition = pingPongTransition;
						
					}
					else
					{
						currentDuration = duration;
						currentTransition = transition;
						elapsed = -pingPongDelayIn;
					}
					
					_repeats--;
				}
				else
				{				
					_complete = true;
					
					for (i = 0; i < _parameters.length; i++) 
					{
						p = _parameters[i];
						scope[p.parameterName] =  p.endValue;
					}
					
					var f:Function = _onCompleteHandler;
					Animation.removeAnimation(this);
					
					if (f != null)
					{
						f();
					}
					
				}
			}
			
		}
		
		public function enableLoop():AnimationItem
		{
			_loop = 1;
			return this;
		}
		
		public function enablePingPong(duration:Number = NaN, delayIn:Number = 0, delayOut:Number = 0 , transition:String = null):AnimationItem
		{
			_loop = 2;
			
			pingPongDelayIn = delayIn;
			pingPongDelayOut = delayOut;
			pingPongDuration = isNaN(duration) ? this.duration : duration;
			pingPongTransition = transition == null ? this.transition : AnimationEquations[transition];
			
			return this;
		}
		
		public function setRepeats(v:int):AnimationItem
		{
			_repeats = v;
			return this;
		}
		
		public function setOnComplete(f:Function):AnimationItem
		{
			_onCompleteHandler = f;
			return this;
		}
		
		public function dispose():void
		{
			
			for (var i:int = 0; i < _parameters.length; i++) 
			{
				var p:AnimationParameter = _parameters[i];
				p.parameterName = null;
				p.startValue = null;
				p.endValue = null;
				p.currentValue = null;
			}
			
			_parameters.length = 0;
			_parameters = null;
			transition = null;	
			scope = null;	
			_onCompleteHandler = null;	
			currentTransition = null;	
			pingPongTransition = null;	
		}
		
	}

}