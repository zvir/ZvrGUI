package clv.gui.components.dataList 
{
	import clv.gui.core.IComponent;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IDataListItem extends IComponent
	{
		function get next():IDataListItem
		function set next(v:IDataListItem):void;
		
		function get prev():IDataListItem
		function set prev(v:IDataListItem):void;
		
		function setItemAfterPosition(listPostition:Number, itemPosition:int):Boolean;
		function setItemBeforePosition(position:Number, itemPosition:int):Boolean;
		
		function getPercentScrol(v:Number):Number;
		
		function getEnd():Number;
	}
	
}