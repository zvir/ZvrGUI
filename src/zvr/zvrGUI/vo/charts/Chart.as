package zvr.zvrGUI.vo.charts 
{
	import flash.events.EventDispatcher
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.vo.events.ChartEvent;
	import zvr.zvrTools.ZvrColor;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name = "limitChange",		type = "zvr.zvrGUI.vo.events.ChartEvent")]
	[Event(name = "dataChange",			type = "zvr.zvrGUI.vo.events.ChartEvent")]
	[Event(name = "dataPointAdded",		type = "zvr.zvrGUI.vo.events.ChartEvent")]
	 
	public class Chart extends EventDispatcher
	{
		
		// BUG memory leek! unusable
		
		private var _points:Vector.<ChartPoint> = new Vector.<ChartPoint>;
		
		public var maxPoins:int = -1;
		
		private var _maxX:Number;
		private var _minX:Number;
		private var _maxY:Number;
		private var _minY:Number;
		
		private var _maxXid:int;
		private var _minXid:int;
		private var _maxYid:int;
		private var _minYid:int;
		
		public var visible:Boolean = true;
		public var color:uint = ColorsMD.c3;
		
		private var _maxValueColor:Number;
		private var _minValueColor:Number;
		
		private var _maxColor:uint;
		private var _minColor:uint;
		
		private var varMaxX:int;
		private var varMinX:int;
		private var varMaxY:int;
		private var varMinY:int;
		
		public var name:String = "Chart";
		
		public function Chart() 
		{
			
		}
		
		private function resetLimits():void
		{
			_maxX = NaN;
			_minX = NaN;
			_maxY = NaN;
			_minY = NaN;
		}
		
		private function updateLimits():void 
		{
			var i:int
			
			varMaxX = _points[0].x;
			varMaxY = _points[0].y;
			varMinX = _points[0].x;
			varMinY = _points[0].y;
			
			
			_maxXid = 0;
			_minXid = 0;
			_maxYid = 0;
			_minYid = 0;
			
			for (i = 1; i < _points.length; i++) 
			{
				if (_points[i].x > varMaxX) { varMaxX = _points[i].x; _maxXid = i; }
				if (_points[i].y > varMaxY) { varMaxY = _points[i].y; _maxYid = i; }
				if (_points[i].x < varMinX) { varMinX = _points[i].x; _minXid = i; }
				if (_points[i].y < varMinY) { varMinY = _points[i].y; _minYid = i; }
			}
			
			if (_maxX != varMaxX || _maxY != varMaxY || _minX != varMinX || _minY != varMinY)
			{				
				_maxX = varMaxX;
				_maxY = varMaxY;
				_minX = varMinX;
				_minY = varMinY;
				
				_dispatchEvent(ChartEvent.LIMIT_CHANGE);
				
			}
		}
		
		public function addPoint(point:ChartPoint):void
		{
			if (!_points) _points = new Vector.<ChartPoint>;
			
			if (maxPoins != -1 && _points.length > maxPoins) ChartPointGetter.utilizePoint(_points.shift());
			
			_points.push(point);
			_dispatchEvent(ChartEvent.DATA_POINT_ADDED);
			updateLimits();
		}
		
		public function get points():Vector.<ChartPoint> 
		{
			return _points;
		}
		
		public function set points(value:Vector.<ChartPoint>):void 
		{
			_points = value;
			_dispatchEvent(ChartEvent.DATA_CHANGE);
			updateLimits();
		}
		
		public function get maxXid():int 
		{
			return _maxXid;
		}
		
		public function get minXid():int 
		{
			return _minXid;
		}
		
		public function get maxYid():int 
		{
			return _maxYid;
		}
		
		public function get minYid():int 
		{
			return _minYid;
		}
		
		public function get maxX():Number 
		{
			return _maxX;
		}
		
		public function get minX():Number 
		{
			return _minX;
		}
		
		public function get maxY():Number 
		{
			return _maxY;
		}
		
		public function get minY():Number 
		{
			return _minY;
		}
		
		public function get maxValueColor():Number 
		{
			return isNaN(_maxValueColor) ? _maxY : _maxValueColor;
		}
		
		public function set maxValueColor(value:Number):void 
		{
			_maxValueColor = value;
		}
		
		public function get minValueColor():Number 
		{
			return isNaN(_minValueColor) ? _minY : _minValueColor;
		}
		
		public function set minValueColor(value:Number):void 
		{
			_minValueColor = value;
		}
		
		public function get maxColor():uint 
		{
			return isNaN(_maxColor) ? color : _maxColor;
		}
		
		public function set maxColor(value:uint):void 
		{
			_maxColor = value;
		}
		
		public function get minColor():uint 
		{
			return isNaN(_minColor) ? color : _minColor;
		}
		
		public function set minColor(value:uint):void 
		{
			_minColor = value;
		}
		
		public function getColor(y:Number):uint
		{
			if (!_maxColor || !_minColor) return color;
			var r:Number = (y - minValueColor) / (maxValueColor - minValueColor);
			return ZvrColor.fadeHex(minColor, maxColor, r);
		}
		
		public function getIDminX(min:Number):int
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				if (_points[i].x > min) return i;
			}
			return 0;
		}
		
		public function getIDmaxX(max:Number):int
		{
			for (var i:int = 0; i < _points.length; i++) 
			{
				if (_points[i].x > max) return i;
			}
			return _points.length - 1;
		}
		
		private function _dispatchEvent(type:String):void
		{
			dispatchEvent(new ChartEvent(type, this));
		}
		
	}

}