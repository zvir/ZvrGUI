package zvr.zvrTweener 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zvir
	 */
	public class Animation 
	{
		
		private static var _animation:Vector.<AnimationItem> = new Vector.<AnimationItem>();
		private static var _animationScopes:Dictionary = new Dictionary();
		
		public static function addAnimation(scope:Object, parameters:Object, duration:Number, delay:Number, transition:String):AnimationItem
		{
			var i:AnimationItem = new AnimationItem(scope, parameters, duration, delay, transition);
			
			_animation.push(i);
			
			if (_animationScopes[scope] == undefined)
			{
				_animationScopes[scope] = [];
			}
			
			_animationScopes[scope].push(i);
			
			return i;
		}
		
		public static function update(time:Number):void
		{
			if (time == 0) return;
			
			for (var i:int = 0; i < _animation.length; i++) 
			{
				_animation[i].update(time);
			}
		}
		
		public static function removeAnimation(a:AnimationItem):void
		{
			var i:int = _animation.indexOf(a);
			if (i == -1) return;
			_animation.splice(i, 1);
			
			i = _animationScopes[a.scope].indexOf(a);
			_animationScopes[a.scope].splice(i, 1);
			
			if (_animationScopes[a.scope].length == 0)
			{
				_animationScopes[a.scope] = null;
				delete _animationScopes[a.scope];
			}
			
			a.dispose();
			
		}
		
		public static function removeScope(s:Object):void
		{
			if (_animationScopes[s] == undefined) return;
			
			var a:Array = _animationScopes[s];
			
			for (var i:int = a.length-1; i >= 0; i--) 
			{
				removeAnimation(a[i]);
			}
			
		}
		
	}

}