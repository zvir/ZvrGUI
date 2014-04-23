package clv.gui.core 
{
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class PointerManager extends Pointer
	{
		
		private var _stage:Stage;
		public var poinsters:Vector.<Pointer> = new Vector.<Pointer>();
		
		public function PointerManager() 
		{
			
		}
		
		public function init(stage:Stage):void
		{
			_stage = stage;
			
			if (Multitouch.supportsTouchEvents)
			{
				stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				stage.addEventListener(TouchEvent.TOUCH_END, touchEnd);
				stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
				stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				stage.addEventListener(MouseEvent.RELEASE_OUTSIDE, mouseRelaseOutside);
				stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				stage.addEventListener(Event.MOUSE_LEAVE, mouseLeave);
			}
			
		}
		
		private function touchBegin(e:Event):void 
		{
			updateDefaultFromMouse();
			down = true;
			_onDown.dispatch(this);
		}
		
		private function touchEnd(e:TouchEvent):void 
		{
			updateDefaultFromMouse();
			down = false;
			_onUp.dispatch(this);
		}
		
		private function touchMove(e:TouchEvent):void 
		{
			updateDefaultFromTouch(e);
			_onMove.dispatch(this);
		}
		
		private function updateDefaultFromTouch(e:TouchEvent):void 
		{
			x = e.stageX;
			y = e.stageY;
		}
		
		private function updateDefaultFromMouse():void 
		{
			x = _stage.mouseX;
			y = _stage.mouseY;
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			updateDefaultFromMouse();
			_onMove.dispatch(this);
		}
		
		private function mouseLeave(e:Event):void 
		{
			updateDefaultFromMouse();
			_onLeave.dispatch(this);
		}
		
		private function mouseWheel(e:MouseEvent):void 
		{
			updateDefaultFromMouse();
			wheel = e.delta;
			_onWheel.dispatch(this);
			wheel = 0;
		}
		
		private function mouseRelaseOutside(e:MouseEvent):void 
		{
			down = false;
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			updateDefaultFromMouse();
			down = false;
			_onUp.dispatch(this);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			updateDefaultFromMouse();
			down = true;
			_onDown.dispatch(this);
		}
		
	}

}