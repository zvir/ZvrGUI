package zvr.zvrG2D.text 
{
	import com.genome2d.components.GComponent;
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.context.GContextCamera;
	import com.genome2d.context.IContext;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import org.osflash.signals.Signal;
	import zvr.zvrG2D.FNTCaret;
	import zvr.zvrG2D.G2DFont;
	import zvr.zvrG2D.G2DFontChar;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class GTextComponent extends GComponent implements IRenderable
	{
		public var blendMode:int = GBlendMode.NORMAL;
		
		public var processText:Function;
		
		private static var _lettersTrash:Vector.<GTextLetter> = new Vector.<GTextLetter>();
		
		private var  _letters:Vector.<GTextLetter> = new Vector.<GTextLetter>();
		
		private var _onTextChanged:Signal = new Signal(String);
		
		private var _maxChars:int = int.MAX_VALUE;
		
		private var _maxWidth:Number = Number.MAX_VALUE;
		
		private var _align:int = 1;
		private var _letterSpacing:Number = 0;
		private var _lineSpacing:Number = 0;
		private var _size:Number;
		private var _sizeDirty:Boolean;
		private var _sizeScale:Number = 1;
		
		private var _font:G2DFont;
		
		private var _width:Number = 0;
		private var _height:Number = 0;
		
		private var _caretChar:int = 124;
		private var _caretIndex:int = 1;
		private var _caretBlinkItv:int = 250;
		
		private var _caretX:int = 5;
		private var _caretY:int = 5;
		
		private var _caretUV:Array;
		private var _caretVR:Array;
		
		private var _caretPositions:Array = [];
		private var _carretPositionDirty:Boolean = true;
		
		private var _caret:G2DFontChar;
		private var _showCaret:Boolean;
		
		private var _text:String;
		
		private var va:Array = [];
		
		private var _textDirty:Boolean;
		
		private var _carretDirty:Boolean;
		
		private var _alginOffset:Number;
		
		
		public function GTextComponent(p_node:GNode) 
		{
			super(p_node);
		}
		
		private function renderText():void
		{
			
			_lettersTrash = _lettersTrash.concat(_letters);
			_letters.length = 0;
			
			
			if (!_text || _text.length == 0)
			{
				abortRender();
				return;
			}
			
			if (processText != null) _text = processText(_text);
			
			_width = 0;
			_height = 0;
			
			var c:int;
			var lineBreak:Boolean;
			var space:Boolean;
			var lastSpace:Boolean;
			
			var l:GTextLetter;
			var lastLetter:GTextLetter;
			
			var lines:int = 0;
			var lineY:Number = 0;
			
			var spaceWord:Vector.<GTextLetter> = new Vector.<GTextLetter>();
			var word:Vector.<GTextLetter> = new Vector.<GTextLetter>();
			var line:Vector.<GTextLetter> = new Vector.<GTextLetter>();
			var skipLine:Vector.<GTextLetter>;
			
			var lineWidth:Number = 0;
			
			var scaledMaxWidth:Number = _maxWidth / _sizeScale;
			
			for (var i:int = 0; i < _text.length && i < _maxChars; i++) 
			{
				c = _text.charCodeAt(i);
				
				lastSpace = space;
				
				lineBreak = c == 10 || c == 13;
				space = c == 32 || lineBreak || c == 11 || c == 9 || c == 12;
				
				if (lineBreak)
				{
					lines++;
					lineY = lines * _font.lineHeight + _lineSpacing;
					lastLetter = null;
					
					lineWidth = addWordToLine(line, spaceWord, lineWidth);
					
					alignLine(line, lineWidth);
					
					lineWidth = 0;
					line.length = 0;
					
					spaceWord.length = 0;
					
					continue;
				}
				
				l = _lettersTrash.pop();
				
				if (!l)
				{
					l = new GTextLetter();
				}
				
				//l = new GTextLetter();
				_letters.push(l);
				
				if ((space && !lastSpace))
				{
					word.length = 0;
				}
				
				if (!space)
				{
					word.push(l);
				}
				

				l.char = _font.getChar(c) as G2DFontChar;
				
				if (lastLetter)
				{
					l.x = lastLetter.x + lastLetter.char.xadvance + _font.getKerning(lastLetter.char.char, l.char.char) + _letterSpacing;	
					l.y = lineY;
					
					if (!space && l.x + l.char.xadvance > scaledMaxWidth)
					{
						
						lines++;
						lineY = lines * _font.lineHeight + _lineSpacing;
						
						alignLine(line, lineWidth);
						
						lineWidth = 0;
						line.length = 0;
						
						
						var wl:GTextLetter = word[0];
						
						wl.x = 0;
						wl.y = lineY;
						lastLetter = wl;
						
						
						for (var j:int = 1; j < word.length; j++) 
						{
							wl = word[j];
							
							wl.x = lastLetter.x + lastLetter.char.xadvance + _font.getKerning(lastLetter.char.char, wl.char.char) + _letterSpacing;	
							wl.y = lineY;
							lastLetter = wl;
						}
						
					}
				}
				else
				{
					l.x = 0;
					l.y = lineY;
				}
				
				if (!lastSpace && space)
				{
					lineWidth = addWordToLine(line, spaceWord, lineWidth);
					
					spaceWord.length = 0;
					spaceWord.push(l);
				}
				else
				{
					spaceWord.push(l);
				}
				
				l.y = lineY;
				lastLetter = l;
			}
			
			lineWidth = addWordToLine(line, spaceWord, lineWidth);
			alignLine(line, lineWidth);
			
			_height = lineY + _font.lineHeight;
			
			_height *= _sizeScale;
			_width *= _sizeScale;
			
			if (_maxWidth != Number.MAX_VALUE) 
			{
				_alginOffset = _align == 1 ? 0 : _align == 0 ? _maxWidth / 2 : _maxWidth;
			}
			else
			{
				_alginOffset = 0;
			}
			
			var v:Array = [];
			var a:Array = [];
			
			va.length = 0;
			va.push([v, a]);
		
			_caretPositions.length = 0;
			
			_caretPositions.push([_letters[0].x + _alginOffset, _letters[0].y]);
			
			var lpx2:Number = _letters[0].x - _letters[0].char.texture.pivotX - int(_letters[0].char.texture.width * 0.5) + _alginOffset;
			
			for (var k:int = 0; k < _letters.length; k++) 
			{
				
				if (v.length > 12 * 599) 
				{
					v = [];
					a = [];
					va.push([v, a]);
				}
				
				l = _letters[k];
				
				var texture:GTexture = l.char.texture;

				var uv1x:Number = texture.g2d_region.x / texture.g2d_gpuWidth;
				var uv1y:Number = texture.g2d_region.y / texture.g2d_gpuHeight;
				var uv2x:Number = (texture.g2d_region.x + texture.g2d_region.width) / texture.g2d_gpuWidth;
				var uv2y:Number = (texture.g2d_region.y + texture.g2d_region.height) / texture.g2d_gpuHeight;
				
				var p1x:Number = l.x - texture.pivotX - texture.width * 0.5 + _alginOffset;
				var p1y:Number = l.y - texture.pivotY - texture.height * 0.5;
				var p2x:Number = p1x + texture.width;
				var p2y:Number = p1y + texture.height;
				
				_caretPositions.push([l.x + l.char.xadvance + _alginOffset, l.y]);
				
				/*if (k  < _letters.length - 1)
				{
					var l2:GTextLetter = _letters[k+1];
					var pn1x:Number = l2.x - l2.char.texture.pivotX - l2.char.texture.width * 0.5 + _alginOffset;
					
					var sx:Number = p2x + (pn1x - p2x) / 2;
					var px:Number = pn1x;
					
					
					
				}
				else
				{
					_caretPositions.push([p2x, l.y]);
				}*/
				
				v.push
				(
					p1x, p1y, 
					p2x, p1y, 
					p1x, p2y, 
					
					p2x, p1y,
					p2x, p2y,
					p1x, p2y
				);
				
				a.push
				(
					uv1x, uv1y,
					uv2x, uv1y,
					uv1x, uv2y,
					
					uv2x, uv1y,
					uv2x, uv2y,
					uv1x, uv2y
				);
				
			}
			
			_onTextChanged.dispatch(_text);
		}
		
		private function abortRender():void 
		{
			_width = 0;
			_height = 0;
			va.length = 0;
			_onTextChanged.dispatch(_text);
		}
		
		private function addWordToLine(line:Vector.<GTextLetter>, word:Vector.<GTextLetter>, lineWidth:Number):Number
		{
			var l:GTextLetter
			
			for (var k:int = 0; k < word.length; k++) 
			{
				l = word[k];
				
				var c:int = l.char.char;
				
				if (!(c == 32 || c == 10 || c == 13 || c == 11 || c == 9 || c == 12))
				{
					lineWidth = l.x + l.char.xadvance;
				}
				
				line.push(l);
			}
			
			return lineWidth;
		}
		
		private function alignLine(line:Vector.<GTextLetter>, lineWidth:Number):void 
		{
			if (_width < lineWidth) _width = lineWidth;
			
			if (_align == 1) return;
			
			var l:GTextLetter

			if (_align == 0)
			{
				lineWidth /= 2;
			}
						
			for (var i:int = 0; i < line.length; i++) 
			{
				l = line[i];
				l.x -= lineWidth;
			}
			
		}
		
		/*private function print(word:Vector.<GTextLetter>):void
		{
			var s:String = "";
			
			for (var i:int = 0; i < word.length; i++) 
			{
				s += String.fromCharCode(word[i].char.char);
			}
			
		}*/
		
		public function update():void
		{
			if (_textDirty || _sizeDirty)
			{
				updateSize();
				renderText();
				_sizeDirty = false;
				_textDirty = false;
			}
		}
		
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void 
		{
			update();
			
			var transform:GTransform = node.transform;
			
			var cos:Number = Math.cos(transform.g2d_worldRotation);
			var sin:Number = Math.sin(transform.g2d_worldRotation);
			
			var sx:Number = node.transform.g2d_worldScaleX * _sizeScale;
			var sy:Number = node.transform.g2d_worldScaleY * _sizeScale;
			
			var c:IContext = node.core.g2d_context;
			
			for (var i:int = 0; i < _letters.length; i++) 
			{
				var item:GTextLetter = _letters[i];
				
				if (!item.char.texture) continue;
				
				var tx:Number = ((item.x + _alginOffset/_sizeScale) * cos - item.y * sin) * node.transform.g2d_worldScaleX * _sizeScale + node.transform.g2d_worldX;
				var ty:Number = (item.y * cos + (item.x + _alginOffset/_sizeScale) * sin) * node.transform.g2d_worldScaleY * _sizeScale + node.transform.g2d_worldY;
			
				
				c.draw(
					item.texture,
					tx,
					ty, 
					sx,
					sy,
					node.transform.g2d_worldRotation, 
					node.transform.g2d_worldRed, 
					node.transform.g2d_worldGreen, 
					node.transform.g2d_worldBlue, 
					node.transform.g2d_worldAlpha, 
					blendMode
				);

			}
			
			/*for (var j:int = 0; j < _caretPositions.length; j++) 
			{
				cx = _caretPositions[j][0];
				cy = _caretPositions[j][1];
				
				tx = (cx * cos - cy * sin) * node.transform.g2d_worldScaleX * _sizeScale + node.transform.g2d_worldX;
				ty = (cy * cos + cx * sin) * node.transform.g2d_worldScaleY * _sizeScale + node.transform.g2d_worldY + _font.lineHeight / 2 * _sizeScale;;
				
				c.draw(
					DotG2DTex.dotTex,
					tx,
					ty, 
					sx/16,
					sy/2,
					node.transform.g2d_worldRotation, 
					node.transform.g2d_worldRed, 
					node.transform.g2d_worldGreen, 
					node.transform.g2d_worldBlue, 
					node.transform.g2d_worldAlpha*0.5, 
					blendMode
				);
			}*/
			
			
			
			if (_showCaret)
			{
				
				if (int(getTimer() / _caretBlinkItv) % 2 == 0) return
				
				if (_carretDirty)
				{
					updateCarret();
					_carretDirty = false;
				}
				
				if (_carretPositionDirty)
				{
					//updateCarretPosition();
					_carretPositionDirty = false;
				}
				
				var cx:Number = _caretPositions[_caretIndex][0];
				var cy:Number = _caretPositions[_caretIndex][1];
				
				tx = (cx * cos - cy * sin) * node.transform.g2d_worldScaleX * _sizeScale + node.transform.g2d_worldX - _caret.texture.width/2 * _sizeScale + _caret.texture.pivotX * _sizeScale;
				ty = (cy * cos + cx * sin) * node.transform.g2d_worldScaleY * _sizeScale + node.transform.g2d_worldY;
			
			//	c.draw(, transform.g2d_worldX, transform.g2d_worldY, sx, sy, transform.g2d_worldRotation, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
				c.draw(
					_caret.texture,
					tx,
					ty, 
					sx,
					sy,
					node.transform.g2d_worldRotation, 
					node.transform.g2d_worldRed, 
					node.transform.g2d_worldGreen, 
					node.transform.g2d_worldBlue, 
					node.transform.g2d_worldAlpha, 
					blendMode
				);
				
				
			}
			
			
			
		}
		/*
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void 
		{
			update();
			
			var c:IContext = node.core.g2d_context;
			var transform:GTransform = node.transform;
			
			var sx:Number = _sizeScale * transform.g2d_worldScaleX;
			var sy:Number = _sizeScale * transform.g2d_worldScaleY;
			
			for (var j:int = 0; j < va.length; j++) 
			{
				c.drawPoly(_font.atlas, va[j][0], va[j][1], transform.g2d_worldX, transform.g2d_worldY, sx, sy, transform.g2d_worldRotation, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
			}
			
			if (_showCaret)
			{
				if (_carretDirty)
				{
					updateCarret();
					_carretDirty = false;
				}
				
				if (_carretPositionDirty)
				{
					updateCarretPosition();
					_carretPositionDirty = false;
				}
				
				c.drawPoly(_font.atlas, _caretVR, _caretUV, transform.g2d_worldX, transform.g2d_worldY, sx, sy, transform.g2d_worldRotation, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
			}
			
		}
		*/
		private function updateCarretPosition():void 
		{
			var texture:GTexture = _caret.texture;
				
			var cx:Number = _caretPositions[_caretIndex][0];
			var cy:Number = _caretPositions[_caretIndex][1];

			
			var p1x:Number = cx - texture.width * 0.5;
			var p1y:Number = cy - texture.pivotY - texture.height * 0.5;
			var p2x:Number = p1x + texture.width;
			var p2y:Number = p1y + texture.height;
			
			_caretVR = [
				p1x, p1y, 
				p2x, p1y, 
				p1x, p2y, 
				 
				p2x, p1y,
				p2x, p2y,
				p1x, p2y
			];
		}
		
		private function updateCarret():void
		{
			_caret = _font.getChar(_caretChar) as G2DFontChar;
			
			var texture:GTexture = _caret.texture;
			
			
			return;
			
			/*var p1x:Number =  - texture.pivotX - int(texture.width * 0.5);
			var p1y:Number =  - texture.pivotY - int(texture.height * 0.5);
			var p2x:Number = p1x + texture.width;
			var p2y:Number = p1y + texture.height;*/
			
			var uv1x:Number = texture.g2d_region.x / texture.g2d_gpuWidth;
			var uv1y:Number = texture.g2d_region.y / texture.g2d_gpuHeight;
			var uv2x:Number = (texture.g2d_region.x + texture.g2d_region.width) / texture.g2d_gpuWidth;
			var uv2y:Number = (texture.g2d_region.y + texture.g2d_region.height) / texture.g2d_gpuHeight;
			
			/*_caretVR = [
				p1x, p1y, 
			    p2x, p1y, 
			    p1x, p2y, 
			     
			    p2x, p1y,
			    p2x, p2y,
			    p1x, p2y
			]*/
			
			_caretUV = 
			[
				uv1x, uv1y,
				uv2x, uv1y,
				uv1x, uv2y,
				
				uv2x, uv1y,
				uv2x, uv2y,
				uv1x, uv2y
			]
		}
		
		private function updateSize():void 
		{
			_sizeScale = _size / _font.size;
		}
		
		public function getBounds(p_target:Rectangle = null):Rectangle 
		{
			return null;
		}
		
		public function get onTextChanged():Signal 
		{
			return _onTextChanged;
		}
		
		public function get maxChars():int 
		{
			return _maxChars;
		}
		
		public function set maxChars(value:int):void 
		{
			if (_maxChars == value) return;
			_maxChars = value;
			_textDirty = true;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function get font():G2DFont 
		{
			return _font;
		}
		
		public function set font(value:G2DFont):void 
		{
			if (_font == value) return;
			_font = value;
			_textDirty = true;
			_carretDirty = true;
			
			if (isNaN(_size))
			{
				_size = _font.size;
			}
			
			_sizeDirty = true;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			if (_size == value) return;
			_size = value;
			_sizeDirty = true;
		}
		
		public function get lineSpacing():Number 
		{
			return _lineSpacing;
		}
		
		public function set lineSpacing(value:Number):void 
		{
			if (_lineSpacing == value) return;
			_lineSpacing = value;
			_textDirty = true;
		}
		
		public function get letterSpacing():Number 
		{
			return _letterSpacing;
		}
		
		public function set letterSpacing(value:Number):void 
		{
			if (_letterSpacing == value) return;
			_letterSpacing = value;
			_textDirty = true;
		}
		
		public function get align():int 
		{
			return _align;
		}
		
		public function set align(value:int):void 
		{
			if (_align == value) return;
			_align = value;
			_textDirty = true;
		}
		
		public function get maxWidth():Number 
		{
			return _maxWidth;
		}
		
		public function set maxWidth(value:Number):void 
		{
			if (_maxWidth == value) return;
			_maxWidth = value;
			_textDirty = true;
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			if (_text == value) return;
			
			_text = value;
			
			_textDirty = true;
		}
		
		public function get caretIndex():int 
		{
			return _caretIndex;
		}
		
		public function set caretIndex(value:int):void 
		{
			if (_caretIndex == value) return;
			
			_caretIndex = value;
			
			if (_caretIndex > _text.length)
			{
				_caretIndex = _text.length;
			}
			if (_caretIndex < 0)
			{
				_caretIndex = 0;
			}
			
			_carretPositionDirty = true;
			
		}
		
		public function get showCaret():Boolean 
		{
			return _showCaret;
		}
		
		public function set showCaret(value:Boolean):void 
		{
			_showCaret = value;
		}
		
		public function get caretBlinkItv():int 
		{
			return _caretBlinkItv;
		}
		
		public function set caretBlinkItv(value:int):void 
		{
			_caretBlinkItv = value;
		}
		
		public function getCharIndexAt(x:Number, y:Number):int
		{
			x /= _sizeScale;
			y /= _sizeScale;
			
			for (var i:int = 0; i < _letters.length; i++) 
			{
				
				var c:GTextLetter = _letters[i];
				
				if (c.rect.contains(x, y))
				{
					
					if (x > c.rect.x + c.rect.width * 0.5)
					{
						return i + 1;
					}
					
					return i;
				}
			}
			
			return _letters.length;
			
		}
	}

}