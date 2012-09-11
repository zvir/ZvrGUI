package zvr.zvrInitializer
{
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInitializerItem
	{
		
		public var next:ZvrInitializerItem;
		public var prev:ZvrInitializerItem;
		
		public var initializer:ZvrInitializer
		public var name:String;
		public var initFinction:Function;
		public var args:Array;
		public var thisObject:*;
		public var property:String;
		public var constructorClass:Class;
		
		public var dynamicParamTo:ZvrInitializerItem;
		
		public function ZvrInitializerItem()
		{
			
		}
		
		public function init():*
		{
			if (constructorClass)
			{
				thisObject[property] = new constructorClass();
				return null;
			}
			else
			{
				if (dynamicParamTo)
				{
					var p:* = initFinction.apply(thisObject, args);
					
					dynamicParamTo.args.push(p);
					
					return p;
				}
				else
				{
					return initFinction.apply(thisObject, args);
				}
			}
			
		}
		
		public function addDynamicParam(initFinction:Function, thisObject:* = null, name:String = null, ... rest):ZvrInitializerItem
		{
			
			initializer.initCount++;
			
			trace("ADDING INIT:", initializer.initCount, "(" + (getTimer() - initializer.time) + "ms)", name);
			
			initializer.time = getTimer();
			
			var initItem:ZvrInitializerItem = new ZvrInitializerItem();
			
			initItem.dynamicParamTo = this;
			initItem.initFinction = initFinction;
			initItem.thisObject = thisObject;
			initItem.name = name;
			initItem.args = rest;
			
			initItem.dynamicParamTo = this;
			
			initItem.next = this;
			initItem.prev = prev;
			
			prev.next = initItem;
			prev = initItem;
			
			return this;
			
		}
		
		public function dispose():void 
		{
			next = null;
			prev = null;
			initializer = null;
			name = null;
			initFinction = null;
			args = null;
			thisObject = null;
			property = null;
			constructorClass = null;
			dynamicParamTo = null;
			
		}
		
	}

}