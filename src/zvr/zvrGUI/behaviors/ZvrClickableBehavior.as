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
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrClickableBehavior extends ZvrBehavior
	{
		
		public function ZvrClickableBehavior()
		{
			super("component");
		}
		
		override protected function enable():void
		{
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
			
			
			
			component.buttonMode = true;
		}
		
		private function mouseOver(e:Event):void 
		{
			//tr("mouseOver");
			
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
			//tr("mouseOut");
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
			tr(e.type, this);if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				component.stage.addEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				component.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			component.addState(ZvrStates.DOWN);	
		}
		
		private function mouseUp(e:Event):void 
		{
			//tr("mouseUp");
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
			
			component.removeState(ZvrStates.DOWN);	
			if (component.stage.focus != component) component.stage.focus = component;
		}
		
		override protected function disable():void
		{
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
			
			if (component.stage) component.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			component.buttonMode = false;
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
			{
				component.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				component.stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
				component.manageStates(ZvrStates.DOWN, ZvrStates.NORMAL);
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
			{
				component.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyUp);
				if (component.stage && component.stage.focus == component) component.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				component.manageStates(ZvrStates.NORMAL, ZvrStates.DOWN);
			}
		}
		
		override public function destroy():void
		{
			disable();
		}
	}
}