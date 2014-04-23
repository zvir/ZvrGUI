package zvr.zvrND2D
{
	import com.tests.*;
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
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
		
		protected var _textChanged:Boolean = false;
		
		protected var _text:String;
		private var _spacing:Number = 0;
		private var _lineHeight:Number = 0;
		private var _align:int = 1;
		private var _maxWidth:Number = 1000;
		private var _maxWidthScale:Number = 1000;
		private var letters:int;
		public var lines:int;
		
		public const lettersX:Array = [];
		
		public var updateMouseRect:Boolean = true;
		
		private var _fontSize:Number;
		
		public function FNTSprite(textureObject:Texture2D) 
		{
			super(textureObject);
			mouseRect = new Rectangle();
		}
		
		public function get text():String
		{
			return _text;
		}

		public function set text(value:String):void
		{
			if (_text != value)
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
		
		public function get align():int 
		{
			return _align;
		}
		
		public function set align(value:int):void 
		{
			if (_align != value)
			{
				_align = value;
				_textChanged = true;
				textChanged();
			}
		}
		
		public function get maxWidth():Number 
		{
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void 
		{
			if (_maxWidth != value)
			{
				_maxWidth = value;
				_textChanged = true;
				textChanged();
			}
		}
		
		public function get lineHeight():Number 
		{
			return _lineHeight;
		}
		
		public function set lineHeight(value:Number):void 
		{
			if (_lineHeight != value)
			{
				_lineHeight = value;
				_textChanged = true;
				textChanged();
			}
		}
		
		public function textChanged():void
		{

			if (!_textChanged) return;
			
			lettersX.length = 0;
			lettersX.push(0);
			
			if (!_text || _text == "") 
			{
				removeAllChildren();
				
				_width = 0;
				_height = 0;
				if (updateMouseRect)
				{
					mouseRect.width = 0;
					mouseRect.height = 0;
					mouseRect.x = 0;
					mouseRect.y = 0;
				}
				dispatchEvent(new Event(Event.CHANGE));
				return;
			}
			
			const numSpaces:uint = _text.split(/\s/g).length - 1;
			const childsNeeded:uint = _text.length - numSpaces;
			
			while (numChildren < childsNeeded)
			{
				addChild(new Sprite2D());
			}
			
			while (numChildren > childsNeeded)
			{
				var s:Sprite2D = getChildAt(0) as Sprite2D;
				removeChild(s);
				s.dispose();
			}
			
			var curChar:int;
			var lastChar:int;
			
			var word:String = "";
			var words:Vector.<FNTSpriteWord> = new Vector.<FNTSpriteWord>();
			var fntSpriteSheet:FNTSpriteSheet = FNTSpriteSheet(spriteSheet);
			var ofset:int = 0 ;
			
			var maxLineWidth:Number;
			
			letters = 0;
			
			for (var i:int = 0; i < text.length; i++)
			{
				curChar = _text.charCodeAt(i);
				
				if (curChar == 10)
				{
					words.push(getSpriteWord(word));
					word = new String();
					word = "\n";
					continue;
				}
				
				word = word + _text.charAt(i);
				
				if (curChar == 32 && lastChar != 32)
				{
					words.push(getSpriteWord(word));
					word = new String();
					word = "";
				}
				
				lastChar = curChar;
			}
			
			words.push(getSpriteWord(word));
			
			var lines:Vector.<FNTSpriteLine> = new Vector.<FNTSpriteLine>();
			lines.push(new FNTSpriteLine());
			
			var lineWidth:Number = 0;
			
			for (var j:int = 0; j < words.length; j++) 
			{
				var w:FNTSpriteWord = words[j];
				if (lineWidth + w.width > maxWidth || w.newLine)
				{
					lines[lines.length - 1].width = lineWidth;
					lines.push(new FNTSpriteLine());
					lineWidth = 0;
				}
				lines[lines.length - 1].words.push(w);
				lineWidth += w.width;
				lines[lines.length - 1].width = lineWidth;
			}
			
			var lineH:Number = fntSpriteSheet.lineHeight + _lineHeight;
			
			var wi:int;
			
			for (i = 0; i < lines.length; i++)
			{
				var line:FNTSpriteLine = lines[i];
				
				var lastWordWidth:Number = 0;
				if (_align == 0) ofset = -(line.width - (fntSpriteSheet.xadvances[32] + _spacing)) * 0.5 ;
				if (_align == -1) ofset = -line.width - (fntSpriteSheet.xadvances[32] + _spacing);
				
				lettersX[0] = ofset;
				
				maxLineWidth = isNaN(maxLineWidth) ? line.width : Math.max(maxLineWidth, line.width);
				
				for (var l:int = 0; l < line.words.length; l++) 
				{
					w = line.words[l];
					
					for (var k:int = 0; k < w.sprites.length; k++) 
					{
						s = w.sprites[k];
						s.x += lastWordWidth;
						s.x += ofset;
						s.y += lineH * i;
						
						//trace(">", s.x);
						
						lettersX[wi] += lastWordWidth + ofset;
						wi++;
						w.sprites[k] = null;
					}
					
					lettersX[wi] += lastWordWidth + ofset;
					wi++;
					
					lastWordWidth += w.width;
					line.words[l] = null;
				}
				
			}
			
			lettersX[0] = ofset;
			
			this.lines = lines.length;
			
			_width = maxLineWidth;
			_height = lines.length * lineH;
			
			if (updateMouseRect)
			{
				if (_align == 0)
				{
					mouseRect.x = _width * 0.5;
				}
				
				if (_align == -1)
				{
					mouseRect.x = _width;
				}
				else
				{
					mouseRect.x = 0;
				}
				
				mouseRect.height = _height;
				mouseRect.width = _width;
			}
			
			dispatchEvent(new Event(Event.CHANGE));
			
			lines.length = 0;
			
			
		}
		
		private function getSpriteWord(s:String):FNTSpriteWord
		{
			var w:FNTSpriteWord = new FNTSpriteWord();
			
			const textLength:int = s.length;
			var curChar:int;
			var frame:int;
			var lastX:Number = 0;
			var lastWidth:Number = 0;
			var fntSpriteSheet:FNTSpriteSheet = FNTSpriteSheet(spriteSheet);
			var fs:Sprite2D;
			
			w.word = s;
			w.sprites = new Vector.<Sprite2D>();
			
			for (var i:int = 0; i < textLength; i++)
			{
				curChar = s.charCodeAt(i);
				frame = spriteSheet.getIndexForFrame(curChar.toString());
				var r:Rectangle = spriteSheet.getDimensionForFrame(frame);
				
				if (fntSpriteSheet.kernings[curChar])
				{
					if (i+1 < textLength)
					{
						var next:int = text.charCodeAt(i+1);
						
						if (fntSpriteSheet.kernings[curChar][next])
						{
							lastX += fntSpriteSheet.kernings[curChar][next];
						}
					}
				}
				
				if (curChar == 10)
				{
					w.newLine = true;
					continue;
				}
				
				if (curChar == 32 || !fntSpriteSheet.fontOffsets.hasOwnProperty(curChar))
				{
					lastX = lastX + (int(fntSpriteSheet.xadvances[32] ) / 2) + _spacing;
					//lastWidth = fntSpriteSheet.xadvances[32];
					lettersX.push(int(fntSpriteSheet.xadvances[32] ) / 2) + _spacing;
					//letters++;
					continue;
				}
				
				fs = Sprite2D(children[letters]);
				letters++;
				fs.spriteSheet.frame = frame;
				
				fs.x = lastX + r.width / 2 + fntSpriteSheet.fontOffsets[curChar].x;
				fs.y = /*fntSpriteSheet.lineHeight / 2;*/ r.height / 2 + fntSpriteSheet.fontOffsets[curChar].y/* + int(fntSpriteSheet.lineHeight / 2);*/
				
				//trace(s.charAt(i), fs.x, fs.y, r.width/2);
				
				w.sprites.push(fs);
				
				lastX = lastX + fntSpriteSheet.xadvances[curChar] + _spacing;
				//lastWidth = fntSpriteSheet.xadvances[curChar];
				
				lettersX.push(lastX/*+lastWidth*/);
				
			}
			
			w.width = int(lastX + fntSpriteSheet.xadvances[32] + _spacing);
			//trace(">>>>>>>>>>>>>", w.width, lastX, fntSpriteSheet.xadvances[32]);
			return w;
			
		}
		
		public function set fontSize(value:Number):void
		{
			var org:Number = FNTSpriteSheet(spriteSheet).fontSize;
			
			_fontSize = value;
			
			if (isNaN(org)) return;
			
			var s:Number = _fontSize / org;
			
			scaleX = scaleY = s;
			
		}
		
		/*
			
			getWords();
			
			
			_width = 100;
			_height = 100;
			
			return;
			
			var s:Sprite2D;
			var curChar:int;
			var frame:int;
			var childIdx:uint = 0;
			var startX:Number = spriteSheet.spriteWidth >> 1;
			var space:int = -1;
			
			var fntSpriteSheet:FNTSpriteSheet = FNTSpriteSheet(spriteSheet);
			
			var lastX:Number = 0;
			var lastWidth:Number = 0;
			var lastLine:int = 0;
			
			var lines:Array = [];
			var lastWord:Array = [];
			var lastChar:int;
			
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
					lastX = lastX + fntSpriteSheet.xadvances[32] + _spacing;
					lastWidth = fntSpriteSheet.xadvances[32];
					
					if (lastChar != 32)
					{
						
					}
					lastChar = curChar;
					continue;
				}
				
				lastChar = curChar;
				
				s = Sprite2D(children[childIdx]);
				s.spriteSheet.frame = frame;
				
				s.x = lastX + r.width / 2 + fntSpriteSheet.fontOffsets[curChar].x;
				s.y = spriteSheet.spriteHeight / 2 +  spriteSheet.spriteHeight*lastLine;
				
				lastX = lastX + fntSpriteSheet.xadvances[curChar] + _spacing;
				lastWidth = fntSpriteSheet.xadvances[curChar];
				
				if (lastX > maxWidth)
				{
					lastX = 0;
					lastLine++;
				}
				
				childIdx++;
				
			}
			
			_width = lastX + lastWidth/2;
			_height = spriteSheet.spriteHeight;
			
			mouseRect.height = _height;
			mouseRect.width = _width;
			var hw:int = 0;
			
			if (_align == 0)
			{
				hw = _width * 0.5;
				for each(var child:Sprite2D in children)
				{
					child.x -= hw;
				}
				
			}
			
			if (_align == -1)
			{
				hw = _width;
				for each(child in children)
				{
					child.x -= hw;
				}
			}
			
			mouseRect.x = -hw;
			
			dispatchEvent(new Event(Event.CHANGE));
			
			getWords();
			
			
		}*/
		
		override protected function step(elapsed:Number):void 
		{
			super.step(elapsed);
			
			if (!_textChanged) return;
			
			_textChanged = false;
			
			var s:Sprite2D = getChildAt(numChildren - 1) as Sprite2D;
			
			/*_width = s ? s.x + spriteSheet.spriteWidth : 0;
			_height = spriteSheet.spriteHeight;*/
			
			dispatchEvent(new Event(Event.CHANGE));
		}
		
	}

}