package zvr.zvrGUI.core.relays 
{
	import flash.display.DisplayObject;
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.core.IZvrSelectable;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "selectedChange",    type = "zvr.zvrGUI.events.ZvrSelectedEvent")]
	
	public class ZvrSwitchGroup extends ZvrGroup 
	{
		private var _selected:ZvrComponent;		
		private var _lastSelected:ZvrComponent;		
		private var _selececNoneAllowed:Boolean;
		
		
		public function ZvrSwitchGroup() 
		{
			addEventListener(ZvrContainerEvent.ELEMENT_ADDED, elementAdded);
			addEventListener(ZvrContainerEvent.ELEMENT_REMOVED, elementRemoved);
		}
		
		private function elementAdded(e:ZvrContainerEvent):void 
		{
			e.element.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, itemSelectionChange);
			
			if (e.element is IZvrSelectable && IZvrSelectable(e.element).selected)
			{
				selectElement(e.element as IZvrSelectable);
			}
		}
		
		private function elementRemoved(e:ZvrContainerEvent):void 
		{
			e.element.removeEventListener(ZvrSelectedEvent.SELECTED_CHANGE, itemSelectionChange);	
			if (e.element is IZvrSelectable && IZvrSelectable(e.element).selected)
			{
				selectElement(null);
			}
		}
		
		private function selectElement(s:IZvrSelectable):void
		{
			if (_selected && s)
			{
				if (!_selececNoneAllowed)
				{
					_selected.behaviors.getBehavior(ZvrSelectable.NAME).enabled = true;
				}
				
				IZvrSelectable(_selected).selected = false;
			}
			
			if (s)
			{
				_selected = s as ZvrComponent;
				
				if (!_selececNoneAllowed)
				{
					_selected.behaviors.getBehavior(ZvrSelectable.NAME).enabled = false;
				}
				
			}
			else
			{
				_selected = null;
			}
			
			dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, _selected, _selected ? true : false));
		}
		
		private function itemSelectionChange(e:ZvrSelectedEvent):void 
		{
			if (e.selected) selectElement(e.component as IZvrSelectable);
		}
		
		public function get selececNoneAllowed():Boolean 
		{
			return _selececNoneAllowed;
		}
		
		public function set selececNoneAllowed(value:Boolean):void 
		{
			_selececNoneAllowed = value;
			
			if (_selected)
			{
				_selected.behaviors.getBehavior(ZvrSelectable.NAME).enabled = _selececNoneAllowed;
			}
		}
		
		public function get selected():ZvrComponent 
		{
			return _selected;
		}
		
	}

}