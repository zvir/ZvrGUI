package zvr.zvrND2D
{
	import com.tests.*;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.events.Event;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "change", type = "flash.events.Event")] 
	
	
	public class FNTSprite extends Sprite2DBatch 
	{
		
		private var _textChanged:Boolean = false;
		
		private var _text:String;
		private var _spacing:Number = 0;
		
		public function FNTSprite(textureObject:Texture2D) 
		{
			super(textureObject);
		}
		
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if (text != value)
			{
				_text = value;
				_textChanged = true;
				textChanged();
			}
		}
		
		public function get spacing():Number 
		{
			return _spacing;
		}
		
		public function set spacing(value:Number):void 
		{
			if (_spacing != value)
			{
				_spacing = value;
				_textChanged = true;
				textChanged();
			}
		}
		
		
		public function textChanged():void
		{

			if (!_textChanged) return;
			if (!_text) return;
			
			
			
			const numSpaces:uint = _text.split(" ").length - 1;
			const text_length:int = _text.length;
			const childsNeeded:uint = text_length - numSpaces;
			
			while (numChildren < childsNeeded)
			{
				addChild(new Sprite2D());
			}
			
			while (numChildren > childsNeeded)
			{
				removeChildAt(0);
			}
			
			var s:Sprite2D;
			var curChar:int;
			var frame:int;
			var childIdx:uint = 0;
			var startX:Number = spriteSheet.spriteWidth >> 1;
			var space:int = -1;
			
			var fntSpriteSheet:FNTSpriteSheet = FNTSpriteSheet(spriteSheet);
			
			var lastX:Number = spriteSheet.spriteWidth >> 1;
			var lastWidth:Number = 0;
			
			for (var i:int = 0; i < text_length; i++)
			{
				curChar = _text.charCodeAt(i);
				
				frame = spriteSheet.getIndexForFrame(curChar.toString());
				var r:Rectangle = spriteSheet.getDimensionForFrame(frame);
				
				if (fntSpriteSheet.kernings[curChar])
				{
					if (i+1 < text_length)
					{
						var next:int = text.charCodeAt(i+1);
						
						if (fntSpriteSheet.kernings[curChar][next])
						{
							lastX += fntSpriteSheet.kernings[curChar][next];
						}
					}
				}
				
				if (curChar == 32)
				{
					lastX = lastX + lastWidth * 0.5 + r.width * 0.5;
					lastWidth = r.width;
					continue;
				}
				
				s = Sprite2D(children[childIdx]);
				s.spriteSheet.frame = frame;
				
				s.x = lastX + lastWidth * 0.5 + r.width * 0.5 + _spacing - fntSpriteSheet.paddingLeft;
				
				lastX = s.x - fntSpriteSheet.paddingRight;
				lastWidth = r.width;
				
				childIdx++;
				
			}
			
			_width = lastX + lastWidth - fntSpriteSheet.paddingRight - fntSpriteSheet.paddingLeft;
			_height = spriteSheet.spriteHeight;
			
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		override protected function step(elapsed:Number):void 
		{
			super.step(elapsed);
			
			if (!_textChanged) return;
			
			_textChanged = false;
			
			var s:Sprite2D = getChildAt(numChildren - 1) as Sprite2D;
			
			_width = s ? s.x + spriteSheet.spriteWidth : 0;
			_height = spriteSheet.spriteHeight;
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}