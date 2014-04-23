package clv.gui.core.display 
{
	import clv.gui.core.skins.ISkin;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IComponentBody 
	{
		
		function set x(v:Number):void;
		function set y(v:Number):void;
		
		function set visible(v:Boolean):void;
		
		function get displayBody():*
		
	}
	
}