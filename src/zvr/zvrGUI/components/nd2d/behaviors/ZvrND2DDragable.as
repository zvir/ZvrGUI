package zvr.zvrGUI.components.nd2d.behaviors 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import zvr.zvrGUI.behaviors.IZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.components.nd2d.ZvrND2DComponent;
	import zvr.zvrGUI.core.IZvrComponent;

	import zvr.zvrGUI.core.ZvrExplicitBounds;
	import zvr.zvrGUI.events.ZvrDragBehaviorEvent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name = "drag",				type = "zvr.zvrGUI.events.ZvrDragBehaviorEvent")]
	[Event(name = "draging",			type = "zvr.zvrGUI.events.ZvrDragBehaviorEvent")]
	[Event(name = "startDrag",			type = "zvr.zvrGUI.events.ZvrDragBehaviorEvent")]
	[Event(name = "stopDrag",			type = "zvr.zvrGUI.events.ZvrDragBehaviorEvent")]
	 
	public class ZvrND2DDragable extends ZvrBehavior implements IZvrDragable
	{
		
		public static const NAME:String = "Dragable";
		
		private var _clickPoint:Point;
		
		private var _vertical:Boolean = true;
		private var _horizontal:Boolean = true;
		private var _limit:Rectangle;
		
		private var _dragging:Boolean = false;
		
		private var _dragHandlers:/*InteractiveObject*/Array = new Array();
		
		public function ZvrND2DDragable() 
		{
			super(NAME);
			_stageSensitive = true;
		}
		
		override protected function enable():void 
		{
			if (component && _limit) limit = limit;
			
			if (body)
			{
				
				if (Multitouch.supportsTouchEvents)
				{
					body.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				}
				else
				{
					body.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				}
			}
			
			for (var i:int = 0; i < _dragHandlers.length; i++) 
			{
				
				if (Multitouch.supportsTouchEvents)
				{
					_dragHandlers[i].addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				}
				else
				{
					_dragHandlers[i].addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				}
				
				
				_dragHandlers[i].addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			}
			
			if (body) body.mouseEnabled = true;
			IZvrND2DComponent(component).node.mouseEnabled = true;
			
		}
		
		override protected function disable():void 
		{
			
			if (body)
			{
				if (Multitouch.supportsTouchEvents)
				{
					body.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				}
				else
				{
					body.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				}
			}
			
			for (var i:int = 0; i < _dragHandlers.length; i++) 
			{
				if (Multitouch.supportsTouchEvents)
				{
					_dragHandlers[i].removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
				}
				else
				{
					_dragHandlers[i].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
				}
				
				_dragHandlers[i].removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			}
			
			mouseUp(null);
		}
		
		override public function destroy():void 
		{
			super.destroy();
		}
		
		public function startDrag(target:Node2D):void
		{
			node.updateLocalMatrix();
			node.invalidateMatrix = true;
			node.updateWorldMatrix();
			
			_clickPoint = node.globalToLocal(new Point(node.stage.mouseX, node.stage.mouseY));
			
			target.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			if (Multitouch.supportsTouchEvents)
			{
				target.stage.addEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				target.stage.addEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				target.stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				target.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
			_dragging = true;
			_dispatchEvent(ZvrDragBehaviorEvent.START_DRAG);
		}
		
		private function mouseDown(e:Event):void 
		{
			if (!validateHandler(e.currentTarget)) return;
			startDrag(e.target as Node2D);
		}
		
		private function removedFromStage(e:Event):void 
		{
			
			_dragging = false;
			e.target.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			if (Multitouch.supportsTouchEvents)
			{
				e.target.stage.removeEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
				e.target.stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
			}
			else
			{
				e.target.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
				e.target.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
			
		}
		
		private function validateHandler(e:Object):Boolean
		{
			if (e == body) return true;
			
			for (var i:int = 0; i < _dragHandlers.length; i++) 
			{
				if (_dragHandlers[i] == e) return true;
			}
			
			return false;
		}
		
		private function mouseUp(e:Event):void 
		{
			if (component.onStage)
			{
				if (Multitouch.supportsTouchEvents)
				{
					IZvrComponent(component).body.stage.removeEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
					IZvrComponent(component).body.stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
				}
				else
				{
					IZvrComponent(component).body.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					IZvrComponent(component).body.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
				}
			}
			var d:Boolean = _dragging;
			_dragging = false;
			if (d) _dispatchEvent(ZvrDragBehaviorEvent.STOP_DRAG);
		}
		
		private function mouseMove(e:Event):void 
		{
			var mp:Point = node.parent.globalToLocal(new Point(node.stage.mouseX, node.stage.mouseY));
			
			var x:Number = mp.x - _clickPoint.x;
			var y:Number = mp.y - _clickPoint.y;
			
			if (_limit) 
			{
				if (x < _limit.x) x = _limit.x;
				if (x > _limit.right) x = _limit.right;
				if (y < _limit.y) y = _limit.y;
				if (y > _limit.bottom) y = _limit.bottom;
			}
			
			var oldX:Number = component.bounds.x;
			var oldY:Number = component.bounds.y;
			
			var delta:Point = new Point(x - oldX, y - oldY);
			
			var event:ZvrDragBehaviorEvent = _dispatchEvent(ZvrDragBehaviorEvent.DRAGGING, delta, true);
			if (event.isDefaultPrevented()) 
			{
				if (event.delta.x == x - oldX && event.delta.y == y - oldY)
				{
					return;
				}
				delta = event.delta.clone();
			}
				
			if (component.explicit.x != ZvrExplicitBounds.X) component.x = component.bounds.x;
			if (component.explicit.y != ZvrExplicitBounds.Y) component.y = component.bounds.y;
			if (component.explicit.width != ZvrExplicitBounds.WIDTH) component.width = component.bounds.width;
			if (component.explicit.height != ZvrExplicitBounds.HEIGHT) component.height = component.bounds.height;

			component.enterMassChangeMode();
			
			if (_horizontal) 
			{
				component.x = component.bounds.x + delta.x;
			}
			
			if (_vertical)
			{	
				component.y = component.bounds.y + delta.y;
			}

			component.exitMassChangeMode();
			
			delta = new Point(component.x - oldX, component.y - oldY);
			
			_dispatchEvent(ZvrDragBehaviorEvent.DRAG, delta);
		}
		
		private function get body():Node2D
		{
			return Node2D(component.skin.body);
		}
		
		private function get node():Node2D
		{
			return IZvrND2DComponent(component).node;
		}
		
		public function addHandler(handler:Node2D):void
		{
			if (_dragHandlers.indexOf(handler) != -1) return;
			
			_dragHandlers.push(handler);
			
			if (Multitouch.supportsTouchEvents)
			{
				handler.addEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
			}
			else
			{
				handler.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			
		}
		
		public function removeHandler(handler:Node2D):void
		{
			var i:int = _dragHandlers.indexOf(handler);
			if (i == -1) return;
			_dragHandlers.splice(i, 1);
			if (Multitouch.supportsTouchEvents)
			{
				handler.removeEventListener(TouchEvent.TOUCH_BEGIN, mouseDown);
			}
			else
			{
				handler.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			
		}
		
		public function get vertical():Boolean 
		{
			return _vertical;
		}
		
		public function set vertical(value:Boolean):void 
		{
			_vertical = value;
		}
		
		public function get horizontal():Boolean 
		{
			return _horizontal;
		}
		
		public function set horizontal(value:Boolean):void 
		{
			_horizontal = value;
		}
		
		public function get limit():Rectangle 
		{
			return _limit;
			
		}
		
		public function set limit(value:Rectangle):void 
		{
			_limit = value;
			if (!component) return;
			
			var x:Number = component.x;
			var y:Number = component.y;
			
			if (_limit) 
			{
				if (x < _limit.x) x = _limit.x;
				if (x > _limit.right) x = _limit.right;
				if (y < _limit.y) y = _limit.y;
				if (y > _limit.bottom) y = _limit.bottom;
			}
			
			if (_horizontal) component.x = x;
			if (_vertical) component.y = y;
			
		}
		
		public function get dragging():Boolean 
		{
			return _dragging;
		}
		
		/*private function get bodyMouseX():Number
		{
			//if (body.x == component.bounds.x) return body
		}*/
		
		private function _dispatchEvent(type:String, delta:Point = null, cancelable:Boolean=false):ZvrDragBehaviorEvent
		{
			var e:ZvrDragBehaviorEvent = new ZvrDragBehaviorEvent(type, this, component, delta, false, cancelable);
			dispatchEvent(e);
			return e;
		}
		
	}

}