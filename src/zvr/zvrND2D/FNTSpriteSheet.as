package zvr.zvrND2D
{
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class FNTSpriteSheet extends ASpriteSheetBase 
	{
		
		public var kernings:Object = new Object();
		
		public var paddingLeft:Number = 0;
		public var paddingTop:Number = 0;
		public var paddingRight:Number = 0;
		public var paddingBotton:Number = 0;
		
		public function FNTSpriteSheet(sheetWidth:Number, sheetHeight:Number, fnt:XML = null) 
		{
			super();
			
			_sheetWidth = sheetWidth;
			_sheetHeight = sheetHeight;
			
			if (!fnt) return;
			
			var padding:String = fnt.info.@padding;
			var paddings:Array = padding.split(",");
			
			paddingTop     = paddings[0];
			paddingRight   = paddings[1];
			paddingBotton  = paddings[2];
			paddingLeft    = paddings[3];
			
			for each (var kerning:XML in fnt.kernings.kerning)
			{
				var f:int = kerning.@first;
				var s:int = kerning.@second;
				var k:int = kerning.@amount;
				
				if (kernings[f] == undefined)
				{
					kernings[f] = {};
				}
				
				kernings[f][s] = k;
			}
			
			_spriteHeight = 0;
			_spriteWidth = 0;
			
			for each (var char:XML in fnt.chars.char)
			{
				var id:int = char.@id;
				var x:int = char.@x;
				var y:int = char.@y;
				var width:int = char.@width;
				var height:int = char.@height;
				var xoffset:Number = char.@xoffset;
				var yoffset:Number = char.@yoffset;
				
				xoffset = xoffset * 0.5;// - width * 0.5;
				yoffset = yoffset * 0.5;// - height * 0.5;
				
				//xoffset = 0;
				//yoffset = 0;
				
				if (width < 2 || height < 2) continue;
				
				_spriteHeight = height > _spriteHeight ? height : _spriteHeight;
				_spriteWidth = width > _spriteWidth ? width : _spriteWidth;
				
				frames.push(new Rectangle(x, y, width, height));
				offsets.push(new Point(xoffset, yoffset));
				
				frameNameToIndex[id.toString()] = frames.length-1;
			}
			
			uvRects = new Vector.<Rectangle>(frames.length, true);
			frame = 0;
		}
		
		override public function clone():ASpriteSheetBase {

			var s:FNTSpriteSheet = new FNTSpriteSheet(_sheetWidth, _sheetHeight);
			
			s.frames = frames;
			s.offsets = offsets;
			s.frameNameToIndex = frameNameToIndex;
			s.uvRects = uvRects;
			s.frame = frame;
			
			s.paddingTop     = paddingTop    ;
			s.paddingRight   = paddingRight  ;
			s.paddingBotton  = paddingBotton ;
			s.paddingLeft    = paddingLeft   ;
			
			return s;
		}
	}

}