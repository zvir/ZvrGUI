package zvr.zvrBehaviors
{
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Matrix;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	
	import zvr.ZvrTools.ZvrMath;
	import zvr.ZvrTools.ZvrPnt;
	import zvr.ZvrTools.ZvrPntMath;
	import zvr.ZvrTools.ZvrTransform; 

	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "event", 		type = "zvr.zvrBehaviors.MultiTouchTransformEvent")]
	 
	public class MultiTouchTransform extends EventDispatcher
	{
		
	/*	private var _scaleEnabled:Boolean = true;
		private var _dragEnabled:Boolean = true;
		private var _rotateEnabled:Boolean = true;*/
		
		private const MINIMUM_POINTS_DISTANCE:Number = 110;
		
		private var _handler:InteractiveObject;
		
		private var _transforming:Boolean = false;
		
		private var _point1:ZvrPnt = new ZvrPnt();
		private var _point2:ZvrPnt = new ZvrPnt();
		
		private var _centerPoint:ZvrPnt = new ZvrPnt();
		private var _centerPointOffset:ZvrPnt = new ZvrPnt();
		private var _lastCenterPoint:ZvrPnt = new ZvrPnt();
		
		private var _rotation:Number = 0;
		private var _distance:Number = 0;
		
		private var _touchPoint1:ZvrPnt;
		private var _touchPoint2:ZvrPnt;
		
		private var _touchPoint1ID:int;
		private var _touchPoint2ID:int;
		
		private var _smoothPoint1:ZvrPnt = new ZvrPnt();
		private var _smoothPoint2:ZvrPnt = new ZvrPnt();
		
		private var _xPositinDelta:Number = 0;
		private var _yPositinDelta:Number = 0;
		private var _scaleDelta:Number = 1;
		private var _rotationDelta:Number = 0;
		
		private var _easing:Number = 0.1;
		
		private var _inputSmoothig:Number = 0.5;
		
		public var onePointDrag:Boolean;
		
		CONFIG::debug
		private var _ids:Array = [];
		
		public function MultiTouchTransform(handler:InteractiveObject) 
		{
			Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
			
			CONFIG::debug
			{
				if (!Multitouch.supportsTouchEvents) 
				{
					tr("Error, Touch Events are not supported");
				}
			}
			
			_handler = handler;
			_handler.addEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
			_handler.addEventListener(TouchEvent.TOUCH_END, touchEnd);
			/*
			CONFIG::debug
			{
				_handler.addEventListener(Event.ENTER_FRAME, testEnterFrame);
			}*/
		}
		/*
		CONFIG::debug
		private function testEnterFrame(e:Event):void
		{
			wch(this, "_touchPoint1", _touchPoint1 == null ? "null" : _touchPoint1); 
			wch(this, "_touchPoint2", _touchPoint2 == null ? "null" : _touchPoint2); 
			wch(this, "_touchPoint1ID", _touchPoint1 == null ? "" : _touchPoint1ID); 
			wch(this, "_touchPoint2ID", _touchPoint2 == null ? "" : _touchPoint2ID); 
			wch(this, "_centerPointOffset", _centerPointOffset == null ? "" : _centerPointOffset); 
			
			var s:String = _ids.join(", ");
			
			wch(this, "_ids", s); 
		}
		*/
		
		private function touchBegin(e:TouchEvent):void 
		{
			CONFIG::debug
			{
				tr("touchBegin touchPointID:", e.touchPointID);
				if (_ids.indexOf(e.touchPointID) == -1)
				{
					_ids.push(e.touchPointID);
				}
			}
			
			if (!_touchPoint1)
			{
				_touchPoint1 = _point1;
				_touchPoint1.x = e.stageX;
				_touchPoint1.y = e.stageY;
				_touchPoint1ID = e.touchPointID;	
				_centerPoint.copyFrom(_touchPoint1);
				_lastCenterPoint.copyFrom(_centerPoint);
				_smoothPoint1.copyFrom(_touchPoint1);
				
				_handler.removeEventListener(Event.ENTER_FRAME, easeEnterframe);
				startTransform();
				_handler.addEventListener(TouchEvent.TOUCH_MOVE, updateTouchPoints);
			}
			else if (!_touchPoint2)
			{
				_touchPoint2 = _point2;
				_touchPoint2.x = e.stageX;
				_touchPoint2.y = e.stageY;
				_touchPoint2ID = e.touchPointID;
				
				ZvrPntMath.setBetween(_centerPoint, _smoothPoint1, _touchPoint2, 0.5);				
				_lastCenterPoint.copyFrom(_centerPoint);
				
				_smoothPoint2.copyFrom(_touchPoint2);
				
				_distance = ZvrPntMath.distance(_smoothPoint1, _smoothPoint2);
				_rotation = ZvrPntMath.angle(_smoothPoint1, _smoothPoint2);
			}
			
			
			if (onePointDrag && _touchPoint1)
			{
				/*CONFIG::debug
				{
					tr("starting one point transform");
				}*/
				_handler.addEventListener(TouchEvent.TOUCH_MOVE, updateTouchPoints);
				
			}
			else
			{
				if (_touchPoint2 && _touchPoint1)
				{
					/*tr("starting teo point transform");*/
					_handler.addEventListener(TouchEvent.TOUCH_MOVE, updateTouchPoints);
					
				}
			}
		}
		
		private function touchEnd(e:TouchEvent):void 
		{
			/*CONFIG::debug
			{
				tr("touchEnd, touchPointID:", e.touchPointID);
				var i:int = _ids.indexOf(e.touchPointID)
				if (i != -1)
				{
					_ids.splice(i, 1);
				}
			}*/
			
			if (e.touchPointID == _touchPoint1ID)
			{
				if (_touchPoint2 && onePointDrag)
				{
					_touchPoint1ID = _touchPoint2ID;
					_touchPoint1.copyFrom(_touchPoint2);
					_smoothPoint1.copyFrom(_smoothPoint2);
					_centerPoint.copyFrom(_smoothPoint1);
					_lastCenterPoint.copyFrom(_smoothPoint1);
					
					_touchPoint2 = null;
				}
				else
				{
					_touchPoint1 = null;
				}
			}
			else if	(e.touchPointID == _touchPoint2ID)
			{	
				_touchPoint2 = null;	
				
				/*CONFIG::debug
				{
					tr("touchEnd, CASE 2");
				}*/
				_centerPoint.copyFrom(_smoothPoint1);
				_lastCenterPoint.copyFrom(_smoothPoint1);
			}
			
			if (!_touchPoint1)
			{				
				endTransform();
				_handler.removeEventListener(TouchEvent.TOUCH_MOVE, updateTouchPoints);
			}
			
		}
		
		private function endTransform():void
		{
			if (!_transforming) return;
			
			/*CONFIG::debug
			{
				tr("endTransform");
			}*/
			
			_handler.removeEventListener(Event.ENTER_FRAME, enterFrameSmoothing);
			
			if (_easing < 1)
			{
				CONFIG::debug
				{
					tr("start easeEnterframe");
				}
				
				_handler.addEventListener(Event.ENTER_FRAME, easeEnterframe);
			}
			
			_transforming = false;
			
		}
		
		private function startTransform():void
		{
			
			_transforming = true;
			
			/*CONFIG::debug
			{
				tr("start touch transform", _distance.toFixed(2), _rotation.toFixed(2));
			}*/
			
			_handler.addEventListener(Event.ENTER_FRAME, enterFrameSmoothing);
			_handler.removeEventListener(Event.ENTER_FRAME, easeEnterframe);
		}
		
		private function updateTouchPoints(e:TouchEvent):void 
		{
			if (e.touchPointID == _touchPoint1ID)
			{
				_touchPoint1.x = e.stageX;
				_touchPoint1.y = e.stageY;
			}
			
			if (_touchPoint2 && e.touchPointID == _touchPoint2ID)
			{
				_touchPoint2.x = e.stageX;
				_touchPoint2.y = e.stageY;
			}
			
			if (_touchPoint1 && _touchPoint2)
			{
				var d:Boolean =  ZvrPntMath.distance(_touchPoint1, _touchPoint2) > MINIMUM_POINTS_DISTANCE;
			}
			else
			{
				d = true;
			}
			
			if (_touchPoint1 && _transforming && !d)
			{
				/*CONFIG::debug
				{
					tr("endTransform utp");
				}*/
				
				endTransform();
			}
			
			if (_touchPoint1 && !_transforming && d)
			{
				/*CONFIG::debug
				{
					tr("startTransform utp");
				}*/
				
				startTransform();
			}
			
		}
		
		private function transform(p1:ZvrPnt, p2:ZvrPnt = null):void 
		{
			if (!p2)
			{
				transformOnePoint(p1);
				return;
			}
			ZvrPntMath.setBetween(_centerPoint, p1, p2, 0.5);
			
			var rotation:Number = ZvrPntMath.angle(p1, p2);
			var distance:Number = ZvrPntMath.distance(p1, p2);
			
			_rotationDelta = rotation - _rotation;
			
			_rotationDelta = _rotationDelta > 180 ? _rotationDelta - 360 : _rotationDelta;
			_rotationDelta = _rotationDelta < -180 ? _rotationDelta + 360 : _rotationDelta;
			
			_xPositinDelta = _centerPoint.x - _lastCenterPoint.x;
			_yPositinDelta = _centerPoint.y - _lastCenterPoint.y;
			
			_scaleDelta = distance / _distance;
			
			/*CONFIG::debug
			{
				tr("touch transform", distance.toFixed(2), rotation.toFixed(2),  _rotationDelta.toFixed(1), _scaleDelta.toFixed(1));
			}*/
			
			_rotation = rotation;
			_distance = distance;
			
			_lastCenterPoint.copyFrom(_centerPoint);
			
			dispatchEvent(new MultiTouchTransformEvent(MultiTouchTransformEvent.EVENT, this, _rotationDelta, _centerPoint.x, _centerPoint.y, _xPositinDelta, _yPositinDelta, _scaleDelta));
		}
		
		private function transformOnePoint(p:ZvrPnt):void 
		{
			
			_centerPoint.copyFrom(p);
			_xPositinDelta = _centerPoint.x - _lastCenterPoint.x;
			_yPositinDelta = _centerPoint.y - _lastCenterPoint.y;

			/*CONFIG::debug
			{
				tr("touch transform",  _rotationDelta.toFixed(1), _scaleDelta.toFixed(1));
			}*/
			
			_distance = 0;
			
			_rotationDelta = ZvrMath.smoothTrans(_rotationDelta, 0, _easing);
			_scaleDelta = ZvrMath.smoothTrans(_scaleDelta, 1, _easing);
			
			_lastCenterPoint.copyFrom(_centerPoint);
			
			dispatchEvent(new MultiTouchTransformEvent(MultiTouchTransformEvent.EVENT, this, _rotationDelta, _centerPoint.x, _centerPoint.y, _xPositinDelta, _yPositinDelta, _scaleDelta));
		}
		
		
		private function enterFrameSmoothing(e:Event):void 
		{
			ZvrPntMath.smoothTrans(_smoothPoint1, _touchPoint1.x , _touchPoint1.y, _inputSmoothig);
			_touchPoint2 && ZvrPntMath.smoothTrans(_smoothPoint2, _touchPoint2.x , _touchPoint2.y, _inputSmoothig);
			transform(_smoothPoint1, _touchPoint2 ? _smoothPoint2 : null);
		}
		
		private function easeEnterframe(e:Event):void 
		{
			_rotationDelta = ZvrMath.smoothTrans(_rotationDelta, 0, _easing);
			_scaleDelta = ZvrMath.smoothTrans(_scaleDelta, 1, _easing);
			
			_xPositinDelta = ZvrMath.smoothTrans(_xPositinDelta, 0, _easing);
			_yPositinDelta = ZvrMath.smoothTrans(_yPositinDelta, 0, _easing);
			 
			_centerPoint.x -= _xPositinDelta;
			_centerPoint.y -= _yPositinDelta;
			
			dispatchEvent(new MultiTouchTransformEvent(MultiTouchTransformEvent.EVENT, this, _rotationDelta, _centerPoint.x, _centerPoint.y, _xPositinDelta, _yPositinDelta, _scaleDelta));
			
			if (
				Math.abs(_rotationDelta) < 0.001 && 
				Math.abs(_scaleDelta - 1) < 0.001 &&
				Math.abs(_xPositinDelta) < 0.001 && 
				Math.abs(_yPositinDelta) < 0.001)
				{
					CONFIG::debug
					{
						tr("end easeEnterframe");
					}
					_handler.removeEventListener(Event.ENTER_FRAME, easeEnterframe);
				}
		}
		
		public function transformDisplayObject(displayObject:DisplayObject):void
		{
			var m:Matrix = displayObject.transform.matrix;
			m.translate(_xPositinDelta, _yPositinDelta);
			displayObject.transform.matrix = m;
			ZvrTransform.rotateAroundExternalPoint(displayObject, _rotationDelta, _centerPoint.x, _centerPoint.y);
			ZvrTransform.scaleAroundPoint(displayObject, displayObject.scaleX * _scaleDelta, displayObject.scaleY * _scaleDelta, _centerPoint.x, _centerPoint.y);
		
		}
		
		public function get touchPoint1():ZvrPnt 
		{
			return _touchPoint1;
		}
		
		public function get touchPoint2():ZvrPnt 
		{
			return _touchPoint2;
		}
		
		public function get inputSmoothig():Number 
		{
			return _inputSmoothig;
		}
		
		public function set inputSmoothig(value:Number):void 
		{
			_inputSmoothig = value;
		}
		
		public function destroy():void 
		{
			_handler.removeEventListener(TouchEvent.TOUCH_MOVE, updateTouchPoints);
			_handler.removeEventListener(TouchEvent.TOUCH_BEGIN, touchBegin);
			_handler.removeEventListener(TouchEvent.TOUCH_END, touchEnd);
			_handler.removeEventListener(Event.ENTER_FRAME, easeEnterframe);
			_handler.removeEventListener(Event.ENTER_FRAME, enterFrameSmoothing);
			_handler = null;
		}
	}

}