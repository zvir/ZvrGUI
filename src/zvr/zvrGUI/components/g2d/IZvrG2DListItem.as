package zvr.zvrGUI.components.g2d 
{
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrG2DListItem 
	{
		
		function setItemAfterPosition(listPostition:Number, itemPosition:Number):Boolean;
		
		function setItemBeforePosition(position:Number, itemPosition:int):Boolean;
		
		function getPercentScrol(v:Number):Number;
	}
	
}