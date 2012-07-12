package zvr.zvrGUI.behaviors
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrKeyboard.ZvrKeyboard;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrButtonBehavior extends ZvrBehavior
	{
		
		public static const NAME:String = "Button";
		
		public function ZvrButtonBehavior()
		{
			super("Button");
			_stageSensitive = true;
		}
		
		override protected function enable():void
		{
			if (!enabled || !component.stage) return;
			component.focusRect = false;
			
			if (Multitouch.supportsTouchEvents)
			{
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				component.addEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				component.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			
			component.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.buttonMode = true;
			
		}
		
		private function mouseOver(e:Event):void 
		{
			if (Multitouch.supportsTouchEvents)
			{
				component.addEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				component.removeEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				component.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
				component.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			component.manageStates(ZvrStates.OVER, ZvrStates.NORMAL);		
		}
		
		private function mouseOut(e:Event):void 
		{
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				component.addEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				component.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
				component.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			
			component.manageStates(ZvrStates.NORMAL, ZvrStates.OVER);	
		}
		
		private function mouseDown(e:Event):void 
		{
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				component.stage.addEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				component.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			
			component.manageStates(ZvrStates.DOWN, ZvrStates.NORMAL);
		}
		
		private function mouseUp(e:Event):void 
		{
			// BUG no stage!
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				component.stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				component.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			component.manageStates(ZvrStates.NORMAL, ZvrStates.DOWN);			
			if (component.stage.focus != component) component.stage.focus = component;
		}
		
		override protected function disable():void
		{
			if (enabled || !component.stage) return;
			
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				component.removeEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				component.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
				component.removeEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				component.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
				component.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				component.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			
			
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.buttonMode = false;
			removeKeyboardEvents();
			component.manageStates([ZvrStates.NORMAL], [ZvrStates.DOWN, ZvrStates.OVER, ZvrStates.FOCUSED])
		}
		
		
		private function focusIn(e:FocusEvent):void 
		{
			component.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.skin.body.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.addState(ZvrStates.FOCUSED);
			addKeyboardEvents();
		}
		
		private function addKeyboardEvents():void
		{
			ZvrKeyboard.SPACE.addReleasedCallback(keyUp);
			ZvrKeyboard.ENTER.addReleasedCallback(keyUp);
			ZvrKeyboard.NUMPAD_ENTER.addReleasedCallback(keyUp);
			
			ZvrKeyboard.SPACE.addPressedCallback(keyDown);
			ZvrKeyboard.ENTER.addPressedCallback(keyDown);
			ZvrKeyboard.NUMPAD_ENTER.addPressedCallback(keyDown);
		}
		
		private function removeKeyboardEvents():void
		{
			ZvrKeyboard.SPACE.removeReleasedCallback(keyUp);
			ZvrKeyboard.ENTER.removeReleasedCallback(keyUp);
			ZvrKeyboard.NUMPAD_ENTER.removeReleasedCallback(keyUp);
			
			ZvrKeyboard.SPACE.removePressedCallback(keyDown);
			ZvrKeyboard.ENTER.removePressedCallback(keyDown);
			ZvrKeyboard.NUMPAD_ENTER.removePressedCallback(keyDown);
		}
		
		private function keyDown():void 
		{			
			component.manageStates(ZvrStates.DOWN, ZvrStates.NORMAL);
		}
		
		private function keyUp():void 
		{
			component.manageStates(ZvrStates.NORMAL, ZvrStates.DOWN);
			component.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			component.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			component.skin.body.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			component.removeState(ZvrStates.FOCUSED);
			removeKeyboardEvents();
		}
		
		override public function destroy():void
		{
			// TODO make it destryable!
			
			removeKeyboardEvents()
			
		}
		
	}

}