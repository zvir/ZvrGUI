package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.core.IZvrSelectable;
	import zvr.zvrGUI.core.relays.ZvrSwitchGroup;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "selectedChange",    type = "zvr.zvrGUI.events.ZvrSelectedEvent")]
	 
	public class RadioGroupMD extends ZvrSwitchGroup
	{

		public function RadioGroupMD() 
		{
			super();
		}
		
	}

}