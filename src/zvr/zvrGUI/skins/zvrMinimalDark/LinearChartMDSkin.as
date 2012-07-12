package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import com.foxaweb.utils.Raster;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import zvr.zvrGUI.components.minimalDark.LinearChartMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.vo.charts.Chart;
	import zvr.zvrGUI.vo.charts.ChartPoint;
	import zvr.ZvrTools.ZvrColor;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class LinearChartMDSkin extends ZvrSkin 
	{
		
		public static const BITMAP_DOTS		:String = "dots";
		public static const BITMAP_LINES	:String = "lines";
		public static const VECTOR			:String = "vector";
		
		private var _bitmap:Bitmap = new Bitmap();
		private var _bitmapData:Raster;
		private var _doUpdate:Boolean = false;
		private var _doUpdateGrid:Boolean = false;
		private var _startPont:Point = new Point(0, 0);
		private var _chartType:String = BITMAP_LINES;
		
		
		public function LinearChartMDSkin(chart:LinearChartMD, registration:Function) 
		{
			super(chart, registration);	
		}
		
		public function update():void 
		{
			_doUpdate = true;
			_doUpdateGrid = true;
		}
		
		override protected function create():void 
		{
			_bitmapData = new Raster(1, 1);
			_bitmap.bitmapData = _bitmapData;
			_body = new Sprite();
			sprite.addEventListener(Event.EXIT_FRAME, render);
			sprite.addChild(_bitmap);
		}
		
		private function render(e:Event):void 
		{
			if (_doUpdate) redraw();
			_doUpdate = false;
		}
		
		override protected function setStyles():void 
		{
			// DOTO
		}
		
		override protected function updateSize():void 
		{
			_bitmapData = new Raster(componentWidth, componentHeight, true, 0x000000);
			_bitmap.bitmapData = _bitmapData;
			_doUpdateGrid = true;
		}
		
		private function redraw():void
		{
			return;
			_bitmapData.lock();
			_bitmapData.fillRect(_bitmap.bitmapData.rect, 0x000000);
			
			
			//if (_chartType == BITMAP_DOTS || _chartType == BITMAP_LINES) drawBitmapGrid();
			if (_chartType == BITMAP_DOTS) drawDotChart();
			if (_chartType == BITMAP_LINES) drawLineChart();
			
			_bitmapData.unlock();
			
			if (_chartType == VECTOR)
			{
				sprite.graphics.clear();
				sprite.graphics.beginFill(0x000000, 0);
				sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
				sprite.graphics.endFill();
				drawVectorGrid();
				drawVectorChart();
			}
		}
		
		private function drawBitmapGrid():void
		{
			var i:Number;
			
			var h:Number = componentHeight;
			var w:Number = componentWidth;
			
			var xOfset:Number = (chart.horizontalBegin % chart.gridSize) * (w / chart.horizontalRange);
			var yOfset:Number = (chart.verticalBegin % chart.gridSize) * (h / chart.verticalRange);
			
			var c:uint = ZvrColor.ARGBfromRGBandA(ColorsMD.c5, 1);
			
			var a:Array = new Array();
			
			var stepX:Number = w * chart.gridSize / chart.horizontalRange;
			var stepY:Number = h * chart.gridSize / chart.verticalRange;
			
			for (i = 0; i < w + xOfset; i = i + stepX) 
			{
				_bitmapData.line(i - xOfset, 0, i - xOfset, h, c);
			}
			
			for (i = 0; i < h + yOfset; i = i + stepY)
			{
				_bitmapData.line(0, i - yOfset, w, i - yOfset, c);
			}
			
			_bitmapData.line(0, -chart.verticalBegin* (h / chart.verticalRange) , w, -chart.verticalBegin* (h / chart.verticalRange), ZvrColor.ARGBfromRGBandA(ColorsMD.c3, 1));
			
		}
		
		private function drawLineChart():void
		{
			if (chart.dataProvider.length == 0) return;
			var i:int
			
			var sx:Number = componentWidth / chart.horizontalRange;
			var sy:Number = componentHeight / chart.verticalRange;
			
			for (var j:int = 0; j < chart.dataProvider.length; j++) 
			{	
				var c:Chart = chart.dataProvider[j];
				if (c.points.length != 0)
				{
					var s:int = c.getIDminX(chart.horizontalBegin);
					var e:int = c.getIDmaxX(chart.horizontalEnd);
					var m:int = Math.min(e, c.points.length - 1);
					
					var p:ChartPoint =  c.points[Math.min(int(s), c.points.length - 1)];
					
					for (i = s; i < m; i++) 
					{	
						var p1:ChartPoint = c.points[i];
						var p2:ChartPoint = c.points[i + 1];
						if (!(p2.y == p1.y && i < m - 1))
						{
							var color:uint = ZvrColor.ARGBfromRGBandA(c.getColor(p.y), 1);
							_bitmapData.line((p.x - chart.horizontalBegin)* sx, (-p.y - chart.verticalBegin)* sy, (p1.x - chart.horizontalBegin)* sx, (-p1.y - chart.verticalBegin)* sy, color);
							_bitmapData.line((p1.x - chart.horizontalBegin)* sx, (-p1.y - chart.verticalBegin)* sy, (p2.x - chart.horizontalBegin)* sx, (-p2.y - chart.verticalBegin)* sy, color);
							p = p2;
						}	
					}
				}
			}
		}
		
		
		private function drawDotChart():void
		{
			if (chart.dataProvider.length == 0) return;
			var i:int = 0;
			
			var sx:Number = componentWidth / chart.horizontalRange;
			var sy:Number = componentHeight / chart.verticalRange;
			
			var r:Rectangle = new Rectangle();
			
			for (var j:int = 0; j < chart.dataProvider.length; j++) 
			{
				var c:Chart = chart.dataProvider[j];
				if (c.points.length != 0)
				{
					var s:int = c.getIDminX(chart.horizontalBegin);
					var e:int = c.getIDmaxX(chart.horizontalEnd);
					var m:int = Math.min(e, c.points.length - 1);

					for (i = s; i < m; i++) 
					{	
						var p:ChartPoint = c.points[i];
						var color:uint = ZvrColor.ARGBfromRGBandA(c.getColor(p.y), 1);
						
						//_bitmapData.setPixel32((p.x  - chart.horizontalBegin) * sx, ( - p.y - chart.verticalBegin) * sy, color);
						
						
						
						r.x = (p.x  - chart.horizontalBegin) * sx;
						r.y = ( - p.y - chart.verticalBegin) * sy;
						r.width = 2;
						r.height = 2;
						
						_bitmapData.fillRect(r, color);
					}
				}
			}
		}
		
		private function drawVectorGrid():void 
		{
			
			var c:uint = ColorsMD.c5;
			
			var i:Number;
			
			sprite.graphics.lineStyle(1, c);
			
			var h:Number = componentHeight;
			var w:Number = componentWidth;
			
			var xOfset:Number = (chart.horizontalBegin % chart.gridSize) * (w / chart.horizontalRange);
			var yOfset:Number = (chart.verticalBegin % chart.gridSize) * (h / chart.verticalRange);

			var stepX:Number = w * chart.gridSize / chart.horizontalRange;
			var stepY:Number = h * chart.gridSize / chart.verticalRange;
			
			for (i = 0; i < w + xOfset; i = i + stepX) 
			{
				sprite.graphics.moveTo(i - xOfset, 0);
				sprite.graphics.lineTo(i - xOfset, h);
			}
			
			for (i = 0; i < h + yOfset ; i = i + stepY) 
			{
				sprite.graphics.moveTo(0, i - yOfset);
				sprite.graphics.lineTo(w, i - yOfset);
			}
			
			sprite.graphics.lineStyle(1, ColorsMD.c3);
			sprite.graphics.moveTo(0, -chart.verticalBegin* (h / chart.verticalRange));
			sprite.graphics.lineTo(w, -chart.verticalBegin* (h / chart.verticalRange));
			
		}
		
		private function drawVectorChart():void
		{
			if (chart.dataProvider.length == 0) return;
			
			var i:int
			
			var sx:Number = componentWidth / chart.horizontalRange;
			var sy:Number = componentHeight / chart.verticalRange;
			
			for (var j:int = 0; j < chart.dataProvider.length; j++) 
			{
				
				var c:Chart = chart.dataProvider[j];
				if (c.points.length != 0)
				{
					var s:int = c.getIDminX(chart.horizontalBegin);
					var e:int = c.getIDmaxX(chart.horizontalEnd);
					var m:int = Math.min(e, c.points.length - 1);
					
					var p:ChartPoint =  c.points[Math.min(int(s), c.points.length - 1)];
					
					for (i = s; i < m; i++) 
					{	
						var p1:ChartPoint = c.points[i];
						var p2:ChartPoint = c.points[i + 1];
						
						
						if (!(p2.y == p1.y && i < m - 1))
						{
							var color:uint = c.getColor(p1.y);
							sprite.graphics.lineStyle(1, color);
							
							sprite.graphics.moveTo((p.x - chart.horizontalBegin) * sx, ( -p.y - chart.verticalBegin) * sy);
							sprite.graphics.lineTo((p1.x - chart.horizontalBegin)* sx, (-p1.y - chart.verticalBegin)* sy);
							sprite.graphics.moveTo((p1.x - chart.horizontalBegin) * sx, ( -p1.y - chart.verticalBegin) * sy);
							sprite.graphics.lineTo((p2.x - chart.horizontalBegin)* sx, (-p2.y - chart.verticalBegin)* sy);
							
							p = p2;
							
						}
					}
				}
			}
			
		}
		
		
		
		
		
		
		private function get chart():LinearChartMD
		{
			return LinearChartMD(_component);
		}
		
		public function get chartType():String 
		{
			return _chartType;
		}
		
		public function set chartType(value:String):void 
		{
			
			if (_chartType == value) return;
			
			if ((_chartType == BITMAP_DOTS || _chartType == BITMAP_LINES) && value == VECTOR)
			{
				_bitmapData.fillRect(new Rectangle(0, 0, _bitmap.width, _bitmap.height), 0x000000);
				_bitmap.visible = false;
			}
			else
			{
				_bitmap.visible = true;
				sprite.graphics.clear();
			}
			
			_chartType = value;
			update();
		}
		
		
		private function get sprite():Sprite
		{
			return Sprite(_body);
		}
		
	}

}