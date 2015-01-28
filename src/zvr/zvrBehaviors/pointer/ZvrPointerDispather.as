package zvr.zvrBehaviors.pointer 
{
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPointerDispather 
	{
		private var _stage:Stage;
		
		private var _onPointUp:Signal = new Signal(ZvrPointerSignal);
		private var _onPointDown:Signal = new Signal(ZvrPointerSignal);
		private var _onPointMove:Signal = new Signal(ZvrPointerSignal);
		
		private var _onMouseWheel:Signal = new Signal(ZvrPointerSignal);
		
		public function ZvrPointerDispather() 
		{
			
		}
		
		public function init(stage:Stage):void
		{
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			_stage = stage;
			
			_stage.addEventListener(TouchEvent.TOUCH_BEGIN, touchEvent);
			_stage.addEventListener(TouchEvent.TOUCH_END, touchEvent);
			_stage.addEventListener(TouchEvent.TOUCH_MOVE, touchEvent);
			
			_stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseEvent);
			_stage.addEventListener(MouseEvent.MOUSE_UP, mouseEvent);
			_stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseEvent);
			
			_stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseEvent);
		}
		
		public function dispose():void
		{
			_stage.removeEventListener(MouseEvent.MOUSE_DOWN, mouseEvent);
			_stage.removeEventListener(MouseEvent.MOUSE_UP, mouseEvent);
			_stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseEvent);
			
			_stage.removeEventListener(TouchEvent.TOUCH_BEGIN, touchEvent);
			_stage.removeEventListener(TouchEvent.TOUCH_END, touchEvent);
			_stage.removeEventListener(TouchEvent.TOUCH_MOVE, touchEvent);
			
			_stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseEvent);
		}
		
		private function touchEvent(e:TouchEvent):void 
		{
			if (e.isPrimaryTouchPoint) return;
			
			switch (e.type) 
			{
				case TouchEvent.TOUCH_BEGIN:	_onPointDown	.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, e.touchPointID, e.stageX, e.stageY, 0, 0)); break;
				case TouchEvent.TOUCH_END: 		_onPointUp		.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, e.touchPointID, e.stageX, e.stageY, 0, 0)); break;
				case TouchEvent.TOUCH_MOVE: 	_onPointMove	.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, e.touchPointID, e.stageX, e.stageY, 0, 0)); break;
			}
		}
		
		private function mouseEvent(e:MouseEvent):void 
		{
			switch (e.type) 
			{
				case MouseEvent.MOUSE_DOWN: _onPointDown	.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, 0, e.stageX, e.stageY, 0, 0));  			break;
				case MouseEvent.MOUSE_UP: 	_onPointUp		.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, 0, e.stageX, e.stageY, 0, 0));			break;
				case MouseEvent.MOUSE_MOVE:	_onPointMove	.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, 0, e.stageX, e.stageY, 0, 0));			break;
				case MouseEvent.MOUSE_WHEEL:_onMouseWheel	.dispatch(new ZvrPointerSignal(ZvrPointerSignal.BEGIN, 0, e.stageX, e.stageY, 0, 0, e.delta));	break;
			}
			
		}
		
		public function get onPointMove():Signal 
		{
			return _onPointMove;
		}
		
		public function get onPointDown():Signal 
		{
			return _onPointDown;
		}
		
		public function get onPointUp():Signal 
		{
			return _onPointUp;
		}
		
		public function get onMouseWheel():Signal 
		{
			return _onMouseWheel;
		}
	}

}