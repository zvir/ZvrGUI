package zvr.zvrGUI.skins.base 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrComponent;
	import fl.motion.Color;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.ZvrTools.ZvrTransform;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBitmapSkin extends ZvrSkin
	{
		
		private var _bitmap:Bitmap = new Bitmap();
		
		public function ZvrBitmapSkin(bitmapComponent:ZvrBitmap, registration:Function) 
		{
			super(bitmapComponent, registration);
		}
		
		override protected function create():void 
		{
			_body = _bitmap;
			updateBitmap();
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ZvrStyles.BITMAP, updateBitmap);
			registerStyle(ZvrStyles.COLOR, updateColor);
			registerStyle(ZvrStyles.COLOR_ALPHA, updateColor);
		}
		
		override protected function setStyles():void 
		{
			setStyle(ZvrStyles.COLOR_ALPHA, 0);
			setStyle(ZvrStyles.COLOR, 0);
		}
		
		private function updateColor():void 
		{
			if (_bitmap)
			{
				ZvrTransform.tint(_bitmap, getStyle(ZvrStyles.COLOR), getStyle(ZvrStyles.COLOR_ALPHA));
			}
		}
		
		private function updateBitmap():void 
		{
			var b:BitmapData;
			
			b = getStyle(ZvrStyles.BITMAP);
			
			if (b)
			{
				_bitmap.bitmapData = b;
			}
			else
			{
				_bitmap.bitmapData = null;
			}
			
			if (bitmapComponent.autoSize)
			{
				updateComponentSize(_bitmap.width, _bitmap.height);
			}
		}
		
		override protected function updateSize():void 
		{
			if (bitmapComponent.scaleMode) return;
			_bitmap.width = componentWidth;
			_bitmap.height = componentHeight;
		}
		
		private function get bitmapComponent():ZvrBitmap
		{
			return ZvrBitmap(_component);
		}
		
		public function get bitmap():Bitmap 
		{
			return _bitmap;
		}
		
	}

}