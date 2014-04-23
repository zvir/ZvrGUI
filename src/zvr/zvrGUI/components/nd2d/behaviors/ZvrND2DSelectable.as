package zvr.zvrGUI.components.nd2d.behaviors 
{

	import flash.events.Event;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSelectable extends ZvrBehavior 
	{
		
		public static const NAME:String = "ND2DSelectable";
		
		// TODO resole keyboard with button behavior
		
		public var unselectByInput:Boolean = true;
		
		public function ZvrND2DSelectable() 
		{
			super(NAME);
		}
		
		override protected function enable():void
		{
			if (!enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{
				component.addEventListener(TouchEvent.TOUCH_TAP, click, false, 99999);   
			}
			else*/
			//{
				component.addEventListener(MouseEvent.CLICK, click, false, 99999);
			//}
		}
		
		override protected function disable():void
		{
			if (enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_TAP, click);   
			}
			else
			{*/
				component.removeEventListener(MouseEvent.CLICK, click);   
			//}
			
			//removeKeyboardEvents();
		}
		
		private function click(e:Event):void 
		{
			toggleSelection();
			component.dispatchEvent(new ZvrEvent(ZvrEvent.USER_INPUT, component));
		}
		
		private function toggleSelectionByKeyboard():void 
		{
			toggleSelection();
			component.dispatchEvent(new ZvrEvent(ZvrEvent.USER_INPUT, component));
		}
		
		private function toggleSelection():void
		{
			
			if (component.checkState(ZvrStates.SELECTED))
			{
				if (unselectByInput) component.removeState(ZvrStates.SELECTED);
			}
			else
			{
				component.addState(ZvrStates.SELECTED);
			}
		}
		
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			/*if (e.isNew(ZvrStates.FOCUSED))
			{
				addKeyboardEvents()
			}
			else if (e.isRemoved(ZvrStates.FOCUSED))
			{
				removeKeyboardEvents();
			}*/
		}
		
	/*	private function addKeyboardEvents():void
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
		}*/
		
		override public function destroy():void
		{
			disable();
		}
		
		
	}

}