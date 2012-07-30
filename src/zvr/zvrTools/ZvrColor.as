package zvr.zvrTools
{
	import flash.display.BitmapData;
	import flash.filters.ColorMatrixFilter;
	
	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrColor
	{
		
		static public const rainbow:Array = [0xff0000, 0xffff00, 0x00ff00, 0x00ffff, 0x0000ff, 0xff00ff];
		
		static public function fadeHex(hex:uint, hex2:uint, ratio:Number):uint
		{
			
			ratio = ratio < 0 ? 0 : ratio;
			ratio = ratio > 1 ? 1 : ratio;
			
			var r:uint = hex >> 16;
			var g:uint = hex >> 8 & 0xFF;
			var b:uint = hex & 0xFF;
			
			r += ((hex2 >> 16) - r) * ratio;
			g += ((hex2 >> 8 & 0xFF) - g) * ratio;
			b += ((hex2 & 0xFF) - b) * ratio;
			
			return (r << 16 | g << 8 | b);
		}
		
		static public function fadeHexArray(hexArray: /*uint*/Array, ratio:Number):uint
		{
			ratio = ratio < 0 ? 0 : ratio;
			ratio = ratio > 1 ? 1 : ratio;
			
			
			var l:int = hexArray.length - 1;
			if (l == 1)
				return fadeHex(hexArray[0], hexArray[1], ratio);
			if (l == 0)
				return hexArray[0];
			var i:int = Math.floor(l * ratio);
			var r:Number = (ratio - i / l) * (l);
			return fadeHex(hexArray[i], hexArray[i + 1], r);
		}
		
		static public function ARGBfromRGBandA(rgb:uint, alpha:Number = 1):uint
		{
			var a:uint = 255 * alpha;
			
			var argb:uint = 0;
			argb += (a << 24);
			argb += (rgb);
			return argb;
		}
		
		/**
		 * Matrix utility class
		 * @version 1.0
		 * so far added:
		 * - brightness
		 * - contrast
		 * - saturation
		 */ /**
		 * sets brightness value available are -100 ~ 100 @default is 0
		 * @param       value:int   brightness value
		 * @return      ColorMatrixFilter
		 */
		public static function setBrightness(value:Number):ColorMatrixFilter
		{
			value = value * (255 / 250);
			
			var m:Array = new Array();
			m = m.concat([1, 0, 0, 0, value]); // red
			m = m.concat([0, 1, 0, 0, value]); // green
			m = m.concat([0, 0, 1, 0, value]); // blue
			m = m.concat([0, 0, 0, 1, 0]); // alpha
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * sets contrast value available are -100 ~ 100 @default is 0
		 * @param       value:int   contrast value
		 * @return      ColorMatrixFilter
		 */
		public static function setContrast(value:Number):ColorMatrixFilter
		{
			value /= 100;
			var s:Number = value + 1;
			var o:Number = 128 * (1 - s);
			
			var m:Array = new Array();
			m = m.concat([s, 0, 0, 0, o]); // red
			m = m.concat([0, s, 0, 0, o]); // green
			m = m.concat([0, 0, s, 0, o]); // blue
			m = m.concat([0, 0, 0, 1, 0]); // alpha
			
			return new ColorMatrixFilter(m);
		}
		
		public static function setAlpha(v:Number):ColorMatrixFilter
		{
			return new ColorMatrixFilter
			(
				[				   
					1, 0, 0, 0, 0, 		// red
					0, 1, 0, 0, 0,      // green
					0, 0, 1, 0, 0,      // blue
					0, 0, 0, v, 0   // alpha
				]
			);
		}
		
		/**
		 * sets saturation value available are -1 ~ 1 @default is 0
		 * @param       value:int   saturation value
		 * @return      ColorMatrixFilter
		 */
		public static function setSaturation(value:Number):ColorMatrixFilter
		{
			const lumaR:Number = 0.212671;
			const lumaG:Number = 0.71516;
			const lumaB:Number = 0.072169;
			
			var v:Number = (value) + 1;
			var i:Number = (1 - v);
			var r:Number = (i * lumaR);
			var g:Number = (i * lumaG);
			var b:Number = (i * lumaB);
			
			var m:Array = new Array();
			m = m.concat([(r + v), g, b, 0, 0]); // red
			m = m.concat([r, (g + v), b, 0, 0]); // green
			m = m.concat([r, g, (b + v), 0, 0]); // blue
			m = m.concat([0, 0, 0, 1, 0]); // alpha
			
			return new ColorMatrixFilter(m);
		}
		
		/**
		 * sets saturation value available are -1 ~ 1 @default is 0
		 * @param       value:int   saturation value
		 * @return      ColorMatrixFilter
		 */
		
		public static function averageColor( source:BitmapData ):uint
		{
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			var count:Number = 0;
			var pixel:Number;
			
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					count++
				}
			}

			red /= count;
			green /= count;
			blue /= count;

			return red << 16 | green << 8 | blue;
		}
		
		public static function RGBToHSV(color:uint):Array
		{
			var red:Number = (color >> 16 & 0xFF) / 255;
			var green:Number = (color >> 8 & 0xFF) / 255;
			var blue:Number = (color & 0xFF) / 255;
			var min:Number, max:Number, delta:Number;

			min = Math.min(red, green, blue);
			max = Math.max(red, green, blue);
			var v:Number = max;
			// v
			var h:Number;
			delta = max - min;
			var s:Number;
			if (max != 0) {
				s = delta / max; // s
			} else {
				// r = g = b = 0		// s = 0, v is undefined
				s = 0;
				h = -1;
				return new Array(h, s * 100, v);
			}

			if (red == max) {
				h = (green - blue) / delta; // between yellow & magenta
			} else if (green == max) {

				h = 2 + (blue - red) / delta; // between cyan & yellow
			} else {
				h = 4 + (red - green) / delta; // between magenta & cyan
			}
			h *= 60;
			// degrees
			if (h < 0) {
				h += 360;
			}
			return [h, s, v];
		}
		
	}

}