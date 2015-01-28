package zvr.zvrGUI.behaviors 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrKeyboard.ZvrKeyboard;

	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDragScrolable extends ZvrBehavior 
	{
		
		public static const NAME:String = "DragScrolable";
		
		static public const CANCEL_TIME_OUT:int = 100;
		
		private var _storedEvent:Event;
		private var _soredTarget:*;
		private var _startClick:Point = new Point();
		private var _preventClick:Boolean = false;
		private var _cancelScrolItv:int;
		private var _cancelTime:int;
		private var _lastPosition:Point = new Point();
		private var _currentPosition:Point = new Point();
		
		public function ZvrDragScrolable() 
		{
			super(NAME);
			
			//Multitouch.mapTouchToMouse = true;
			//Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
		}
		
		override protected function enable():void
		{
			if (!enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
				//component.addEventListener(TouchEvent.TOUCH_TAP, mouseClick);
			/*}
			else
			{*/
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
				//component.addEventListener(MouseEvent.CLICK, mouseClick);
			/*}*/
		}
		
		override protected function disable():void
		{
			if (enabled) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
				//component.removeEventListener(TouchEvent.TOUCH_TAP, mouseClick);
			/*}
			else
			{*/
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
				//component.removeEventListener(MouseEvent.CLICK, mouseDown);
			/*}*/
			
			removeEventListeners();
			clearTimeout(_cancelScrolItv);
		}
		
		private function mouseDown(e:Event):void 
		{
			//tr(this, "mouseDown");
			_preventClick = false;
			
			_storedEvent = e;
			
			_soredTarget = e.target;
			
			e.stopImmediatePropagation();
			
			addEventListeners();
			
			_cancelScrolItv = setTimeout(cancelScroll, CANCEL_TIME_OUT);
			_cancelTime = getTimer();
			
			_startClick.x = ZvrComponent(component).mouseX;
			_startClick.y = ZvrComponent(component).mouseY;
			_lastPosition = _startClick.clone();
			
		}
		
		private function mouseUp(e:Event):void 
		{			
			clearTimeout(_cancelScrolItv);
			removeEventListeners();
			/*if (getTimer() - _cancelTime < CANCEL_TIME_OUT)
			{
				cancelScroll();
				if (_storedEvent is EventDispatcher) EventDispatcher(_storedEvent).dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, false));
			}*/
		}
		
		
		private function mouseUpComponent(e:MouseEvent):void 
		{
			
		}
		
		private function mouseClick(e:Event):void 
		{
			clearTimeout(_cancelScrolItv);
			removeEventListeners();
			cancelScroll();
		}
		
		private function cancelScroll():void 
		{
			removeEventListeners();
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			/*}
			else
			{*/
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			/*}
			*/
			if (_soredTarget is EventDispatcher) EventDispatcher(_soredTarget).dispatchEvent(_storedEvent)
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			/*}
			else
			{*/
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			/*}*/
		}
		
		private function mouseMove(e:Event):void 
		{
			_currentPosition = new Point(ZvrComponent(component).mouseX, ZvrComponent(component).mouseY);

			if (Point.distance(_startClick, _currentPosition) > 4 && _cancelScrolItv > 0)
			{
				clearTimeout(_cancelScrolItv);
				
				_cancelScrolItv = -1;
				
				/*if (Multitouch.supportsTouchEvents)
				{
					component.addEventListener(TouchEvent.TOUCH_TAP, click, true);
				}
				else
				{
					component.addEventListener(MouseEvent.CLICK, click, true);
				}*/
				
				_preventClick = true;
			}
			else if (_cancelScrolItv > 0)
			{
				return;
			}
				
			var scroller:ZvrScroller = component as ZvrScroller;
			
			var delta:Point = _currentPosition.subtract(_lastPosition);
			_lastPosition = _currentPosition;
			
			if (scroller)
			{
				scroller.verticalScroll.position -= delta.y;	
				scroller.horizontalScroll.position -= delta.x;
			}
		}
		
		
		
		/*private function click(e:Event):void 
		{
			if (_preventClick) e.stopImmediatePropagation();
			
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_TAP, click, true);
			}
			else
			{
				component.removeEventListener(MouseEvent.CLICK, click, true);
			}
		}*/
		
		private function addEventListeners():void
		{
		
			/*if (Multitouch.supportsTouchEvents)
			{*/
				ZvrComponent(component).stage.addEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				ZvrComponent(component).stage.addEventListener(TouchEvent.TOUCH_END, mouseUp, true);
				ZvrComponent(component).stage.addEventListener(TouchEvent.TOUCH_TAP, mouseClick, true);
			/*}
			else
			{*/
				ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp, true);
				ZvrComponent(component).stage.addEventListener(MouseEvent.CLICK, mouseClick, true);
			/*}*/
			
			//ZvrComponent(component).stage.mouseChildren = false;
		}
		
		private function removeEventListeners():void
		{
			if (!component.onStage) return;
			
			/*if (Multitouch.supportsTouchEvents)
			{*/
				ZvrComponent(component).stage.removeEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				ZvrComponent(component).stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp, true);
				ZvrComponent(component).stage.removeEventListener(TouchEvent.TOUCH_TAP, mouseClick, true);
			/*}
			else
			{*/
				ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp, true);
				ZvrComponent(component).stage.removeEventListener(MouseEvent.CLICK, mouseClick, true);
			/*}*/
			
			//ZvrComponent(component).stage.mouseChildren = true;

		}
		
		
		
		
		override public function destroy():void
		{
			disable();
		}
		
		
	}

}