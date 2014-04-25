package clv.gui.g2d.components.list 
{
	import clv.games.dribbler2.view.screens.ListItem;
	import clv.gui.components.dataList.IDataListItem;
	import clv.gui.components.dataList.ListItemVertical;
	import clv.gui.g2d.components.GroupG2D;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ListItemVerticalG2D extends GroupG2D implements IDataListItem
	{
		private var _listItem:ListItemVertical;
		
		public function ListItemVerticalG2D() 
		{
			super();
			_listItem = new ListItemVertical(this);
		}
		
		public function setItemAfterPosition(listPostition:Number, itemPosition:int):Boolean
		{
			node.setActive(true);
			return _listItem.setItemAfterPosition(listPostition, itemPosition);
		}
		
		public function setItemBeforePosition(position:Number, itemPosition:int):Boolean 
		{
			node.setActive(false);
			return _listItem.setItemBeforePosition(position, itemPosition);
		}
		
		public function getPercentScrol(v:Number):Number 
		{
			return _listItem.getPercentScrol(v);
		}
		
		public function getEnd():Number 
		{
			return _listItem.getEnd();
		}
		
		public function get next():IDataListItem 
		{
			return _listItem.next;
		}
		
		public function set next(value:IDataListItem):void 
		{
			_listItem.next = value;
		}
		
		public function get prev():IDataListItem 
		{
			return _listItem.prev;
		}
		
		public function set prev(value:IDataListItem):void 
		{
			_listItem.prev = value;
		}
		
	}

}