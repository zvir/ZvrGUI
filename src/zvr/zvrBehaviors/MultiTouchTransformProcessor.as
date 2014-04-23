package zvr.zvrBehaviors 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import zvr.zvrTools.ZvrMath;
	import zvr.zvrTools.ZvrPnt;
	import zvr.zvrTools.ZvrPntMath;
	/**
	 * ...
	 * @author Zvir
	 */
	
	 [Event(name = "update", 		type = "zvr.zvrBehaviors.MultiTouchTransformEvent")]
	 [Event(name = "begin", 		type = "zvr.zvrBehaviors.MultiTouchTransformEvent")]
	 [Event(name = "end", 			type = "zvr.zvrBehaviors.MultiTouchTransformEvent")]
	 
	public class MultiTouchTransformProcessor extends EventDispatcher
	{
		private var _points:Vector.<MultiTouchTransformPoint> = new Vector.<MultiTouchTransformPoint>();
		private var _trash:Vector.<MultiTouchTransformPoint> = new Vector.<MultiTouchTransformPoint>();
		
		private var _center:ZvrPnt = new ZvrPnt();
		private var _lastCenter:ZvrPnt = new ZvrPnt();
		
		private var _rotation:Number = 0.0;
		private var _distance:Number = 0.0;
		
		private var _scaleDelta:Number = 1.0;
		private var _rotationDelta:Number = 0.0;
		
		private var _xPositinDelta:Number = 0.0;
		private var _yPositinDelta:Number = 0.0;
		
		private var _easing:Number = 0.1;
		private var _inputSmoothig:Number = 0.5;
		
		private var _minimumPointsDistance:Number = 110;
		
		private var _end:Boolean;
		
		public var enabled:Boolean = true;
		
		public function MultiTouchTransformProcessor() 
		{
			
		}
		
		public function dispose():void
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				_points[i].point = null;
				_points[i].smoothed = null;
			}
			
			for (i = 0; i < _trash.length; i++) 
			{
				_trash[i].point = null;
				_trash[i].smoothed = null;
			}
			
			_points = null;
			_trash = null;
			_center = null;
			_lastCenter = null;
			_center = null;
		}
		
		public function addPoint(id:int, x:Number, y:Number):void
		{
			
			for (var i:int = 0; i < _points.length; i++) 
			{
				if (_points[i].id == id) return;
			}
			
			var p:MultiTouchTransformPoint = getPoint();
			
			p.id = id;
			p.point.x = x;
			p.point.y = y;
			p.smoothed.x = x;
			p.smoothed.y = y;
			
			_points.push(p);
			pointsCountChange();
			
			if (_points.length == 1)
			{
				_end = false;
				begin();
			}
		}
		
		public function removePoint(id:int):void
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				if (_points[i].id == id)
				{
					_trash.push(_points.splice(i, 1)[0]);
					pointsCountChange();
					return;
				}
			}
		}
		
		public function removeAllPoint():void
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				_trash.push(_points.splice(i, 1)[0]);
			}
		}
		
		public function updatePoint(id:int, x:Number, y:Number):void
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				if (_points[i].id == id)
				{
					_points[i].point.x = x;
					_points[i].point.y = y;
					return;
				}
			}
		}
		
		public function update():MultiTouchTransformEvent
		{
			
			var e:MultiTouchTransformEvent;
			
			updateSmoothPoints();
			
			switch (_points.length) 
			{
				case 0: e = updateNone(); break;
				case 1: e = updateOne(); break;
				default: e = updateMulti();
			}
			
			return e;
			
		}
		
		protected function begin():void
		{
			// overwrite
		}
		
		protected function end():void
		{
			// overwrite
		}
		
		private function updateNone():MultiTouchTransformEvent
		{

			if (
				_easing >= 1 ||
					(
						Math.abs(_rotationDelta) < 0.001 && 
						Math.abs(_scaleDelta - 1) < 0.001 &&
						Math.abs(_xPositinDelta) < 0.001 && 
						Math.abs(_yPositinDelta) < 0.001
					)
				)
			{
				if (!_end)
				{
					end();	
					_end = true;
				}
				return null;
			}
			
			_rotationDelta = ZvrMath.smoothTrans(_rotationDelta, 0, _easing);
			_scaleDelta = ZvrMath.smoothTrans(_scaleDelta, 1, _easing);
			
			_xPositinDelta = ZvrMath.smoothTrans(_xPositinDelta, 0, _easing);
			_yPositinDelta = ZvrMath.smoothTrans(_yPositinDelta, 0, _easing);
			 
			_center.x -= _xPositinDelta;
			_center.y -= _yPositinDelta;
			
			var e:MultiTouchTransformEvent = new MultiTouchTransformEvent(MultiTouchTransformEvent.UPDATE, _rotationDelta, _center.x, _center.y, _xPositinDelta, _yPositinDelta, _scaleDelta)
			
			if (enabled) dispatchEvent(e);
			
			return e;
			
		}
		
		private function updateOne():MultiTouchTransformEvent
		{
			
			updateCenterPoint();
			
			_xPositinDelta = _center.x - _lastCenter.x;
			_yPositinDelta = _center.y - _lastCenter.y;
			
			_rotationDelta = ZvrMath.smoothTrans(_rotationDelta, 0, _easing);
			_scaleDelta = ZvrMath.smoothTrans(_scaleDelta, 1, _easing);
			
			_lastCenter.copyFrom(_center);
			
			var e:MultiTouchTransformEvent = new MultiTouchTransformEvent(MultiTouchTransformEvent.UPDATE, _rotationDelta, _center.x, _center.y, _xPositinDelta, _yPositinDelta, _scaleDelta);
			
			if (enabled) dispatchEvent(e);
			
			return e;
		}
		
		private function updateMulti():MultiTouchTransformEvent
		{
			updateCenterPoint();
			
			var distance:Number =  getDistance();
			var rotation:Number =  getRotation();
			
			_rotationDelta = ZvrMath.cutAngle180(rotation - _rotation) / _points.length;
			
			_xPositinDelta = _center.x - _lastCenter.x;
			_yPositinDelta = _center.y - _lastCenter.y;
			
			_scaleDelta = distance / _distance;
			
			_rotation = rotation;
			_distance = distance;
			
			_lastCenter.copyFrom(_center);
			
			var e:MultiTouchTransformEvent = new MultiTouchTransformEvent(MultiTouchTransformEvent.UPDATE, _rotationDelta, _center.x, _center.y, _xPositinDelta, _yPositinDelta, _scaleDelta);
			
			if (enabled) dispatchEvent(e);
			
			return e;
			
		}
		
		private function getDistance():Number
		{
			var d:Number = 0;
				
			for (var i:int = 1; i < _points.length; i++) 
			{
				d += ZvrPntMath.distance(_points[i-1].smoothed, _points[i].smoothed);
			}
			
			if (_points.length > 2)
			{
				d += ZvrPntMath.distance(_points[0].smoothed, _points[i-1].smoothed);
			}
			
			return d;
			
		}
		
		private function getRotation():Number
		{
			var a:Number = 0;
			
			for (var i:int = 0; i < _points.length; i++) 
			{
				a += ZvrPntMath.angle(_points[i].smoothed, _center);
			}
			
			return a;
		}
		
		private function updateCenterPoint():void
		{
			_center.x = 0;
			_center.y = 0;
			
			for (var i:int = 0; i < _points.length; i++) 
			{
				ZvrPntMath.addTo(_center, _points[i].smoothed);
			}
			
			_center.x /= _points.length;
			_center.y /= _points.length;
			
		}
		
		private function updateSmoothPoints():void
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				var p:MultiTouchTransformPoint = _points[i];
				ZvrPntMath.smoothTrans(p.smoothed, p.point.x , p.point.y, _inputSmoothig);
			}
		}
		
		private function pointsCountChange():void
		{
			if (_points.length == 0) 
			{
				if (enabled) dispatchEvent(new MultiTouchTransformEvent(MultiTouchTransformEvent.END));
				return;
			}
			
			updateCenterPoint();
			_lastCenter.copyFrom(_center);
			_distance = getDistance();
			_rotation = getRotation();
		}
		
		private function getPoint():MultiTouchTransformPoint
		{
			var p:MultiTouchTransformPoint = _trash.pop();
			if (!p)
			{
				p = new MultiTouchTransformPoint();
			}
			return p;
		}
		
		public function get easing():Number 
		{
			return _easing;
		}
		
		public function set easing(value:Number):void 
		{
			_easing = value;
		}
		
	}

}