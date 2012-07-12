package zvr.zvrGUI.layouts.data 
{
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import mx.collections.ArrayCollection;
	import zvr.zvrGUI.core.ZvrDataContainer;
	import zvr.zvrGUI.core.ZvrDataVirtualContent;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrVirtualItemRenderer;
	import zvr.zvrGUI.managers.ZvrDataItemsManager;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrDataLayout 
	{
		protected var _startIndex:int;
		protected var _endIndex:int;
		
		protected const SIZE:int = 8;
		
		protected var _currentVirtualItems:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
		protected var _itemsManager:ZvrDataItemsManager;
		protected var _virtualContent:ZvrDataVirtualContent;
		protected var _itemRenderers:Vector.<ZvrItemRenderer> = new Vector.<ZvrItemRenderer>();
		protected var _dataContainer:ZvrDataContainer;
		protected var _scroll:ZvrScroller
		protected var _updateFromIndex:int;
		protected var _variableItemsSize:Boolean = false;
		
		public function ZvrDataLayout(dataContainer:ZvrDataContainer, virtualContent:ZvrDataVirtualContent, itemsManager:ZvrDataItemsManager) 
		{
			_itemsManager = itemsManager;
			_dataContainer = dataContainer;
			_virtualContent = virtualContent;
		}
		
		public function update(bounds:Rectangle):void
		{
			
			_startIndex = calculateFirstIndexInView(bounds);
			_endIndex = calculateLastIndexInView(_startIndex, bounds);
			
			var t:int = getTimer();
			var d:int = getTimer();
			var s:int = 0;
			var i:int;
			
			var virtualItemsToProcess:Vector.<ZvrVirtualItemRenderer> = _virtualContent.items.slice(_startIndex, _endIndex+1);
			var itemRenderersToProcess:Vector.<ZvrItemRenderer> = _itemsManager.itemRenderers;
			var freeItemsRenderers:Vector.<ZvrItemRenderer> = itemRenderersToProcess.slice();
			var currentItemRenderes:Vector.<ZvrItemRenderer> = new Vector.<ZvrItemRenderer>();
			var currentVirtualItems:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
			var newVirtualItems:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
			var newCurrentVirtualItems:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
			var itemsTorReuse:Vector.<ZvrItemRenderer>;
			
			for (i = 0; i < virtualItemsToProcess.length; i++) 
			{
				var virtualItemUsed:Boolean = false;
				
				for (var j:int = 0; j < itemRenderersToProcess.length; j++) 
				{
					if (virtualItemsToProcess[i].itemRenderer != null && virtualItemsToProcess[i].itemRenderer == itemRenderersToProcess[j])
					{
						virtualItemUsed = true;
						currentVirtualItems.push(virtualItemsToProcess[i]);
						newCurrentVirtualItems.push(virtualItemsToProcess[i]);
						currentItemRenderes.push(itemRenderersToProcess[j]);
						freeItemsRenderers.splice(freeItemsRenderers.indexOf(itemRenderersToProcess[j]), 1);
					}
				}
				if (!virtualItemUsed) newVirtualItems.push(virtualItemsToProcess[i]);
			}
			
			for (i = 0; i < _currentVirtualItems.length; i++) 
			{
				_currentVirtualItems[i].itemRenderer = null;
			}
			
			_currentVirtualItems = newCurrentVirtualItems.slice();
			
			for (i = 0; i < currentItemRenderes.length; i++) 
			{
				_currentVirtualItems[i].itemRenderer = currentItemRenderes[i];
			}

			_currentVirtualItems = _currentVirtualItems.concat(newVirtualItems);
			
			for (i = 0; i < currentVirtualItems.length; i++) 
			{
				updateItem(currentVirtualItems[i], bounds);
			}
			
			for (i = 0; i < newVirtualItems.length; i++)
			{
				var item:ZvrItemRenderer = freeItemsRenderers.length > 0 ? freeItemsRenderers.pop() : _itemsManager.getNewItemRenderer();
				var vItem:ZvrVirtualItemRenderer = newVirtualItems[i];
				vItem.itemRenderer = item;
				updateItem(vItem, bounds);
				_itemsManager.validateItemRenderer(item);
			}
			
			_itemsManager.removeItemRenderers(freeItemsRenderers);
			
		}
		
		protected function updateItem(virtual:ZvrVirtualItemRenderer, bounds:Rectangle):void
		{
			if (virtual.data != virtual.itemRenderer.data) virtual.itemRenderer.data = virtual.data;
			if (virtual.selected != virtual.itemRenderer.selected) virtual.itemRenderer.selected = virtual.selected;
			if (virtual.index != virtual.itemRenderer.index) virtual.itemRenderer.index = virtual.index;
		}
		
		public function updateItemsBounds(fromIndex:int = 0):void 
		{
			
		}
		
		public function remove():void 
		{
			_virtualContent = null;
			_itemRenderers = null;
			_dataContainer = null;
		}
		
		public function get scroll():ZvrScroller 
		{
			return _scroll;
		}
		
		public function set scroll(value:ZvrScroller):void 
		{
			_scroll = value;
		}
		
		public function get variableItemsSize():Boolean 
		{
			return _variableItemsSize;
		}
		
		public function set variableItemsSize(value:Boolean):void 
		{
			_variableItemsSize = value;
		}
		
		protected function calculateFirstIndexInView(bounds:Rectangle):int
		{
			return 0;
		}
		
		protected function calculateLastIndexInView(start:int, bounds:Rectangle):int
		{
			return 0;
		}
		
	}

}