package zvr.zvrInitializer
{
	import com.blackmoon.theFew.airFight.view.AirFightDisplayContainer;
	import flash.events.EventDispatcher;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInitializerItem
	{
		public var propertyName:String;
		public var functionName:String;
		
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
		
		public var eventType:String;
		public var eventObject:EventDispatcher;
		
		
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
					var a:*
					var f:Function;
					
					
					if (propertyName)
					{
						a = [thisObject[propertyName]];
					}
					else
					{
						a = args
					}
					
					if (functionName)
					{
						
						var fp:Array = functionName.split(".");
						
						var o:* = thisObject;
						
						for (var i:int = 0; i < fp.length-1; i++) 
						{
							o = o[fp[i]];
						}
						
						f = o[fp[fp.length - 1]];
					}
					else
					{
						f = initFinction;
					}
					
					if (!propertyName && !functionName)
					{
						return f.apply(thisObject, a);
					}
					else
					{
						return f.apply(null, a);
					}
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
		
		
		public function addDynamicProperty(propertyName:String):ZvrInitializerItem
		{
			this.propertyName = propertyName;
			return this;
		}
		
		public function addDynamicFunction(functionName:String):ZvrInitializerItem
		{
			this.functionName = functionName;
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
		
		public function addEvent(eventType:String, eventDispatcher:EventDispatcher):void 
		{
			this.eventType = eventType
			this.eventObject = eventDispatcher;
		}
		
	}

}