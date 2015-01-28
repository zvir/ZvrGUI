package zvr.zvrGUI.behaviors 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import zvr.zvrGUI.core.IZvrVBooleanComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrKeyboard.ZvrKeyboard;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSelectable extends ZvrBehavior 
	{
		
		public static const NAME:String = "Selectable";
		
		// TODO resole keyboard with button behavior
		
		public function ZvrSelectable() 
		{
			super(NAME);
		}
		
		override protected function enable():void
		{
			if (!enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.addEventListener(TouchEvent.TOUCH_TAP, click, false, 99999);   
			/*}
			else
			{*/
				component.addEventListener(MouseEvent.CLICK, click, false, 99999);
			/*}*/
			
			tr("Toggle enabled");
		}
		
		override protected function disable():void
		{
			if (enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.removeEventListener(TouchEvent.TOUCH_TAP, click);   
			/*}
			else
			{*/
				component.removeEventListener(MouseEvent.CLICK, click);   
			/*}*/
			
			removeKeyboardEvents();
			
			tr("Toggle disabled");
		}
		
		private function click(e:Event):void 
		{
			toggleSelection();
			component.dispatchEvent(new ZvrEvent(ZvrEvent.USER_INPUT, component));
			
			tr("Toggle click");
		}
		
		private function toggleSelectionByKeyboard():void 
		{
			toggleSelection();
			component.dispatchEvent(new ZvrEvent(ZvrEvent.USER_INPUT, component));
		}
		
		private function toggleSelection():void
		{
			
			tr("Toggle toggle selection");
			
			if (component.checkState(ZvrStates.SELECTED))
			{
				component.removeState(ZvrStates.SELECTED);
				if (component is IZvrVBooleanComponent) IZvrVBooleanComponent(component).change.dispatch(false);
			}
			else
			{
				component.addState(ZvrStates.SELECTED);
				if (component is IZvrVBooleanComponent) IZvrVBooleanComponent(component).change.dispatch(true);
			}
		}
		
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew(ZvrStates.FOCUSED))
			{
				addKeyboardEvents()
			}
			else if (e.isRemoved(ZvrStates.FOCUSED))
			{
				removeKeyboardEvents();
			}
		}
		
		private function addKeyboardEvents():void
		{
			ZvrKeyboard.SPACE.addReleasedCallback(toggleSelectionByKeyboard);
			ZvrKeyboard.ENTER.addReleasedCallback(toggleSelectionByKeyboard);
			ZvrKeyboard.NUMPAD_ENTER.addReleasedCallback(toggleSelectionByKeyboard);
		}
		
		private function removeKeyboardEvents():void
		{
			ZvrKeyboard.SPACE.removeReleasedCallback(toggleSelectionByKeyboard);
			ZvrKeyboard.ENTER.removeReleasedCallback(toggleSelectionByKeyboard);
			ZvrKeyboard.NUMPAD_ENTER.removeReleasedCallback(toggleSelectionByKeyboard);
		}
		
		override public function destroy():void
		{
			disable();
		}
		
		
	}

}