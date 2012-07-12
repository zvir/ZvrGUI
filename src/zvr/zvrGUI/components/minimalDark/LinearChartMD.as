package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.LinearChartMDSkin;
	import zvr.zvrGUI.vo.charts.Chart;
	import zvr.zvrGUI.vo.charts.ChartPoint;
	import zvr.zvrGUI.vo.events.ChartEvent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class LinearChartMD extends ZvrComponent 
	{
		
		private var _dataProviders:Vector.<Chart> = new Vector.<Chart>;
		private var _gridSize:Number = 50;
		private var _scroll:ZvrScroller;
		
		private var _testP:Number;
		
		public function LinearChartMD() 
		{
			super(LinearChartMDSkin);	
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			addEventListener(MouseEvent.CLICK, click);
		}
		
		private function click(e:MouseEvent):void 
		{
			//trace(chart.chartType);
			if (chart.chartType == LinearChartMDSkin.BITMAP_DOTS) { chart.chartType = LinearChartMDSkin.BITMAP_LINES; return};
			if (chart.chartType == LinearChartMDSkin.BITMAP_LINES) {chart.chartType = LinearChartMDSkin.VECTOR;return};
			if (chart.chartType == LinearChartMDSkin.VECTOR) {chart.chartType = LinearChartMDSkin.BITMAP_DOTS;return};
		}
		
		public function addChart(chartData:Chart):void
		{
			_dataProviders.push(chartData);
			chartData.addEventListener(ChartEvent.DATA_CHANGE, dataChange);
			chartData.addEventListener(ChartEvent.DATA_POINT_ADDED, addedPoint);
			updateScroll();
			chart.update();
		}
		
		private function addedPoint(e:ChartEvent):void 
		{
			updateScroll();
			chart.update();
		}
		
		public function get dataProvider():Vector.<Chart> 
		{
			return _dataProviders;
		}
		
		private function get chart():LinearChartMDSkin
		{
			return LinearChartMDSkin(_skin);
		}
		
		public function get gridSize():Number 
		{
			return _gridSize;
		}
		
		public function set gridSize(value:Number):void 
		{
			_gridSize = value;
		}
		
		public function set scroll(value:ZvrScroller):void 
		{
			_scroll = value;
			
			_scroll.customScroll = true;
			
			_scroll.verticalScroll.dynamicRange = true;
			_scroll.verticalScroll.min = 0;
			_scroll.verticalScroll.rangeBegin = 0;
			_scroll.verticalScroll.max = _bounds.height;
			_scroll.verticalScroll.range = _bounds.height;
			//_scroll.verticalScroll.boundsSnap = true;
			
			_scroll.horizontalScroll.dynamicRange = true;
			_scroll.horizontalScroll.min = 0;
			_scroll.horizontalScroll.rangeBegin = 0;
			_scroll.horizontalScroll.max =  _bounds.width;
			_scroll.horizontalScroll.range = _bounds.width;
			_scroll.horizontalScroll.boundsSnap = true;
			_scroll.horizontalScroll.snapPrority = ZvrScroll.MAX;

			_scroll.horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
			_scroll.horizontalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			
			updateScroll();
		}
		
		private function scrollChange(e:ZvrScrollEvent):void 
		{
			chart.update();
		}
		
		private function updateScroll(sizeDelta:Point = null):void
		{
			
			if (!_scroll) return;
			
			if (_dataProviders.length == 0) return;
		
			var my:Number = bounds.height / 10;
			
			var maxY:Number
			var maxX:Number
			var minY:Number
			var minX:Number
			
			for (var i:int = 0; i < _dataProviders.length; i++) 
			{
				var c:Chart = _dataProviders[i];
				maxY = isNaN(maxY) ? c.maxY : Math.max(c.maxY, maxY);
				maxX = isNaN(maxX) ? c.maxX : Math.max(c.maxX, maxX);
				minY = isNaN(minY) ? c.minY : Math.min(c.minY, minY);
				minX = isNaN(minX) ? c.minX : Math.min(c.minX, minX);
			}
			
			_scroll.verticalScroll.min = -maxY - my;
			_scroll.verticalScroll.max = -minY + my;
			
			_scroll.verticalScroll.range *=  bounds.height / (bounds.height + (sizeDelta ? sizeDelta.y : 0 ));
			
			_scroll.horizontalScroll.min = minX;
			_scroll.horizontalScroll.max = maxX;
			_scroll.horizontalScroll.range *= bounds.width / (bounds.width + ( sizeDelta ? sizeDelta.x : 0));
			
			_scroll.updateScrollsState();
			//_scroll.wheelScrollDelta = bounds.height / _scroll.horizontalScroll.range * 10;
			
		}
		
		private function dataChange(e:ChartEvent):void 
		{
			updateScroll();
			chart.update();
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			if (_scroll)
			{
				var pv:Number = _scroll.verticalScroll.percentagePosition;
				var ph:Number = _scroll.horizontalScroll.percentagePosition;
				var pr:Number = _scroll.horizontalScroll.percentageRange;
			}
			
			updateScroll(e.delta);
			
			if (_scroll)
			{
				_scroll.verticalScroll.percentagePosition = pv;
				_scroll.horizontalScroll.percentagePosition = pr > 1 ? 1 : ph;
			}
		}
		
		public function get horizontalBegin():Number
		{
			return _scroll ? _scroll.horizontalScroll.rangeBegin : 0;
		}
		
		public function get verticalBegin():Number
		{
			return _scroll ? _scroll.verticalScroll.rangeBegin : 0;
		}
		
		public function get horizontalEnd():Number
		{
			return _scroll ? _scroll.horizontalScroll.rangeEnd : 100;
		}
		
		public function get verticalEnd():Number
		{
			return _scroll ? _scroll.verticalScroll.rangeEnd : 100;
		}
		
		public function get horizontalRange():Number
		{
			return _scroll ? _scroll.horizontalScroll.range : 100;
		}
		
		public function get verticalRange():Number
		{
			return _scroll ? _scroll.verticalScroll.range : 100;
		}
		
		public function set chatType(value:String):void
		{
			chart.chartType = value;
		}
		
	}

}