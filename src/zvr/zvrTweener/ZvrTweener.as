package zvr.zvrTweener
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTweener
	{
		
		internal static const frameDispather:Sprite = new Sprite();
		
		private static const scopes:Dictionary = new Dictionary();
		
		private static const tweens:Vector.<ZvrTween> = new Vector.<ZvrTween>();
		
		private static var lastUpdate:Number = getTimer();
		
		private static function initSprite():Sprite
		{
			var s:Sprite = new Sprite();
			s.addEventListener(Event.ENTER_FRAME, enterFrame);
			return s;
		}
		
		private static var sprite:Sprite = initSprite();
		
		
		
		public static function to(scope:Object, property:Object):ZvrTweenManager
		{
			return getTween(scope, property).setter;
		}
	
		private static function getTween(scope:Object, property:Object):ZvrTween
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
				tween = new ZvrTween(scope, property);
				tweens.push(tween);
				scopes[scope][propertyName] = tween;
			}
			else
			{
				tween.updateProperty(property);
			}
			
			return tween;
			
		}
		
		
		
		static internal function disposeTween(zvrTween:ZvrTween):void 
		{
			scopes[zvrTween.scope][zvrTween.propertyName] == null;
			delete scopes[zvrTween.scope][zvrTween.propertyName];
			tweens.splice(tweens.indexOf(zvrTween), 1);
			trace("disposeTween");
			
		}
		
		static private function enterFrame(e:Event):void 
		{
			var c:Number = getTimer();
			var el:Number = c - lastUpdate;
			
			lastUpdate = c;
			
			for (var i:int = 0; i < tweens.length; i++) 
			{
				tweens[i].update(el);
			}
		}
	}

}