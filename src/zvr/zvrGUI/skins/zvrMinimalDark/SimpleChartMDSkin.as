package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import com.foxaweb.utils.Raster;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.ZvrTools.ZvrColor;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class SimpleChartMDSkin extends ZvrSkin 
	{
		private var _bitmap:Bitmap = new Bitmap();
		private var _bitmapData:Raster;
		protected var rectangle:Rectangle = new Rectangle(0, 0, 1, 0);
		private var _lastPoints:Object = {};
		
		public function SimpleChartMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			_bitmapData = new Raster(1, 1);
			_bitmap.bitmapData = _bitmapData;
			_body = new Sprite();
			sprite.addChild(_bitmap);
		}
		
		override protected function updateSize():void 
		{
			
			var bd:Raster = new Raster(componentWidth, componentHeight, true, 0x38772D);
			var m:Matrix = new Matrix();
			m.tx = componentWidth - _bitmapData.width;
			m.ty = componentHeight - _bitmapData.height;
			
			bd.draw(_bitmap, m);
			_bitmapData = bd;
			_bitmap.bitmapData = _bitmapData;
			rectangle.x = componentWidth - 1,
			rectangle.height = componentHeight;
			
		}
		
		public function redraw(points:Array, scroll:int = 1):void
		{
			_bitmapData.scroll( -points.length, 0);
			
			rectangle.x = componentWidth - points.length,
			rectangle.width = points.length,

			
			_bitmapData.fillRect(rectangle, 0x00000000);
			_bitmapData.lock();
			
			for (var i:int = 0; i < points.length; i++) 
			{
				
				var s:int = points.length - i;
				
				for (var j:int = 0; j < points[i].length; j++) 
				{
					var lp:Number = _lastPoints[points[i][j].color];
				
					if (isNaN(lp))
					{
						_bitmapData.setPixel32(componentWidth - s,  componentHeight - points[i][j].value, ZvrColor.ARGBfromRGBandA(points[i][j].color, 1));	
					}
					else
					{
						_bitmapData.line(componentWidth - (s+1), componentHeight - lp, componentWidth - s, componentHeight - points[i][j].value, ZvrColor.ARGBfromRGBandA(points[i][j].color, 1));
					}
					
					_lastPoints[points[i][j].color] = points[i][j].value;
				}
				
			}
			_bitmapData.unlock();
		}
		
		public function clear():void 
		{
			
		}
		
		private function get sprite():Sprite
		{
			return Sprite(_body);
		}
	}

}