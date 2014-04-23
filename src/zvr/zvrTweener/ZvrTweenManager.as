package zvr.zvrTweener 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTweenManager 
	{
		private var _t:ZvrTween;
		
		public function ZvrTweenManager(t:ZvrTween) 
		{
			_t = t;
		}
		
		public function setTo(v:Number):ZvrTweenManager
		{
			_t.setTo(v);
			return this;
		}
		
		public function addOnComplete(f:Function):ZvrTweenManager
		{
			if (_t.onComplete.indexOf(f) == -1) _t.onComplete.push(f);
			return this;
		}
		
		public function addOnCompleteOnce(f:Function):ZvrTweenManager
		{
			if (_t.onCompleteOnce.indexOf(f) == -1) _t.onCompleteOnce.push(f);
			return this;
		}
		
		public function removeOnComplete(f:Function):ZvrTweenManager
		{
			var i:int
			
			i = _t.onComplete.indexOf(f);
			
			if (i != -1) 
			{
				_t.onComplete.splice(i, 1);
			}
			
			i = _t.onCompleteOnce.indexOf(f);
			
			if (i != -1) 
			{
				_t.onCompleteOnce.splice(i, 1);
			}
			
			return this;
		}
		
		public function setFadeOutValue(v:Number):ZvrTweenManager
		{
			_t.fadeOutValue = v;
			_t.fadeOutDuration = NaN;
			return this;
		}
		
		public function setFadeInValue(v:Number):ZvrTweenManager
		{
			_t.fadeInValue = v;
			_t.fadeInDuration = NaN;
			return this;
		}
		
		public function setFadeOutDuration(v:Number):ZvrTweenManager
		{
			_t.fadeOutDuration = v;
			_t.fadeOutValue = NaN;
			return this;
		}
		
		public function setFadeInDuration(v:Number):ZvrTweenManager
		{
			_t.fadeInDuration = v;
			_t.fadeInValue = NaN;
			return this;
		}
		
		public function get t():ZvrTween 
		{
			return _t;
		}
		
		public function disposeAfterComplete(v:Boolean):ZvrTweenManager
		{
			_t.disposeAfterComplete = v;
			return this;
		}
		
		public function step(v:Number = 1):ZvrTweenManager
		{
			_t.step(v);
			return this;
		}
		
		public function updateOnFrame():ZvrTweenManager
		{
			_t.updateMode = ZvrTween.FRAME;
			return this;
		}
		
		public function updateOnTime():ZvrTweenManager
		{
			_t.updateMode = ZvrTween.TIME;
			return this;
		}
		
		public function updateOnToChange():ZvrTweenManager
		{
			_t.updateMode = ZvrTween.TO_UPDATE;
			return this;
		}
		
		public function updateOnStep():ZvrTweenManager
		{
			_t.updateMode = ZvrTween.MANUAL;
			return this;
		}
		
		public function setDynamicDuration(v:Boolean):ZvrTweenManager
		{
			_t.dynamicDuration = v;
			return this;
		}
		
		public function setDurationMultiplayer(v:Number):ZvrTweenManager
		{
			_t.durationMultiplayer = v;
			return this;
		}
		
		public function setMinimumDuration(v:Number):ZvrTweenManager
		{
			_t.minDuration = v;
			return this;
		}
	}

}