package zvr.zvrGUI.components.nd2d 
{
	import flash.display.DisplayObject;
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.components.nd2d.behaviors.ZvrND2DSelectable;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.IZvrSelectable;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "selectedChange",    type = "zvr.zvrGUI.events.ZvrSelectedEvent")]
	
	public class ZvrND2DSwishGroup extends ZvrND2DGroup 
	{
		private var _selected:IZvrComponent;		
		private var _lastSelected:IZvrComponent;		
		private var _selececNoneAllowed:Boolean;
		
		
		public function ZvrND2DSwishGroup() 
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
			if (_selected == s) return;
			
			if (_selected && _selected != s)
			{
				_selected.removeEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selededChange);
			}
			
			if (_selected && s)
			{
				/*if (!_selececNoneAllowed)
				{
					_selected.behaviors.getBehavior(ZvrND2DSelectable.NAME).enabled = true;
				}*/
				
				IZvrSelectable(_selected).selected = false;
			}
			
			if (s)
			{
				_selected = s as IZvrComponent;
				
				_selected.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selededChange);
				
				/*if (!_selececNoneAllowed)
				{
					_selected.behaviors.getBehavior(ZvrND2DSelectable.NAME).enabled = false;
				}*/
				
			}
			else
			{
				_selected = null;
			}
			
			dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, _selected, _selected ? true : false));
		}
		
		private function itemSelectionChange(e:ZvrSelectedEvent):void 
		{
			if (e.selected) 
			{
				selectElement(e.component as IZvrSelectable);
			}
		}
		
		private function selededChange(e:ZvrSelectedEvent):void 
		{
			if (!e.selected) 
			{
				selectElement(null);
			}
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
		
		public function get selected():IZvrComponent 
		{
			return _selected;
		}
		
	}

}