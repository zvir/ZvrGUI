package zvr.zvrGUI.core.custom 
{
	import zvr.zvrGUI.core.IZvrComponent;
	import clv.gui.core.IComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrDataListItem extends IComponent
	{
		
		function get next():IZvrDataListItem
		function set next(v:IZvrDataListItem):void;
		
		function get prev():IZvrDataListItem
		function set prev(v:IZvrDataListItem):void;
		
		function setItemAfterPosition(listPostition:Number, itemPosition:int):Boolean;
		function setItemBeforePosition(position:Number, itemPosition:int):Boolean;
		
		function getPercentScrol(v:Number):Number;
		
		function getEnd():Number;
	}
	
}