package zvr.zvrTweener
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTweener
	{
		
		internal static const frameDispather:Sprite = new Sprite();
		
		private static const scopes:Dictionary = new Dictionary();
		
		public static function to(scope:Object, property:Object, fade:Number = 0.1, maxSpeed:Number = 100):void
		{
			getTween(scope, property, fade, maxSpeed);
		}
	
		private static function getTween(scope:Object, property:Object, fade:Number = 0.1, maxSpeed:Number = 100):ZvrTween
		{
			
			var propertyName:String;
			var tween:ZvrTween;
			var scopeDict:Dictionary;
			
			for (var name:String in property) 
			{
				if (name != "onComplete")
				{
					propertyName = name;
				}
			}
			scopeDict = scopes[scope];
			
			if (!scopeDict)
			{
				scopeDict = new Dictionary();
				scopes[scope] = scopeDict;
			}
			
			tween = scopes[scope][propertyName]
			
			if (!tween)
			{
				tween = new ZvrTween(scope, property, fade, maxSpeed);
				scopes[scope][propertyName] = tween;
			}
			else
			{
				tween.updateProperty(property, fade, maxSpeed);
			}
			
			return tween;
			
		}
		
		static internal function disposeTween(zvrTween:ZvrTween):void 
		{
			scopes[zvrTween.scope][zvrTween.property] == null;
			delete scopes[zvrTween.scope][zvrTween.property];
			
			//trace("disposeTween");
			
		}
		
	}

}