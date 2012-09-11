package zvr.zvrBehaviors 
{
	import com.blackmoon.theFew.airFight.handlers.PointerEvent;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import zvr.zvrTools.ZvrTransform;
	/**
	 * ...
	 * @author Zvir
	 */

	public class MultiTouchTransformND2D extends MultiTouchTransformProcessor
	{
		
		private var _handler:Node2D;
		private var _stage:Stage;
		
		public function MultiTouchTransformND2D(handler:Node2D, stage:Stage) 
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_handler = handler;
			_stage = stage;
			//_stage ||= _handler;
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.addEventListener(PointerEvent.BEGIN, touchBegin);
			}
			else
			{
				_handler.addEventListener(PointerEvent.BEGIN, mouseDown);
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.removeEventListener(PointerEvent.BEGIN, touchBegin);
				_stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
				_stage.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				_handler.removeEventListener(PointerEvent.BEGIN, mouseDown);
				_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
			
			_stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			
			_handler = null;
			_stage = null;
			
		}
		
		override protected function end():void 
		{
			super.end();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_stage.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
				_stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
			}
			else
			{
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			_stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		override protected function begin():void 
		{
			super.begin();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_stage.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
				_stage.addEventListener(TouchEvent.TOUCH_END, touchEnd);
			}
			else
			{
				_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				_stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			_stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function stop():void
		{
			removeAllPoint();
			end();
		}
		
		private function enterFrame(e:Event):void 
		{
			update();
		}
		
		private function touchBegin(e:PointerEvent):void 
		{
			//tr("m", e.stageX, e.stageY, e.touchPointID);
			//var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			addPoint(e.touchPointID, e.stageX, e.stageY);
		}
		
		private function touchEnd(e:TouchEvent):void 
		{
			removePoint(e.touchPointID);
		}
		
		private function touchMove(e:TouchEvent):void 
		{
			updatePoint(e.touchPointID, e.stageX, e.stageY);
		}
		
		private function mouseDown(e:PointerEvent):void 
		{
			
			//tr("m", _stage.mouseX, _stage.mouseY);
			
			//var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			addPoint(0, _stage.mouseX, _stage.mouseY);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			removePoint(0);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			updatePoint(0, e.stageX, e.stageY);
		}
		
	}

}