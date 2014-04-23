package zvr.zvrGUI.core.data 
{
	import flash.display.DisplayObject;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrDataListEvent;
	import zvr.zvrGUI.layouts.ZvrLayout;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "itemAdded",			type = "zvr.zvrGUI.events.ZvrDataListEvent")]
	[Event(name = "itemRemoved",		type = "zvr.zvrGUI.events.ZvrDataListEvent")]
	
	
	public class ZvrDataList extends ZvrContainer
	{
		
		protected var _dataLayout:ZvrDataLayout;
		protected var _listItems:Vector.<IZvrDataRenderer> = new Vector.<IZvrDataRenderer>();
		private var _data:Array;
		private var _dataItems:Vector.<ZvrDataListItem> = new Vector.<ZvrDataListItem>();
		private var _itemClass:Class;
		
		public function ZvrDataList(itemClass:Class, skinClass:Class) 
		{
			super(skinClass);
			_itemClass = itemClass;
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
			_listItems[0] = new _itemClass();
			addChild(_listItems[0] as ZvrComponent);
		}
		
		public function init():void
		{
			
			dispatchEvent(new ZvrDataListEvent(ZvrDataListEvent.ITEM_ADDED, this, _listItems[0]));
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			update();
		}
		
		private function updateItemCount():void
		{
			var c:int = _dataLayout.getItemsCount(childrenAreaWidth, childrenAreaHeight);
			
			for (var i:int = _listItems.length; i < c; i++) 
			{
				var it:IZvrDataRenderer = getNewListItem(i);
				addChild(it as DisplayObject);
				_listItems.push(it);
				dispatchEvent(new ZvrDataListEvent(ZvrDataListEvent.ITEM_ADDED, this, it));
			}
			
			while (_listItems.length > c+1)
			{
				it = _listItems.pop();
				removeChild(it as DisplayObject);
				dispatchEvent(new ZvrDataListEvent(ZvrDataListEvent.ITEM_REMOVED, this, it));
			}
			
		}
		
		protected function getNewListItem(index:int):IZvrDataRenderer 
		{
			return new _itemClass();
		}
		
		public function updateListContent(firstItem:int):void
		{
			for (var i:int = 0; i < _listItems.length; i++) 
			{
				var p:IZvrDataRenderer = _listItems[i];
				updateItem(p, i + firstItem);
			}
		}
		
		protected function updateItem(item:IZvrDataRenderer, index:int):void
		{
			if (_data && index < _data.length)
			{
				item.data = _dataItems[index];
			}
			else
			{
				item.data = null;
			}
		}
		
		public function setData(data:Array):void
		{
			_data = data;
			_dataItems.length = 0;
			
			for (var i:int = 0; i < _data.length; i++) 
			{
				var d:ZvrDataListItem = new ZvrDataListItem();
				d.data = _data[i];
				d.index = i;
				_dataItems.push(d);
			}
			
			update();
		}
		
		public function get dataLayout():ZvrDataLayout 
		{
			return _dataLayout;
		}
		
		override public function setLayout(layout:Class):void 
		{
			if (_dataLayout)
			{
				_dataLayout.dispose();
			}
			
			_dataLayout = new layout(this, _listItems);
			
			update();
		}
		
		public function update():void
		{
			if (_data && _dataLayout) 
			{
				updateItemCount();
				_dataLayout.update(childrenAreaWidth, childrenAreaHeight, _data.length);
			}
			
		}
		
		
	}

}