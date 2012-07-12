package zvr.zvrGUI.behaviors 
{
	import flash.events.FocusEvent;
	import zvr.zvrGUI.core.ZvrStates;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrFocusable extends ZvrBehavior 
	{
		
		public static const NAME:String = "ZvrFocusable";
		
		public function ZvrFocusable() 
		{
			super(name);
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			component.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.addState(ZvrStates.FOCUSED);
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			component.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.skin.body.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusOut);
			
			component.removeState(ZvrStates.FOCUSED);
		}
		
		override protected function disable():void
		{
			if (enabled) return;
			
			component.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusOut);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.removeState(ZvrStates.FOCUSED);
		}
		
		override protected function enable():void
		{
			if (!enabled) return;
			
			component.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			
		}
		
		override public function destroy():void
		{
			component.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusOut);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			
			component.removeState(ZvrStates.FOCUSED);
		}
		
		
	}

}