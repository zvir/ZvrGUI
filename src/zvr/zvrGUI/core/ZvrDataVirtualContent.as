package zvr.zvrGUI.core 
{
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrDataVirtualContent 
	{
		
		private var _items:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
		
		
		public function ZvrDataVirtualContent() 
		{
			
		}
		
		public function getItem(index:int):ZvrVirtualItemRenderer
		{
			
			var item:ZvrVirtualItemRenderer;
			
			if (index >= _items.length) 
			{
				item = new ZvrVirtualItemRenderer(_items.length);
				_items.push(item);
				return item;
			}
			
			return _items[index];
		}
		
		public function deleteItem(item:ZvrVirtualItemRenderer):void
		{
			deleteItemAt(item.index);
		}
		
		public function deleteItemAt(index:int):ZvrVirtualItemRenderer
		{
			var item:ZvrVirtualItemRenderer = _items.splice(index, 1) as ZvrVirtualItemRenderer;
			
			for (var i:int = index; i < _items.length; i++) 
			{
				_items[i].index = i;
			}
			
			return item;
		}
		
		public function getElementAt(index:int):ZvrVirtualItemRenderer
		{
			if (index < 0) return null;
			if (index >= _items.length) return null;
			
			return _items[index];
		}
		
		public function changeItemIndex(oldIndex:int, newIndex:int):void
		{
			_items.splice(newIndex, 0, _items.splice(oldIndex, 1));
		}
		
		public function getItemsInBounds(bounds:Rectangle):Vector.<ZvrVirtualItemRenderer>
		{
			var a:Vector.<ZvrVirtualItemRenderer> = new Vector.<ZvrVirtualItemRenderer>();
			
			for each (var item:ZvrVirtualItemRenderer in _items) 
			{
				if (item.bounds.intersects(bounds)) a.push(item);
			}
			
			a.sort(sortItems);
			
			return a;
		}
		
		
		private function sortItems(item1:ZvrVirtualItemRenderer, item2:ZvrVirtualItemRenderer):Number
		{
			if (item1.index < item2.index)
				return -1; 
			else
				return 1;
		}
		
		public function get items():Vector.<ZvrVirtualItemRenderer> 
		{
			return _items;
		}
		
		
	}
}