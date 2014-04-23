package zvr.zvrGUI.skins.base 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrComponent;
	//import fl.motion.Color;
	import zvr.zvrGUI.layouts.ZvrBitmapAutoSize;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrTools.ZvrTransform;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBitmapSkin extends ZvrSkin
	{
		
		private var _bitmap:ZvrFlashBitmapSkin = new ZvrFlashBitmapSkin();
		
		public function ZvrBitmapSkin(bitmapComponent:ZvrComponent, registration:Function) 
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
			registerStyle(ZvrStyles.AUTO_SIZE, updateBitmapSize);
		}
	
		
		override protected function setStyles():void 
		{
			setStyle(ZvrStyles.COLOR_ALPHA, 0);
			setStyle(ZvrStyles.COLOR, 0);
			setStyle(ZvrStyles.AUTO_SIZE, ZvrBitmapAutoSize.AUTO_TO_NO_SCALE);
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
			updateBitmapSize();
			
		}
		
		override protected function updateSize():void 
		{
			super.updateSize();
			updateBitmapSize();
			_component.validateBounds(false);
		}
		
		protected function updateBitmapSize():void 
		{
			
			var a:String = getStyle(ZvrStyles.AUTO_SIZE);
			
			if (!_bitmap.bitmapData) return;
			
			if (a == ZvrBitmapAutoSize.AUTO_TO_NO_SCALE)
			{
				updateComponentSize(_bitmap.bitmapData.width, _bitmap.bitmapData.height);
				_bitmap.width = _bitmap.bitmapData.width;
				_bitmap.height = _bitmap.bitmapData.height;
			}
			else if (a == ZvrBitmapAutoSize.NO_SCALE_TO_MAUAL)
			{
				_bitmap.x = componentWidth * 0.5 - _bitmap.width * 0.5;
				_bitmap.y = componentHeight * 0.5 - _bitmap.height * 0.5;
			}
			else if (a == ZvrBitmapAutoSize.FILL)
			{
				_bitmap.width = componentWidth;
				_bitmap.height = componentHeight;
			}
			else if (a == ZvrBitmapAutoSize.KEEP_RATIO_INSIDE)
			{
				var br:Number = _bitmap.bitmapData.width / _bitmap.bitmapData.height;
				var vr:Number = componentWidth / componentHeight;
				
				if (br < vr)
				{
					_bitmap.height = componentHeight;
					_bitmap.width = _bitmap.height * br;
				}
				else
				{
					_bitmap.width = componentWidth;
					_bitmap.height = _bitmap.width / br;
				}
				
				_bitmap.x = -(_bitmap.width - componentWidth) * 0.5;
				_bitmap.y = -(_bitmap.height - componentHeight) * 0.5;
			}
			else if (a == ZvrBitmapAutoSize.KEEP_RATIO_OUTSIDE)
			{
				br = _bitmap.bitmapData.width / _bitmap.bitmapData.height;
				vr = componentWidth / componentHeight;
				
				if (br > vr)
				{
					_bitmap.height = componentHeight;
					_bitmap.width = _bitmap.height * br;
				}
				else
				{
					_bitmap.width = componentWidth;
					_bitmap.height = _bitmap.width / br;
				}
				
				_bitmap.x = -(_bitmap.width - componentWidth) * 0.5;
				_bitmap.y = -(_bitmap.height - componentHeight) * 0.5;
			}
			
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