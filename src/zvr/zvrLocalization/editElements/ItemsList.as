package zvr.zvrLocalization.editElements 
{
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.IZvrSimpleDataItem;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrSimpeDataContainer;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	import zvr.zvrLocalization.ZvrLocEdit;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ItemsList extends ZvrSimpeDataContainer
	{
		private var _items:Array;
		
		public function ItemsList(verticalScroll:ZvrScroll, horizontalScroll:ZvrScroll) 
		{
			super(Item, verticalScroll, horizontalScroll);
			
			setLayout(ZvrVerticalLayout);
			
		}
		
		override protected function updateItem(item:IZvrSimpleDataItem, index:int):void 
		{
			var i:Item = item as Item;
			
			if (!_items || index >= _items.length) 
			{
				i.item = null;
				return;
			}
			
			i.item = _items[index];
		}
		
		public function update(items:Array):void
		{
			_items = items;
			
			updateList(_items.length);
		}
		
		override protected function getNewListItem(index:int):IZvrSimpleDataItem 
		{
			var l:Item = new Item();
			
			l.addEventListener(MouseEvent.CLICK, itemSelected);
			
			return l;
		}
		
		private function itemSelected(e:MouseEvent):void 
		{
			trace("itemClick");
			
			ZvrLocEdit.currentItem = Item(e.currentTarget).item;
			
		}
		
	}

}