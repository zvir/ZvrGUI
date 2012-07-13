package zvr.zvrGUI.managers 
{
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.ZvrDataContainer;
	import zvr.zvrGUI.core.ZvrDataVirtualContent;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrGUI.events.ZvrDataContainerEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrDataItemsManager 
	{
		private const _maxRemoveRequests:int = 25;
		
		protected var _dataContainer:ZvrDataContainer;
		
		private var _removeRequests:int = 0;
		private var _itemsToRemove:int = 0;
		private var _itemRenderers:Vector.<ZvrItemRenderer> = new Vector.<ZvrItemRenderer>();
		private var _itemRendererClass:Class;
		private var _itemTester:ZvrItemRenderer;
		private var _itemEvents:Array = new Array();
		
		private var _selectedItemsIndexes:Vector.<int> = new Vector.<int>();
		
		private var _virtualContent:ZvrDataVirtualContent;
		
		private var _multiSelect:Boolean = true;
		
		public function ZvrDataItemsManager(dataContainer:ZvrDataContainer, virtualContent:ZvrDataVirtualContent) 
		{
			_virtualContent = virtualContent;
			_dataContainer = dataContainer;
		}
		
		private function createItemRenderer():ZvrItemRenderer
		{
			var item:ZvrItemRenderer = new _itemRendererClass() as ZvrItemRenderer;
			item.dataContainer = _dataContainer;
			_itemRenderers.push(item);
			
			item.addEventListener(MouseEvent.CLICK, itemMouseEvent);
			item.addEventListener(MouseEvent.DOUBLE_CLICK, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_DOWN, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_MOVE, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_OUT, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_OVER, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_UP, itemMouseEvent);
			item.addEventListener(MouseEvent.MOUSE_WHEEL, itemMouseEvent);
			item.addEventListener(MouseEvent.ROLL_OUT, itemMouseEvent);
			item.addEventListener(MouseEvent.ROLL_OVER, itemMouseEvent);
			
			item.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selectedChange);
			
			return item;
		}
		
		private function selectedChange(e:ZvrSelectedEvent):void 
		{
			var item:ZvrItemRenderer = e.component as ZvrItemRenderer;
			var i:int = _selectedItemsIndexes.indexOf(item.index);
			
			if (_multiSelect)
			{
				if (e.selected)
				{
					if (i == -1)
					{
						_selectedItemsIndexes.push(item.index);
					}
				}
				else
				{
					if (i != -1)
					{
						_selectedItemsIndexes.splice(i, 1);
					}
				}
			}
			else
			{	
				for (var j:int = 0; j < _selectedItemsIndexes.length; j++) 
				{
					_virtualContent.getItem(_selectedItemsIndexes[j]).setSelected(false);
				}
				
				_selectedItemsIndexes.length = 0;
				
				if (e.selected)
				{
					_selectedItemsIndexes.push(item.index);
				}
				
			}
			
			_virtualContent.getItem(item.index).selected = e.selected;
			
			_dataContainer.dispatchEvent(new ZvrDataContainerEvent(ZvrDataContainerEvent.SELECTED_CHANGE, [e.currentTarget], _selectedItemsIndexes));
		}
		
		private function itemMouseEvent(e:MouseEvent):void 
		{
			var type:String = "item_" + e.type;
			
			if (hasItemEvent(type))
			{
				_dataContainer.dispatchEvent(new ZvrDataContainerEvent(type, [e.currentTarget], _selectedItemsIndexes));
			}
			
		}
		
		public function getItemRenderer(index:int):ZvrItemRenderer
		{
			var item:ZvrItemRenderer;
			
			if (index >= _itemRenderers.length) 
			{
				item = createItemRenderer();
			}
			else
			{
				item = _itemRenderers[index];
			}
			
			if (item.owner != _dataContainer)
			{
				_dataContainer.addChild(item);
			}
			
			return item;
		}
		
		public function get itemRenderers():Vector.<ZvrItemRenderer>
		{
			return _itemRenderers;
		}
		
		public function getNewItemRenderer():ZvrItemRenderer
		{
			var item:ZvrItemRenderer = createItemRenderer();
			_dataContainer.addChild(item);
			return item;
		}
		
		public function validateItemRenderer(item:ZvrItemRenderer):void 
		{
			if (!item.visible)
			{
				item.visible = true;
			}
		}
		
		private function itemsRenderersToRemove(length:int):void 
		{
			if (Math.abs(_itemsToRemove - length) < 2)
			{
				_itemsToRemove = length;
				_removeRequests++;
			}
			else
			{
				_removeRequests = 0;
			}
		}
		
		public function removeItemRenderers(items:Vector.<ZvrItemRenderer>):void 
		{
			itemsRenderersToRemove(items.length);
			
			var removeFromArray:Boolean = false;
			
			if (_removeRequests > _maxRemoveRequests && _itemsToRemove > 2)
			{
				removeFromArray = true;
				_removeRequests = 0;
			}
			
			for each (var item:ZvrItemRenderer in items) 
			{
				item.visible = false;
				
				if (removeFromArray)
				{
					if (item.owner == _dataContainer) _dataContainer.removeChild(item);
					_itemRenderers.splice(_itemRenderers.indexOf(item), 1);
					
					item.removeEventListener(MouseEvent.CLICK, itemMouseEvent);
					item.removeEventListener(MouseEvent.DOUBLE_CLICK, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_DOWN, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_MOVE, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_OUT, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_OVER, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_UP, itemMouseEvent);
					item.removeEventListener(MouseEvent.MOUSE_WHEEL, itemMouseEvent);
					item.removeEventListener(MouseEvent.ROLL_OUT, itemMouseEvent);
					item.removeEventListener(MouseEvent.ROLL_OVER, itemMouseEvent);
					
					item.removeEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selectedChange);
				}
				
			}
		}
		
		public function hasItemEvent(type:String):Boolean
		{
			return _itemEvents.indexOf(type) >= 0;
		}
		
		public function addItemsEvent(type:String):void
		{
			if (!hasItemEvent(type))
			{
				_itemEvents.push(type);
			}
		}
		
		public function removeItemsEvent(type:String):void
		{	
			var i:int = _itemEvents.indexOf(type);
			
			if (i != -1)
			{
				_itemEvents.splice(i, 1);
			}
		}
		
		public function get itemTester():ZvrItemRenderer 
		{
			return _itemTester;
		}
		
		public function get itemRendererClass():Class 
		{
			return _itemRendererClass;
		}
		
		public function set itemRendererClass(value:Class):void 
		{
			_itemRendererClass = value;
			_itemTester = new _itemRendererClass();
		}
		
		public function get itemEvents():Array 
		{
			return _itemEvents;
		}
		
		public function get multiSelect():Boolean 
		{
			return _multiSelect;
		}
		
		public function set multiSelect(value:Boolean):void 
		{
			_multiSelect = value;
		}
		
		
		
		
	}

}

