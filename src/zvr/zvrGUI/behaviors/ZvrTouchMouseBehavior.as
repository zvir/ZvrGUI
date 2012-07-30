package zvr.zvrGUI.behaviors 
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.ui.Mouse;
	import flash.ui.Multitouch;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import zvr.zvrGUI.core.ZvrExplicitBounds;
	import zvr.zvrGUI.skins.zvrMinimalDark.TouchMouseMDSkin;
	import zvr.zvrKeyboard.ZvrKeyboard;
	import zvr.zvrTools.ZvrMath;
	import zvr.zvrTools.ZvrPnt;
	import zvr.zvrTools.ZvrPntMath;
	
	import zvr.zvrGUI.events.ZvrDragBehaviorEvent;

	/**
	 * ...
	 * @author Zvir
	 */
	
	
	public class ZvrTouchMouseBehavior extends ZvrBehavior 
	{
		
		public static const NAME:String = "Dragable";
		
		private var _clickPoint:Point;
		
		private var _vertical:Boolean = true;
		private var _horizontal:Boolean = true;
		private var _limit:Rectangle;
		
		private var _dragging:Boolean = false;
		
		private var _dragHandlers:/*InteractiveObject*/Array = new Array();
		
		private var _targeting:Boolean;
		
		private var _rollOver:Vector.<InteractiveObject> = new Vector.<InteractiveObject>;
		private var _touchPointID:int;
		
		private var _mouseDownTime:int;
		
		
		public function ZvrTouchMouseBehavior() 
		{
			super(NAME);
				
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
		
		public function startDrag(target:DisplayObject):void
		{
			_clickPoint = new Point(component.mouseX, component.mouseY);
			
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
		}
		
		private function mouseDown(e:Event):void 
		{
			if (!validateHandler(e.currentTarget)) return;
			
			if (Multitouch.supportsTouchEvents )
			{
				if (!_dragging)
				{
					_touchPointID = TouchEvent(e).touchPointID;
					startDrag(e.target as DisplayObject);
				}
				else
				{
					var s:TouchMouseMDSkin = component.skin as TouchMouseMDSkin;
					var o:Array = component.stage.getObjectsUnderPoint(s.globalPoint);
					for (var i:int = 0; i < o.length; i++) 
					{	
						
						
						
						if (o[i] is InteractiveObject)
						{
							var v:InteractiveObject = o[i];
							
							if (v == body) continue;
							
							var lc:Point = v.globalToLocal(s.globalPoint);
							v.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
							v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_BEGIN, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
						}
					}
					_mouseDownTime = getTimer();
				}
			}
			
			if (!Multitouch.supportsTouchEvents)
			{
				startDrag(e.target as DisplayObject);
			}
			
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
			if (component.stage)
			{
				if (Multitouch.supportsTouchEvents)
				{
					if (TouchEvent(e).touchPointID == _touchPointID)
					{
						component.stage.removeEventListener(TouchEvent.TOUCH_MOVE, mouseMove);
						component.stage.removeEventListener(TouchEvent.TOUCH_END, mouseUp);
						_dragging = false;
					}
					else
					{
						
						tr("MOUSE UP !!!!!!!!!!!!", TouchEvent(e).touchPointID, _touchPointID);
						
						var s:TouchMouseMDSkin = component.skin as TouchMouseMDSkin;
						var o:Array = component.stage.getObjectsUnderPoint(s.globalPoint);
						for (var i:int = 0; i < o.length; i++) 
						{	
							if (o[i] is InteractiveObject)
							{
								
								var v:InteractiveObject = o[i];
								if (v == body) continue;

								var lc:Point = v.globalToLocal(s.globalPoint);
								v.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
								v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_END, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));							
								
								if (getTimer() - _mouseDownTime < 300)
								{
									v.dispatchEvent(new MouseEvent(MouseEvent.CLICK, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
									v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_TAP, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));							
								}
								
							}
						}
					}
				}
				else
				{
					component.stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
					component.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
					_dragging = false;
				}
			}
	
		}
		
		private function mouseMove(e:Event):void 
		{
			var x:Number = component.parent.mouseX - component.bounds.width * 0.5;
			var y:Number = component.parent.mouseY - component.bounds.height * 0.5;
			
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
			
			
			
			var cx:Number = component.x + component.width * 0.5;
			var cy:Number = component.y + component.height * 0.5;
			
			if (cx < component.stage.stageWidth * 0.3 || cx > component.stage.stageWidth * 0.7 || cy < component.stage.stageHeight * 0.3 || cy > component.stage.stageHeight * 0.7 )
			{
				_targeting = true;
	
			}
			
			if (
				cx > component.stage.stageWidth * 0.4 && 
				cx < component.stage.stageWidth * 0.6 && 
				cy > component.stage.stageHeight * 0.4 && 
				cy < component.stage.stageHeight * 0.6 )
			{
				_targeting = false;
			}
			
			
			if (_targeting)
			{
				var p:ZvrPnt = new ZvrPnt();
			
				p.x = component.stage.stageWidth * 0.5;
				p.y = component.stage.stageHeight * 0.5;
				
				var p2:ZvrPnt = new ZvrPnt(component.x + component.width * 0.5, component.y + component.height * 0.5);
				var d:Number = ZvrPntMath.distance(p, p2);
				
				var a:Number  = ZvrPntMath.angle(p, p2);
				
				var dl:Number = component.stage.stageWidth > component.stage.stageHeight ? component.stage.stageHeight * 0.3  : component.stage.stageWidth * 0.3 ;
				
				var l:Number = ((d / dl) - 0.5) * 4;
				
				l = l > 1 ? 1 : l;
				l = l < 0 ? 0 : l;
				
				component.setStyle("indicatorPosition", a);
			}
			
			var s:TouchMouseMDSkin = component.skin as TouchMouseMDSkin;
			
			var o:Array = component.stage.getObjectsUnderPoint(s.globalPoint);
			
			for (var j:int = _rollOver.length-1; j >= 0; j--) 
			{
				v = _rollOver[j];
				
				if (o.indexOf(v) == -1)
				{
					
					lc = v.globalToLocal(s.globalPoint);
					v.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OUT, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OUT, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OUT, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OUT, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					_rollOver.splice(j, 1);
				}
				
			}
			
			for (var i:int = 0; i < o.length; i++) 
			{	
				if (o[i] is InteractiveObject)
				{
					//if (_rollOver.indexOf(v) == -1)
					//{
					var v:InteractiveObject = o[i];
					if (v == body) continue;
						
					var lc:Point = v.globalToLocal(s.globalPoint);
					v.dispatchEvent(new MouseEvent(MouseEvent.ROLL_OVER, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_OVER, true, true, lc.x, lc.y, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_ROLL_OVER, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					v.dispatchEvent(new TouchEvent(TouchEvent.TOUCH_OVER, true, true, 0, true, lc.x, lc.y, NaN, NaN, NaN, null, ZvrKeyboard.CTRL.pressed, ZvrKeyboard.ALT.pressed, ZvrKeyboard.SHIFT.pressed));
					_rollOver.push(v);
					//}
				}
			}
			
		
			
		}
		
		private function get body():InteractiveObject
		{
			return InteractiveObject(component.skin.body);
		}
		
		public function addHandler(handler:InteractiveObject):void
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
		
		public function removeHandler(handler:InteractiveObject):void
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
		
		
	}

}