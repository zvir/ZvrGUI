package zvr.zvrGUI.behaviors 
{
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.ui.Multitouch;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
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
		
		private var _storedEvent:Event;
		private var _soredTarget:Object;
		private var _startClick:Point = new Point();
		private var _preventClick:Boolean = false;
		private var _cancelScrolItv:int;
		private var _lastPosition:Point = new Point();
		private var _currentPosition:Point = new Point();
		
		public function ZvrDragScrolable() 
		{
			super(NAME);
			
			//Multitouch.mapTouchToMouse = true;
			
		}
		
		override protected function enable():void
		{
			if (!enabled) return;
			
			if (Multitouch.supportsTouchEvents)
			{
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			}
			else
			{
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			}
		}
		
		override protected function disable():void
		{
			if (enabled) return;
			
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			}
			
			removeEventListeners();
			clearTimeout(_cancelScrolItv);
			
		}
		
		private function mouseDown(e:Event):void 
		{
			//tr(this, "mouseDown");
			_preventClick = false;
			_storedEvent = e.clone();
			_soredTarget = e.target;
			
			e.stopImmediatePropagation();
			
			addEventListeners();
			
			
			_cancelScrolItv = setTimeout(cancelScroll, 100);
			
			_startClick.x = component.mouseX;
			_startClick.y = component.mouseY;
			_lastPosition = _startClick.clone();
		}
		
		private function mouseUp(e:Event):void 
		{
			clearTimeout(_cancelScrolItv);
			removeEventListeners();
		}
		
		private function cancelScroll():void 
		{
			removeEventListeners();
			
			if (Multitouch.supportsTouchEvents)
			{
				component.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			}
			else
			{
				component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			}
			
			if (_soredTarget is EventDispatcher) EventDispatcher(_soredTarget).dispatchEvent(_storedEvent);
			
			if (Multitouch.supportsTouchEvents)
			{
				component.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown, true);
			}
			else
			{
				component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown, true);
			}
		}
		
		private function mouseMove(e:Event):void 
		{
			_currentPosition = new Point(component.mouseX, component.mouseY);
			
			if (Point.distance(_startClick, _currentPosition) > 4 && _cancelScrolItv > 0)
			{
				clearTimeout(_cancelScrolItv);
				
				_cancelScrolItv = -1;
				
				if (Multitouch.supportsTouchEvents)
				{
					component.addEventListener(TouchEvent.TOUCH_TAP, click, true);
				}
				else
				{
					component.addEventListener(MouseEvent.CLICK, click, true);
				}
				
				_preventClick = true;
			}
			else if (_cancelScrolItv > 0)
			{
				return;
			}
				
			var scroller:ZvrScroller = component as ZvrScroller;
			
			var delta:Point = _currentPosition.subtract(_lastPosition);
			_lastPosition = _currentPosition;
			
			scroller.verticalScroll.position -= delta.y;
			scroller.horizontalScroll.position -= delta.x;
			
		}
		
		
		private function click(e:Event):void 
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
			
		}
		
		private function addEventListeners():void
		{
		
			if (Multitouch.supportsTouchEvents)
			{
				component.stage.addEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				component.stage.addEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				component.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				component.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
		}
		
		private function removeEventListeners():void
		{
			if (!component.stage) return;
			
			if (Multitouch.supportsTouchEvents)
			{
				component.stage.removeEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				component.stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				component.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				component.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				
			}
		}
		
		override public function destroy():void
		{
			disable();
		}
		
		
	}

}