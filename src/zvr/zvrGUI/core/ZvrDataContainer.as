package zvr.zvrGUI.core 
{

	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	/*import mx.collections.ArrayCollection;
	import mx.events.CollectionEvent;
	import mx.events.CollectionEventKind;*/
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrDataContainerEvent;
	import zvr.zvrGUI.layouts.data.ZvrDataLayout;
	import zvr.zvrGUI.managers.ZvrDataItemsManager;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */

	
	[Event (name = "itemRendererCreated",	type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "selectionChange",		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	
	[Event (name = "item_mouseDown",		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseUp",    		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseClick",   	type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseMove",    	type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_doubleClick",		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseOut",    		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseOver",		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_mouseWheel",		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "ritem_rollOut",    		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	[Event (name = "item_rollOver",    		type = "zvr.zvrGUI.events.ZvrDataContainerEvent")]
	
	
	public class ZvrDataContainer extends ZvrContainer 
	{
		
		/*private var _dataProvider:ArrayCollection;*/
		private var _virtualContent:ZvrDataVirtualContent = new ZvrDataVirtualContent();
		private var _itemsManager:ZvrDataItemsManager;
		private var _layout:ZvrDataLayout;
		private var _virtualBoundsPosition:Point = new Point();
		
		private const ITEM_EVENTS:Array = [
			ZvrDataContainerEvent.ITEM_DOUBLE_CLICK,
			ZvrDataContainerEvent.ITEM_MOUSE_CLICK,
			ZvrDataContainerEvent.ITEM_MOUSE_DOWN,
			ZvrDataContainerEvent.ITEM_MOUSE_MOVE,
			ZvrDataContainerEvent.ITEM_MOUSE_OUT,
			ZvrDataContainerEvent.ITEM_MOUSE_OVER,
			ZvrDataContainerEvent.ITEM_MOUSE_UP,
			ZvrDataContainerEvent.ITEM_MOUSE_WHEEL,
			ZvrDataContainerEvent.ITEM_ROLL_OUT,
			ZvrDataContainerEvent.ITEM_ROLL_OVER
		];
		
		public function ZvrDataContainer(skinClass:Class) 
		{
			super(skinClass);
			
			_itemsManager = new ZvrDataItemsManager(this, _virtualContent);
			_layout = new ZvrDataLayout(this, _virtualContent, _itemsManager);
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			_layout.update(virtualBounds);
		}
		
		private function updateAllItems():void
		{
			//if (!_dataProvider) return;
			_layout.updateItemsBounds();
		}
		/*
		private function addEventListenersToDataProvider():void
		{
			_dataProvider.addEventListener(CollectionEvent.COLLECTION_CHANGE, dataProviderChange);
		}
		*//*
		private function removeEventListenersFromDataProvider():void
		{
			_dataProvider.removeEventListener(CollectionEvent.COLLECTION_CHANGE, dataProviderChange);
		}
		*/
		private function get virtualBounds():Rectangle
		{
			return new Rectangle(_virtualBoundsPosition.x, _virtualBoundsPosition.y, bounds.width, bounds.height);
		}
		/*
		public function get dataProvider():ArrayCollection 
		{
			return _dataProvider;
		}*/
		/*
		public function set dataProvider(value:ArrayCollection):void 
		{
			if (_dataProvider) removeEventListenersFromDataProvider();
			
			_dataProvider = value;
			
			if (_dataProvider)
			{
				updateAllItems();
				_layout.update(virtualBounds);
				addEventListenersToDataProvider();
			}
		}
		*/
		public function set itemRendererClass(value:Class):void 
		{
			_itemsManager.itemRendererClass = value;
		}
		
		override public function setLayout(value:Class):void 
		{
			_layout.remove();
			_layout = new value(this, _virtualContent, _itemsManager);
			updateAllItems();
		}
		
		public function getLayout():ZvrDataLayout 
		{
			return _layout;
		}
		/*
		private function dataProviderChange(e:CollectionEvent):void 
		{
			
			//trace("dataProviderChange", e.kind, e.items, e.location, e.oldLocation);
			
			switch (e.kind) 
			{
				case CollectionEventKind.ADD: itemAdded(e.location);  break;
				case CollectionEventKind.MOVE: itemMoved();  break;
				case CollectionEventKind.REFRESH: itemMoved(); break;
				case CollectionEventKind.REMOVE: itemRemoved(e.location);  break;
				case CollectionEventKind.REPLACE: itemReplace();  break;
				case CollectionEventKind.RESET: break;
				case CollectionEventKind.UPDATE: break;
			}
		}
		*/
		private function itemAdded(changeIndex:int):void
		{
			_layout.updateItemsBounds(changeIndex);
			_layout.update(virtualBounds);
		}
		
		private function itemMoved():void
		{
			trace("itemMoved");
		}
		
		private function itemRemoved(changeIndex:int):void
		{	
			_virtualContent.deleteItemAt(changeIndex);
			_layout.updateItemsBounds();
			_layout.update(virtualBounds);
		}
		
		private function itemReplace():void
		{
			trace("itemReplace");
		}
		
		public function setContentPosition(x:Number, y:Number):void
		{
			_virtualBoundsPosition.x = Math.round(x);
			_virtualBoundsPosition.y = Math.round(y);
			
			var t:int = getTimer();
			_layout.update(virtualBounds);
			
		}
		
		public function deselectItem(index:int):void 
		{
			//trace("deselectItem", index);
			var item:ZvrVirtualItemRenderer = _virtualContent.getElementAt(index);
			if (!item) return;
			_itemsManager.setSelectItem(index, false);
		}
		
		public function selectItem(index:int):void 
		{
			//trace("selectItem", index);
			var item:ZvrVirtualItemRenderer = _virtualContent.getElementAt(index);
			if (!item) return;
			_itemsManager.setSelectItem(index, true);
		}
		
		public function set scroll(scroll:ZvrScroller):void
		{
			_layout.scroll = scroll;
			_layout.update(virtualBounds);
		}
		
		public function get multiSelect():Boolean 
		{
			return _itemsManager.multiSelect;
		}
		
		public function set multiSelect(value:Boolean):void 
		{
			_itemsManager.multiSelect = value;
		}
		
		override public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			if (isItemEvent(type))
			{
				_itemsManager.addItemsEvent(type);
			}
			super.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		
		override public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			if (isItemEvent(type))
			{
				_itemsManager.removeItemsEvent(type);
			}
			super.removeEventListener(type, listener, useCapture);
		}
		
		private function isItemEvent(type:String):Boolean 
		{
			return ITEM_EVENTS.indexOf(type) >= 0;
		}
		
		
	}

}