package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.core.IZvrSelectable;
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
	 
	public class RadioGroupMD extends ZvrGroup
	{
		
		private var _selected:ZvrComponent;		
		
		public function RadioGroupMD() 
		{
			addEventListener(ZvrContainerEvent.ELEMENT_ADDED, elementAdded);
			addEventListener(ZvrContainerEvent.ELEMENT_REMOVED, elementRemoved);
		}
		
		private function elementAdded(e:ZvrContainerEvent):void 
		{
			e.element.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, itemSelectionChange);
		}
		
		private function elementRemoved(e:ZvrContainerEvent):void 
		{
			e.element.removeEventListener(ZvrSelectedEvent.SELECTED_CHANGE, itemSelectionChange);
		}
		
		private function itemSelectionChange(e:ZvrSelectedEvent):void 
		{
			if (_selected)
			{
				IZvrSelectable(_selected).selected = false;
			}
			
			if (e.selected)
			{
				_selected = e.component;
			}
			else
			{
				_selected = null;
			}
			
			dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, _selected, _selected ? true : false));
			
		}
	}

}