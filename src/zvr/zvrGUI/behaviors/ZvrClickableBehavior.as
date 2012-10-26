package zvr.zvrGUI.behaviors
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Keyboard;
	import flash.ui.Multitouch;
	import zvr.zvrGUI.core.ZvrComponent;
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
			ZvrComponent(component).focusRect = false;
			
			if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				ZvrComponent(component).addEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				ZvrComponent(component).addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				ZvrComponent(component).addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			
			
			ZvrComponent(component).buttonMode = true;
		}
		
		private function mouseOver(e:Event):void 
		{
			//tr("mouseOver");
			
			if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).addEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				ZvrComponent(component).addEventListener(MouseEvent.ROLL_OUT, mouseOut);
				ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			component.manageStates(ZvrStates.OVER, ZvrStates.NORMAL);	
				
		}
		
		private function mouseOut(e:Event):void 
		{
			//tr("mouseOut");
			if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				ZvrComponent(component).addEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
				ZvrComponent(component).addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			component.manageStates(ZvrStates.NORMAL, ZvrStates.OVER);	
		}
		
		private function mouseDown(e:Event):void 
		{
			tr(e.type, this);if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				ZvrComponent(component).stage.addEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				ZvrComponent(component).removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			component.addState(ZvrStates.DOWN);	
		}
		
		private function mouseUp(e:Event):void 
		{
			//tr("mouseUp");
			if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_END, mouseUp);
				ZvrComponent(component).addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				ZvrComponent(component).stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				ZvrComponent(component).removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				ZvrComponent(component).addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			component.removeState(ZvrStates.DOWN);	
			if (ZvrComponent(component).stage.focus != component) ZvrComponent(component).stage.focus = ZvrComponent(component);
		}
		
		override protected function disable():void
		{
			if (Multitouch.supportsTouchEvents)
			{
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_ROLL_OUT, mouseOut);
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_END, mouseUp);
				ZvrComponent(component).removeEventListener(TouchEvent.TOUCH_ROLL_OVER, mouseOver);
			}
			else
			{
				ZvrComponent(component).removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
				ZvrComponent(component).removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			}
			
			if (component.onStage) ZvrComponent(component).stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			ZvrComponent(component).buttonMode = false;
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
			{
				ZvrComponent(component).stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				ZvrComponent(component).stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
				component.manageStates(ZvrStates.DOWN, ZvrStates.NORMAL);
			}
		}
		
		private function keyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == Keyboard.SPACE || e.keyCode == Keyboard.ENTER)
			{
				ZvrComponent(component).stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyUp);
				if (component.onStage && ZvrComponent(component).stage.focus == component) ZvrComponent(component).stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				component.manageStates(ZvrStates.NORMAL, ZvrStates.DOWN);
			}
		}
		
		override public function destroy():void
		{
			disable();
		}
	}
}