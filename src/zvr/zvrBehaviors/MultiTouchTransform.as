package zvr.zvrBehaviors 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Matrix;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import zvr.zvrTools.ZvrTransform;
	/**
	 * ...
	 * @author Zvir
	 */

	public class MultiTouchTransform extends MultiTouchTransformProcessor
	{
		
		private var _handler:EventDispatcher;
		private var _stage:EventDispatcher;
		
		public function MultiTouchTransform(handler:EventDispatcher, stage:EventDispatcher = null) 
		{
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_handler = handler;
			_stage = stage;
			_stage ||= _handler;
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
			}
			else
			{
				_handler.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				
			}
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if (Multitouch.supportsTouchEvents)
			{				
				_handler.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
				_stage.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
				_stage.removeEventListener(TouchEvent.TOUCH_MOVE, touchMove);
			}
			else
			{
				_handler.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			}
			
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
		
		private function touchBegin(e:TouchEvent):void 
		{
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
		
		private function mouseDown(e:MouseEvent):void 
		{
			addPoint(0, e.stageX, e.stageY);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			removePoint(0);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			updatePoint(0, e.stageX, e.stageY);
		}
		
		public function transformDisplayObject(displayObject:DisplayObject, e:MultiTouchTransformEvent):void
		{
			var m:Matrix = displayObject.transform.matrix;
			m.translate(e.xPositinDelta, e.yPositinDelta);
			displayObject.transform.matrix = m;
			ZvrTransform.rotateAroundExternalPoint(displayObject, e.rotationDelta, e.centerX, e.centerY);
			ZvrTransform.scaleAroundPoint(displayObject, displayObject.scaleX * e.scaleDelta, displayObject.scaleY * e.scaleDelta, e.centerX, e.centerY); 
		}
		
	}

}