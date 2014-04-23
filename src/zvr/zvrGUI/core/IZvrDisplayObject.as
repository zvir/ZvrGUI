package zvr.zvrGUI.core 
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrDisplayObject  extends IEventDispatcher
	{
		function set x(value:Number):void;
		function set y(value:Number):void;

		function get x():Number;
		function get y():Number;
		
		function set visible(v:Boolean):void
		
		function get stage():Stage;
		
		function get mouseX():Number;
		function get mouseY():Number;
		
		
	}
	
}