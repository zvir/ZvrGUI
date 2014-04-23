package clv.gui.core.display 
{
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IContainerMask 
	{
		function updateMask(top:Number, left:Number, width:Number, height:Number):void;
		
		function set enabled(v:Boolean):void;
		
	}
	
}