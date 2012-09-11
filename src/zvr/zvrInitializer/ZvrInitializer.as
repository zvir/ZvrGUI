package zvr.zvrInitializer
{
import com.blackmoon.theFew.airFight.handlers.*;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInitializer
	{
		
		public var sp:Sprite = new Sprite();
		public var initCount:int;
		public var current:int;
		
		public var head:ZvrInitializerItem;
		public var tail:ZvrInitializerItem;
		
		public var disposeItems:Vector.<ZvrInitializerItem> = new Vector.<ZvrInitializerItem>();
		
		public var time:int;
		public var totalMemeory:int;
		public var itemMememory:int;
		public var sTime:int;
		public var stepTime:int;
		public var timeOut:int = 15;
		public var addingStart:int = 0;
		
		public var report:Function;
		public var complete:Function;
		private var reporting:Boolean;
		
		public function ZvrInitializer()
		{
			
		}
		
		public function init():void
		{
			
			trace("ADDING TIME ("+(getTimer() - addingStart) + "ms)");
			
			trace("INIT START");
			
			time = getTimer();
			sTime = time;
			sp.addEventListener(Event.ENTER_FRAME, initEnterFrame);
			
			stepTime = getTimer();
			
			if (report != null && head)
			{
				report((current+1) / initCount, head.name || "");
			}
			
		}
		
		public function addInit(initFinction:Function, thisObject:* = null, name:String = null, ... rest):ZvrInitializerItem
		{
			initCount++;
			
			if (addingStart == 0) addingStart = getTimer();
			
			trace("ADDING INIT:", initCount, "(" + (time == 0 ? "?" : (getTimer() - time)) + "ms)", name);
			
			time = getTimer();
			
			var initItem:ZvrInitializerItem = new ZvrInitializerItem();
			
			initItem.initializer = this;
			initItem.initFinction = initFinction;
			initItem.thisObject = thisObject;
			initItem.name = name;
			initItem.args = rest;
			
			if(!head) head = initItem;
			if(tail) tail.next = initItem;
			initItem.prev = tail;
			tail = initItem;
			
			return initItem;
			
		}
		
		public function addCnst(thisObject:Object, property:String, cl:Class,  name:String = null) :void
		{
			initCount++;
			
			if (addingStart == 0) addingStart = getTimer();
			
			trace("ADDING CONSTRUCTOR:", initCount, "(" + (time == 0 ? "?" : (getTimer() - time)) + "ms)", name);
			
			time = getTimer();
			
			var initItem:ZvrInitializerItem = new ZvrInitializerItem();
			initItem.constructorClass = cl;
			initItem.thisObject = thisObject;
			initItem.property = property;
			initItem.name = name;
			
			if(!head) head = initItem;
			if(tail) tail.next = initItem;
			initItem.prev = tail;
			tail = initItem;
		}
		
		private function initEnterFrame(e:Event):void 
		{
			
			stepTime = getTimer();
		
			if (reporting)
			{
				reporting = false;
				if (report != null && head) report((current+1) / initCount, head.name || "");
				return;
			}
			
			if (!head)
			{	
				sp.removeEventListener(Event.ENTER_FRAME, initEnterFrame);
				
				trace("INIT DONE", (getTimer() - sTime) + "ms", Number(totalMemeory * 0.000000954 ).toFixed(3) + " MB");
				
				if (complete != null) complete();
				
				dispose();
				
				return;
			}
			
			reporting = true;
			
			
			var st:int = getTimer();
			var item:ZvrInitializerItem = head;
			
			while (item)
			{
				time = getTimer();
				
				itemMememory = System.totalMemory;
				
				item.init();
				
				current++;
				
				itemMememory = System.totalMemory - itemMememory;
				
				totalMemeory += itemMememory;
				
				trace("INITIALIZED:", (current) + "/" + initCount, "(" + (getTimer() - time) + "ms)", Number(itemMememory * 0.000000954 ).toFixed(3) + " MB", item.name || "");
				disposeItems.push(item);
				head = item.next;
				item = (getTimer() - st) < timeOut ? head : null;
			}
		}
		
		public function dispose():void 
		{
			trace("INIT DISPOSE");			
			
			for (var item:ZvrInitializerItem = tail; item; item = disposeItems.pop())
			{
				item.dispose();
			}
			
			sp.removeEventListener(Event.ENTER_FRAME, initEnterFrame);
			sp = null;
			head = null;
			tail = null;
			disposeItems = null;
			report = null;
			complete = null;
			
		}
		
	}

}