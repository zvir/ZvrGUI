package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "selectedChange",    type = "ZvrSelectedEvent")]
	
	public interface IZvrSelectable 
	{
		function set selected(v:Boolean):void
		function get selected():Boolean;
	}
	
}