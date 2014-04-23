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
		public var error:Function;
		private var reporting:Boolean;
		private var waitingForEvent:ZvrInitializerItem;
		
		public function ZvrInitializer()
		{
		
		}
		
		public function init():void
		{
			CONFIG::debug
			{
				tr("ADDING TIME (" + (getTimer() - addingStart) + "ms)");
				tr("INIT START");
			}
			time = getTimer();
			sTime = time;
			sp.addEventListener(Event.ENTER_FRAME, initEnterFrame);
			
			stepTime = getTimer();
			
			if (report != null && head)
			{
				report((current + 1) / initCount, head.name || "");
			}
		
		}
		
		public function addInit(initFinction:Function, thisObject:* = null, name:String = null, ... rest):ZvrInitializerItem
		{
			initCount++;
			
			if (addingStart == 0)
				addingStart = getTimer();
			CONFIG::debug
			{
				tr("ADDING INIT:", initCount, "(" + (time == 0 ? "?" : (getTimer() - time)) + "ms)", name);
			}
			time = getTimer();
			
			var initItem:ZvrInitializerItem = new ZvrInitializerItem();
			
			initItem.initializer = this;
			initItem.initFinction = initFinction;
			initItem.thisObject = thisObject;
			initItem.name = name;
			initItem.args = rest;
			
			if (!head)
				head = initItem;
			if (tail)
				tail.next = initItem;
			initItem.prev = tail;
			tail = initItem;
			
			return initItem;
		
		}
		
		public function addCnst(thisObject:Object, property:String, cl:Class, name:String = null):void
		{
			initCount++;
			
			if (addingStart == 0)
				addingStart = getTimer();
			CONFIG::debug
			{
				tr("ADDING CONSTRUCTOR:", initCount, "(" + (time == 0 ? "?" : (getTimer() - time)) + "ms)", name);
			}
			time = getTimer();
			
			var initItem:ZvrInitializerItem = new ZvrInitializerItem();
			initItem.constructorClass = cl;
			initItem.thisObject = thisObject;
			initItem.property = property;
			initItem.name = name;
			
			if (!head)
				head = initItem;
			if (tail)
				tail.next = initItem;
			initItem.prev = tail;
			tail = initItem;
		}
		
		private function initEnterFrame(e:Event):void
		{
			
			stepTime = getTimer();
			
			if (reporting || waitingForEvent)
			{
				makeReport();
				return;
			}
			
			if (!head)
			{
				initComplete();
				return;
			}
			
			reporting = true;
			
			var st:int = getTimer();
			var item:ZvrInitializerItem = head;
			
			while (item)
			{
				time = getTimer();
				
				itemMememory = System.totalMemory;
				
				if (item.eventType)
				{
					item.eventObject.addEventListener(item.eventType, continiueEvent);
					
					waitingForEvent = item;
					
					if (initItem(item))
						return;
					CONFIG::debug
					{
						tr("WAITING FOR EVENT:", item.eventType, " FROM:", item.name || "", item.eventObject);
					}
				}
				
				if (initItem(item))
					return;
				
				current++;
				
				itemMememory = System.totalMemory - itemMememory;
				
				totalMemeory += itemMememory;
				
				CONFIG::debug
				{
					tr("INITIALIZED:", (current) + "/" + initCount, "(" + (getTimer() - time) + "ms)", Number(itemMememory * 0.000000954).toFixed(3) + " MB, ", item.name || "");
				}
				disposeItems.push(item);
				
				head = item.next;
				
				item = (getTimer() - st) < timeOut ? head : null;
			}
		
		}
		
		private function continiueEvent(e:Event):void
		{
			waitingForEvent.eventObject.removeEventListener(waitingForEvent.eventType, continiueEvent);
			
			current++;
			
			itemMememory = System.totalMemory - itemMememory;
			
			totalMemeory += itemMememory;
			
			CONFIG::debug
			{
				tr("INITIALIZED:", (current) + "/" + initCount, "(" + (getTimer() - time) + "ms)", Number(itemMememory * 0.000000954).toFixed(3) + " MB,", waitingForEvent.name || "");
			}
			
			disposeItems.push(waitingForEvent);
			head = waitingForEvent.next;
			waitingForEvent = null;
		
		}
		
		private function makeReport():void
		{
			reporting = false;
			if (report == null || !head || !head.next)
				return;
			report((current + 1) / initCount, head.next.name || "");
		}
		
		private function reportError(err:Error):void
		{
			CONFIG::debug
			{
				tr("Error", err.errorID, err.name, err.message);
			}
			sp.removeEventListener(Event.ENTER_FRAME, initEnterFrame);
			
			if (error != null)
				error(head.name || "", err);
		}
		
		private function initComplete():void
		{
			CONFIG::debug
			{
				tr("INIT DONE", (getTimer() - sTime) + "ms", Number(totalMemeory * 0.000000954).toFixed(3) + " MB");
			}
			sp.removeEventListener(Event.ENTER_FRAME, initEnterFrame);
			
			if (complete != null)
				complete();
			
			dispose();
		}
		
		private function initItem(item:ZvrInitializerItem):Boolean
		{
			
			item.init();
			return false
			try
			{
				item.init();
				return false
			}
			catch (err:Error)
			{
				reportError(err);
				return true;
			}
			return false;
		}
		
		public function dispose():void
		{
			CONFIG::debug
			{
				tr("INIT DISPOSE");
			}
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