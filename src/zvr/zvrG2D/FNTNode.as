package zvr.zvrG2D 
{
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.node.GNodePool;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GMouseSignal;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class FNTNode extends GNode 
	{
		public static var _cNodePool:GNodePool;
		
		private var _letters:Vector.<GNode> = new Vector.<GNode>();
		private var _chars:Vector.<FNTLetter> = new Vector.<FNTLetter>();
		
		//private var _trash:Vector.<FNTLetter> = new Vector.<FNTLetter>();
		
		private var _text:String = "";
		
		private var _maxWidth:Number;
		
		private var _align:int = 1;
		
		private var _spacing:Number = 0;
		private var _lineSpacing:Number = 0;
		
		private var _font:G2DFont;
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		private var _onTextChanged:Signal = new Signal(String);
		
		private var _fontSize:Number;
		
		private var _caretChar:int = 124;
		private var _caretIndex:int;
		private var _caret:FNTCaret;
		private var _inputing:Boolean;
		
		private var _mouseRectComponent:ZvrG2DMouseRectComponent;
		private var _mouseRect:Rectangle;
		
		private var _onMouseOutside:Signal = new Signal(GMouseSignal);

		public var maxChars:int = int.MAX_VALUE;
		
		public var processText:Function;
		
		
		
		public function FNTNode(font:G2DFont = null, p_name:String="") 
		{
			super(p_name);
			_font = font;
			
			if (!_cNodePool)
			{
				var c:FNTLetter = GNodeFactory.createNodeWithComponent(FNTLetter) as FNTLetter;	
				_cNodePool = new GNodePool(c.node.getPrototype());
			}
			
			mouseChildren = false;
			_mouseRectComponent = addComponent(ZvrG2DMouseRectComponent) as ZvrG2DMouseRectComponent;
			_mouseRectComponent.reportOuside = true;
		}
		
		public function textChanged():void 
		{
			if (!_font) return;
			
			while (_letters.length > 0)
			{
				var letterNode:GNode = _letters.pop()
				//letterNode.active = false;
				//_cNodePool.(letterNode);
				removeChild(letterNode);
			}
			
			_chars.length = 0;
			
			if (!_text || _text == "") 
			{
				if (!_mouseRect)
				{
					_mouseRectComponent.rect.width = _height = 0;
					_mouseRectComponent.rect.height = _width = _font.lineHeight + _lineSpacing;
				}
				
				
				_height *= transform.scaleY; 
				_width *= transform.scaleX; 
				
				_onTextChanged.dispatch(_text);
				
				return;
			}
			
			_text = text.substr(0, maxChars);
			
			if (processText != null) _text = processText(_text);
			
			var i:int;
			var c:int;
			var s:String;
			var lastLetter:FNTLetter;
			var l:FNTLetter;
			var lines:Vector.<FNTLine> = new Vector.<FNTLine>();	
			var lineNum:int;
			var lastIsSpace:Boolean;
			var line:FNTLine = new FNTLine();
			var word:FNTWord = new FNTWord();
			var space:Boolean;
			var lineBreak:Boolean;
			var lineWidth:Number;
			
			var lineLeft:Number = 0;
			var lineRight:Number = 0;
			
			var lineSpace:Number = _font.lineHeight + _lineSpacing;
			
			var ci:int;
			
			var maxWidth:Number = _maxWidth / transform.scaleX;
			
			for (i = 0; i < _text.length; i++)
			{
				l = addLetter();
				_chars.push(l);
				
				c = _text.charCodeAt(i);
				s = _text.charAt(i);
				
				lineBreak = c == 10 || c == 13;
				space = c == 32 || lineBreak || c == 11 || c == 9 || c == 12;/*Boolean(s.match(/\s/));*/
				
				if ((space && !lastIsSpace) || (!space && lastIsSpace))
				{
					line.words.push(word);
					
					word = new FNTWord();
					
					if (!lastIsSpace)
					{
						word.isWhite = true;
					}
					
				}
				
				lastIsSpace = space;
				
				if (lineBreak)
				{
					
					line.words.push(word);
					lines.push(line);
					line = new FNTLine();
					word = new FNTWord();
					l.char = FNTLetter.EMPTY_CHAR;
					l.node.transform.x = 0;
					l.node.transform.y = (lines.length) * (lineSpace);
					word.letters.push(l);
					word.isWhite = true;
					lastLetter = null;
					continue;
				}
				
				word.letters.push(l);
				
				l.char = _font.getG2DChar(c);
				
				
				if (lastLetter)
				{
					l.node.transform.x = lastLetter.node.transform.x + lastLetter.char.xadvance + _font.getKerning(lastLetter.char.char, l.char.char) + _spacing;
				}
				else
				{
					l.node.transform.x = 0;
				}
				
				l.node.transform.y = (lines.length) * (lineSpace);
				
				word.width += l.char.xadvance;
				
				lastLetter = l;
				
				if (!isNaN(maxWidth) && l.node.transform.x + l.char.xadvance > maxWidth)
				{
					lines.push(line);
					line = new FNTLine();
					lastLetter =  word.letters[0];
					
					lastLetter.node.transform.y = (lines.length) * (lineSpace);
					lastLetter.node.transform.x = 0;
					
					for (var j:int = 1; j < word.letters.length; j++) 
					{
						word.letters[j].node.transform.y = (lines.length) * (lineSpace);
						word.letters[j].node.transform.x = lastLetter.node.transform.x + lastLetter.char.xadvance + _font.getKerning(lastLetter.char.char, l.char.char) + _spacing;
						lastLetter = word.letters[j];
					}
					
				}
				
			}
			
			line.words.push(word);
			lines.push(line);
			
			_width = 0;
			
			var a:Number = _align == 0 ? 0.5 : 1;
			
			for (var k:int = 0; k < lines.length; k++) 
			{
				lineRight = 0;
				lineLeft = Number.MAX_VALUE;
				
				line = lines[k];
				
				for (var m:int = 0; m < line.words.length; m++) 
				{
					word = line.words[m];
					
					if (!word.isWhite && word.letters[0].node.transform.x <= lineLeft) lineLeft = word.letters[0].node.transform.x;
					if (!word.isWhite) lineRight = word.letters[word.letters.length - 1].node.transform.x + word.letters[word.letters.length - 1].char.xadvance;
					
					for (var n:int = 0; n < word.letters.length; n++) 
					{
						l = word.letters[n];
					}
				}
				
				lineWidth = lineRight - lineLeft;
				
				if (lineWidth > _width) _width = lineWidth;
				
				if (_align == 1) continue;
				
				for (m = 0; m < line.words.length; m++) 
				{
					word = line.words[m];
					
					for (n = 0; n < word.letters.length; n++) 
					{
						l = word.letters[n];
						l.node.transform.x -= int(lineWidth * a) + lineLeft;
					}
				}
				
			}
			
			_height = lines.length * (lineSpace);
			
			if (!_mouseRect)
			{
				_mouseRectComponent.rect.width = _width;
				_mouseRectComponent.rect.height = _height;
			}
			
			_height *= transform.scaleY; 
			_width *= transform.scaleX; 
			
			_onTextChanged.dispatch(_text);
			
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
			textChanged();
		}
		
		public function get font():G2DFont 
		{
			return _font;
		}
		
		public function set font(value:G2DFont):void 
		{
			_font = value;
			textChanged();
			
			if (_caret) 
			{
				_caret.char = _font.getG2DChar(caretChar);
				updateCaret();
			}
			
		}
		
		public function get maxWidth():Number 
		{
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void 
		{
			_maxWidth = value;
			textChanged();
		}
		
		public function get align():int 
		{
			return _align;
		}
		
		public function set align(value:int):void 
		{
			_align = value;
			textChanged();
		}
		
		public function get spacing():Number 
		{
			return _spacing;
		}
		
		public function set spacing(value:Number):void 
		{
			_spacing = value;
			textChanged();
		}
		
		public function get lineSpacing():Number 
		{
			return _lineSpacing;
		}
		
		public function set lineSpacing(value:Number):void 
		{
			_lineSpacing = value;
			textChanged();
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get onTextChanged():Signal 
		{
			return _onTextChanged;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		private function addLetter():FNTLetter
		{
			var l:FNTLetter = _cNodePool.getNext().getComponent(FNTLetter) as FNTLetter;
			_letters.push(l.node);
			addChild(l.node);
			return l;
		}
		
		public function set fontSize(value:Number):void
		{			
			_fontSize = value;
			
			
			if (!_font || isNaN(_font.size)) return;
			
			var s:Number = _fontSize / _font.size;
			
			transform.scaleX = transform.scaleY = s;
			
			textChanged();
		}
		
		public function inputBegin():void
		{
			if (!_caret)
			{
				_caret = GNodeFactory.createNodeWithComponent(FNTCaret) as FNTCaret;
			}
			
			_caret.char = _font.getG2DChar(caretChar);
			_inputing = true;
			addChild(_caret.node);
			
		}
		
		public function inputEnd():void
		{
			removeChild(_caret.node);
			_inputing = false;
		}
		
		public function get caretIndex():int 
		{
			return _caretIndex;
		}
		
		public function set caretIndex(value:int):void 
		{
			_caretIndex = value;
			
			updateCaret();
		}
		
		public function get caretChar():int 
		{
			return _caretChar;
		}
		
		public function set caretChar(value:int):void 
		{
			_caretChar = value;
			
			if (_caret) _caret.char = _font.getG2DChar(caretChar);
		}
		
		public function get mouseRect():Rectangle 
		{
			return _mouseRect;
		}
		
		public function set mouseRect(value:Rectangle):void 
		{
			value.width = value.width / transform.scaleX;
			value.height = value.height / transform.scaleY;
			
			_mouseRect = value;
			
			
			
			if (_mouseRect) _mouseRectComponent.rect = _mouseRect
		}
		
		public function get onMouseOutside():Signal 
		{
			return _onMouseOutside;
		}
		
		private function updateCaret():void 
		{
			if (!_caret) return;
			
			var l:FNTLetter
			
			if (_caretIndex == -1)
			{
				l = _chars[_chars.length - 1];
				_caret.node.transform.x = l.node.transform.x + l.char.xadvance - _caret.texture.width;
				_caret.node.transform.y = 0;
				return;
			}
			
			if (_caretIndex == 0 && _chars.length == 0)
			{
				_caret.node.transform.x = - _caret.texture.width;
				_caret.node.transform.y = 0;
				return;
			}
			
			if (_caretIndex == 0 && _chars.length != 0)
			{
				l = _chars[0];
				_caret.node.transform.x = l.node.transform.x - _caret.texture.width;
				_caret.node.transform.y = l.node.transform.y;
				return;
			}
			
			var charIndex:int = _caretIndex -1;
			
			if (charIndex < _chars.length)
			{
				l = _chars[charIndex];
				
				_caret.node.transform.x = l.node.transform.x + l.char.xadvance - _caret.texture.width;
				_caret.node.transform.y = l.node.transform.y;
			}
			else if (_caretIndex >= _chars.length && _chars.length > 0)
			{
				l = _chars[_chars.length - 1];
				
				_caret.node.transform.x = l.node.transform.x + l.char.xadvance - _caret.texture.width;
				_caret.node.transform.y = l.node.transform.y;
				
			}
			else
			{
				_caret.node.transform.x = - _caret.texture.width;
				_caret.node.transform.y = 0;
			}
		}
		
		public function getCharIndexAt(x:Number, y:Number):int
		{
			for (var i:int = 0; i < _chars.length; i++) 
			{
				
				var c:FNTLetter = _chars[i]
				
				if (c.rect.contains(x, y))
				{
					
					if (x > c.rect.x + c.rect.width * 0.5)
					{
						return i + 1;
					}
					
					return i;
				}
			}
			
			return _chars.length;
			
		}
		
		/*override public function dispatcMouseSignal(p_type:String, p_object:GNode, p_localX:Number, p_localY:Number, p_contextSignal:GMouseSignal):void
		{
			super.dispatchMouseSignal(p_type, p_object, p_localX, p_localY, p_contextSignal);
			
			if (mouseEnabled)
			{ 
				if (p_type.split("_")[0] == "OUTSIDE")
				{
					//var mouseSignal:GMouseSignal = new GMouseSignal(p_type, p_x, p_y);
					
					_onMouseOutside.dispatch(p_contextSignal);
				}
				
			}
			
			
		}*/
		
	}

}