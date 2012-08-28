package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.BitmapFont2D;
	import de.nulldesign.nd2d.display.BitmapFont2DZVR;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import de.nulldesign.nd2d.materials.texture.TextureOption;
	import flash.display.BitmapData;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	/**
	 * ...
	 * @author Zvir
	 */
	public class FontTextureGenerator 
	{
		
		public static var textField:TextField = new TextField();
		public static const commonChar1:String ="  !\"%<'()^+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ"
		public static const commonChar2:String ="  !\"%<'()^+,-./0123456789:;<=>?@abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
		
		public function FontTextureGenerator() 
		{
			
			
			
		}
		
		public static function texture(chars:String, font:String, fontSize:Number, fontColor:uint, charWidth:Number, charHeight:Number, maxTextLen:uint, spritesPackedWithoutSpaces:Boolean = false):BitmapFont2DZVR
		{
			
			textField.embedFonts = true;
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.border = true;
			var tf:TextFormat = textField.getTextFormat();
			tf.font = font;
			tf.size = fontSize;
			tf.color = fontColor;
			textField.defaultTextFormat = tf;
			textField.setTextFormat(tf);
			
			var area:Number = charWidth * chars.length * charHeight;
			var pow:Number = Math.ceil(logx(Math.sqrt(area), 2));
			var nw:Number = Math.pow(2, pow);
			nw =  Math.floor(nw / charWidth) * charWidth;
			var charX:int =  Math.floor(nw / charWidth);
			var nh:Number = Math.ceil(chars.length / charX) * charHeight;
			
			textField.width = nw;
			
			trace(nw, nh);
			
			var bd:BitmapData = new BitmapData(nw, nh, true, 0x00000000);
			
			var cbd:BitmapData = new BitmapData(charWidth, charHeight, true, 0x00000000);
			
			var nx:int;
			var ny:int;
			
			var r:Rectangle = new Rectangle(0, 0, charWidth, charHeight);
			var rf:Rectangle;
			var p:Point = new Point();
			var spicing:Array = [];
			var m:Matrix = new Matrix();
			
			
			for (var i:int = 0; i < chars.length; i++) 
			{
				textField.text = chars.charAt(i);
				
				
				rf = textField.getCharBoundaries(0);
				//trace(rf, textField.text);
				
				m.identity();
				
				rf && m.translate( -rf.x, -rf.y);
				spicing.push(rf.width);
				cbd.fillRect(cbd.rect, 0x00000000);
				cbd.draw(textField, m);
				
				p.x = nx;
				p.y = ny;
				
				bd.copyPixels(cbd, r, p);
				
				nx += charWidth;
				
				if (nx + charWidth > nw)
				{
					nx = 0;
					ny += charHeight;
				}
				
			}
			
			
			var t:Texture2D = Texture2D.textureFromBitmapData(bd);
			t.textureOptions = TextureOption.QUALITY_LOW;
			return new BitmapFont2DZVR(t, charWidth, charHeight, chars, spicing, maxTextLen);
			
		}
		
		public static function logx(val:Number, base:Number = 10):Number
		{
			return Math.log(val) / Math.log(base);
		}
		
	}

}