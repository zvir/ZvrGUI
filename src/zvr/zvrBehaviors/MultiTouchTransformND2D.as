package zvr.zvrBehaviors 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.display.DisplayObject;
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
		private var _stage:EventDispatcher;
		
		public function MultiTouchTransformND2D(handler:Node2D, stage:EventDispatcher = null) 
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_handler = handler;
			_stage = stage;
			_stage ||= _handler;
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				_handler.addEventListener(TouchEvent.TOUCH_END, touchEnd);
			}
			else
			{
				_handler.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				_handler.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				_handler.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
				_handler.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				_handler.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				_handler.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				_handler.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
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
				_handler.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				_handler.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
			
			_stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		override protected function begin():void 
		{
			super.begin();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.addEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				_handler.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
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
		
		private function touchBegin(e:TouchEvent):void 
		{
			var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			addPoint(e.touchPointID, sp.x, sp.y);
		}
		
		private function touchEnd(e:TouchEvent):void 
		{
			removePoint(e.touchPointID);
		}
		
		private function touchMove(e:TouchEvent):void 
		{
			var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			updatePoint(e.touchPointID, sp.x, sp.y);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			addPoint(0, sp.x, sp.y);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			removePoint(0);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			var sp:Point = Node2D(e.currentTarget).localToGlobal(new Point(e.localX, e.localY));
			updatePoint(0, sp.x, sp.y);
		}
		
	}

}