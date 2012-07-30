package zvr.zvrTools 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvtGraphics 
	{
		
		public static function drawOctagon(graphics:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{

			var xa:Number = width / 2.414;
			var ya:Number = height / 2.414;
			
			var xas:Number = xa/1.41421356;
			var yas:Number = ya/1.41421356;
			
			var x0:Number = x + xas;
			var x1:Number = x0 + xa;
			var x2:Number = x1 + xas;
			
			var y0:Number = y + yas;
			var y1:Number = y0 + ya;
			var y2:Number = y1 + yas;

			graphics.moveTo(x0, y);
			graphics.lineTo(x1, y);
			graphics.lineTo(x2, y0);
			graphics.lineTo(x2, y1);
			graphics.lineTo(x1, y2);
			graphics.lineTo(x0, y2);
			graphics.lineTo(x, y1);
			graphics.lineTo(x, y0);
			graphics.lineTo(x0, y);
			
		}
		
		public static function drawIsoscelesTraingle(graphics:Graphics, x:Number, y:Number, width:Number, height:Number):void
		{
			graphics.moveTo(x + width * 0.5, y);
			graphics.lineTo(x + width, y + height);
			graphics.lineTo(x, y + height);
			graphics.lineTo(x + width * 0.5, y);
		}
		
	}

}