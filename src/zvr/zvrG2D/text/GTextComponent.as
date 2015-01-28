package zvr.zvrG2D.text 
{
	import com.genome2d.components.GComponent;
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.error.GError;
	import com.genome2d.textures.GCharTexture;
	import com.genome2d.signals.GMouseSignalType;
	import com.genome2d.node.GNode;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.signals.GMouseSignal;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import com.genome2d.context.GContextCamera;
	import com.genome2d.utils.GHAlignType;
	import com.genome2d.utils.GVAlignType;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	import org.osflash.signals.Signal;
	import zvr.zvrG2D.G2DFont;
	import zvr.zvrG2D.G2DFontChar;
	
	/*
	 * 	Genome2D - 2D GPU Framework
	 * 	http://www.genome2d.com
	 *
	 *	Copyright 2011-2014 Peter Stefcek. All rights reserved.
	 *  Modifided to use G2DFont
	 *	License:: ./doc/LICENSE.md (https://github.com/pshtif/Genome2D/blob/master/LICENSE.md)
	 */
	
	/**
		Component used for rendering texture based text
	**/
	public class GTextComponent extends GComponent implements IRenderable
	{
		public var blendMode:int = 1;
		
		public var onTextChanged:Signal = new Signal(String);
		
		private var _size:Number;
		
		private var _scale:Number = 1;
		
		private var g2d_invalidate:Boolean = false;
		private var g2d_tracking:Number = 0;
		private var g2d_lineSpace:Number = 0;
		private var g2d_vAlign:int = 0;
		private var g2d_hAlign:int = 0;
		private var g2d_font:G2DFont;
		private var g2d_text:String = "";
		private var g2d_autoSize:Boolean = false;
		private var g2d_width:Number = 100;
		private var g2d_height:Number = 100;
		private var g2d_chars:Vector.<GTextChar>;
		private var invalidateTextT:int;
		
		private var va:Array = [];
		
		private var _invalidateSize:Boolean;
		
		public function GTextComponent() 
		{
			
		}
		
		public function update():void
		{
			if (_invalidateSize) invalidateSize();
			if (g2d_invalidate) invalidateText();
		}
		
		private function invalidateSize():void 
		{
			_invalidateSize = false;
			_scale = isNaN(_size) ? 1 : _size / g2d_font.size;
		}
		
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void
		{
			if (g2d_invalidate) invalidateText();
			
			if (g2d_font == null) return;
			if (g2d_text == null) return;
			
			var transform:GTransform = node.transform;
			
			for (var j:int = 0; j < va.length; j++) 
			{
				node.core.getContext().drawPoly(g2d_font.atlas, va[j][0], va[j][1], transform.g2d_worldX, transform.g2d_worldY, transform.g2d_worldScaleX * _scale, transform.g2d_worldScaleY * _scale, transform.g2d_worldRotation, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
			}
			
			
			return;
			
			trace("invalidateTextTime", getTimer() - invalidateTextT);
			
			var t:int = getTimer();
			
			var charCount:int = g2d_chars.length;
			var cos:Number = 1;
			var sin:Number = 0;
			
			if (g2d_node.transform.g2d_worldRotation != 0)
			{
				cos = Math.cos(node.transform.g2d_worldRotation);
				sin = Math.sin(node.transform.g2d_worldRotation);
			}
			
			for (var i:int = 0; i <  charCount; i++)
			{
				var char:GTextChar = g2d_chars[i];
				if (!char.g2d_visible) break;

				var tx:Number = char.g2d_x * node.transform.g2d_worldScaleX + g2d_node.transform.g2d_worldX;
				var ty:Number = char.g2d_y * node.transform.g2d_worldScaleY + g2d_node.transform.g2d_worldY;
				
				if (g2d_node.transform.g2d_worldRotation != 0)
				{
					tx = (char.g2d_x * cos - char.g2d_y * sin) * node.transform.g2d_worldScaleX + g2d_node.transform.g2d_worldX;
					ty = (char.g2d_y * cos + char.g2d_x * sin) * node.transform.g2d_worldScaleY + g2d_node.transform.g2d_worldY;
				}

				node.core.getContext().draw(char.g2d_texture.texture, tx, ty, node.transform.g2d_worldScaleX, node.transform.g2d_worldScaleY, node.transform.g2d_worldRotation, node.transform.g2d_worldRed, node.transform.g2d_worldGreen, node.transform.g2d_worldBlue, node.transform.g2d_worldAlpha, 1, null);
			}
			
			//trace("renderTime", getTimer() - t);
			
		}
		
		private function invalidateText():void
		{
			
			invalidateTextT = getTimer();
			
			if (g2d_font == null) return;
			if (g2d_text == null) return;
			if (g2d_chars == null) g2d_chars = new Vector.<GTextChar>();

			if (g2d_autoSize)
			{
				g2d_width = 0;
			}
			
			var scale:Number = isNaN(_size) ? 1 : _size / g2d_font.size;
			
			var offsetX:Number = 0;
			var offsetY:Number =  0;
			var char:GTextChar;
			var texture:G2DFontChar = null;
			var currentCharCode:int = -1;
			var previousCharCode:int = -1;
			var lastChar:int = 0;

			var lines:Vector.<Vector.<GTextChar>> = new Vector.<Vector.<GTextChar>>();
			var currentLine:Vector.<GTextChar> = new Vector.<GTextChar>();
			var charIndex:int = 0;
			var whiteSpaceIndex:int = -1;
			var i:int = 0;
			
			while (i<g2d_text.length) {
				// New line character
				if (g2d_text.charCodeAt(i) == 10)
				{
					if (g2d_autoSize)
					{
						g2d_width = (offsetX>g2d_width) ? offsetX : g2d_width;
					}
					previousCharCode = -1;
					lines.push(currentLine);
					currentLine = new Vector.<GTextChar>();
					if (!g2d_autoSize && offsetY + 2 * (g2d_font.lineHeight + g2d_lineSpace) > g2d_height) break;
					offsetX = 0;
					offsetY += g2d_font.lineHeight + g2d_lineSpace;
				}
				else
				{
					currentCharCode = g2d_text.charCodeAt(i);
					
					texture = g2d_font.getG2DChar(currentCharCode) as G2DFontChar;
					
					if (texture == null) 
					{
						++i;
						continue;// throw new GError("Texture for character "+g2d_text.charAt(i)+" with code "+g2d_text.charCodeAt(i)+" not found!");
					}

					if (previousCharCode != -1) {
						offsetX += g2d_font.getKerning(previousCharCode, currentCharCode);
					}

					if (currentCharCode != 32)
					{
						if (charIndex >= g2d_chars.length)
						{
							char = new GTextChar();
							g2d_chars.push(char);
						}
						else
						{
							char = g2d_chars[charIndex];
						}

						char.g2d_code = currentCharCode;
						char.g2d_texture = texture;
						
						if (!g2d_autoSize && offsetX + texture.width > g2d_width)
						{
							lines.push(currentLine);
							var backtrack:int = i - whiteSpaceIndex - 1;
							var currentCount:int = currentLine.length;
							currentLine.splice(currentLine.length-backtrack, backtrack);
							currentLine = new Vector.<GTextChar>();
							charIndex -= backtrack;
							if (backtrack>=currentCount) break;
							if (!g2d_autoSize && offsetY + 2*(g2d_font.lineHeight + g2d_lineSpace) > g2d_height) break;
							i = whiteSpaceIndex+1;
							offsetX = 0;
							offsetY += g2d_font.lineHeight + g2d_lineSpace;
							continue;
						}

						currentLine.push(char);
						char.g2d_visible = true;
						char.g2d_x = offsetX;// + texture.xoffset;
						char.g2d_y = offsetY;// + texture.yoffset;
						charIndex++;
						
					}
					else
					{
						whiteSpaceIndex = i;
					}

					offsetX += texture.xadvance + g2d_tracking;

					previousCharCode = currentCharCode;
				}
				++i;
			}
			lines.push(currentLine);

			var charCount:int = g2d_chars.length;
			
			for (i = charIndex; i < charCount; i++)
			{
				g2d_chars[i].g2d_visible = false;
			}

			if (g2d_autoSize)
			{
				g2d_width = offsetX;
				g2d_height = offsetY + g2d_font.lineHeight;
			}

			var bottom:Number = offsetY + g2d_font.lineHeight;
			offsetY = 0;
			
			if (g2d_vAlign == GVAlignType.MIDDLE)
			{
				offsetY = (g2d_height - bottom) * .5;
			}
			else if (g2d_vAlign == GVAlignType.BOTTOM)
			{
				offsetY = g2d_height - bottom;
			}

			for (i = 0; i < lines.length; i++)
			{
				//var currentLine:Vector.<GTextChar> = lines[i];
				currentLine = lines[i];

				charCount = currentLine.length;
				if (charCount == 0) continue;
				offsetX = 0;
				var last:GTextChar = currentLine[charCount-1];
				var right:Number = last.g2d_x /*- last.g2d_texture.xoffset*/ + last.g2d_texture.xadvance;

				if (g2d_hAlign == GHAlignType.CENTER) {
					offsetX = (g2d_width - right) * .5;
				} else if (g2d_hAlign == GHAlignType.RIGHT) {
					offsetX = g2d_width - right;
				}

				for (var j:int = 0; j < charCount; j++ )
				{
					char = currentLine[j];
					char.g2d_x = char.g2d_x + offsetX;
					char.g2d_y = char.g2d_y + offsetY;
				}
			}
			
			updatePolys();
			
			g2d_invalidate = false;
			
			onTextChanged.dispatch(g2d_text);
		}
		
		private function updatePolys():void 
		{
			var v:Array = [];
			var a:Array = [];
			
			va.length = 0;
			va.push([v, a]);
			
			for (var k:int = 0; k < g2d_chars.length; k++) 
			{
				
				var char:GTextChar = g2d_chars[k];
				
				if (!char.g2d_visible) continue;
				
				if (v.length > 12 * 599) 
				{
					v = [];
					a = [];
					va.push([v, a]);
				}
				
				//l = _letters[k];
				
				var texture:GTexture = char.g2d_texture.texture;

				var uv1x:Number = texture.g2d_region.x / texture.g2d_gpuWidth;
				var uv1y:Number = texture.g2d_region.y / texture.g2d_gpuHeight;
				var uv2x:Number = (texture.g2d_region.x + texture.g2d_region.width) / texture.g2d_gpuWidth;
				var uv2y:Number = (texture.g2d_region.y + texture.g2d_region.height) / texture.g2d_gpuHeight;
				
				var p1x:int = char.g2d_x + texture.pivotX /*- texture.width * 0.5;*/
				var p1y:int = char.g2d_y + texture.pivotY /*- texture.height * 0.5;*/
				var p2x:Number = p1x + texture.width;
				var p2y:Number = p1y + texture.height;
				
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
			
		}
		
		override public function processContextMouseSignal(p_captured:Boolean, p_cameraX:Number, p_cameraY:Number, p_contextSignal:GMouseSignal):Boolean
		{
			if (g2d_width == 0 || g2d_height == 0) return false;

			if (p_captured)
			{
				if (node.g2d_mouseOverNode == node) node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, node, 0, 0, p_contextSignal);
				return false;
			}

			// Invert translations
			var tx:Number = p_cameraX - node.transform.g2d_worldX;
			var ty:Number = p_cameraY - node.transform.g2d_worldY;

			if (node.transform.g2d_worldRotation != 0) {
				var cos:Number = Math.cos(-node.transform.g2d_worldRotation);
				var sin:Number = Math.sin(-node.transform.g2d_worldRotation);

				var ox:Number = tx;
				tx = (tx*cos - ty*sin);
				ty = (ty*cos + ox*sin);
			}

			tx /= node.transform.g2d_worldScaleX*g2d_width;
			ty /= node.transform.g2d_worldScaleY*g2d_height;

			var tw:Number = 0;
			var th:Number = 0;

			if (tx >= -tw && tx <= 1 - tw && ty >= -th && ty <= 1 - th) {
				node.dispatchNodeMouseSignal(p_contextSignal.type, node, tx*g2d_width, ty*g2d_height, p_contextSignal);
				if (node.g2d_mouseOverNode != node) {
					node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OVER, node, tx*g2d_width, ty*g2d_height, p_contextSignal);
				}

				return true;
			} else {
				if (node.g2d_mouseOverNode == node) {
					node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, node, tx*g2d_width, ty*g2d_height, p_contextSignal);
				}
			}

			return false;
		}
		
		/* INTERFACE com.genome2d.components.renderables.IRenderable */
		
		public function getBounds(p_bounds:Rectangle = null):Rectangle 
		{
			if (p_bounds != null)
			{
				p_bounds.x = 0;
				p_bounds.y = 0;
				p_bounds.width = g2d_width;
				p_bounds.height = g2d_height;
			}
			else 
				p_bounds = new Rectangle(0, 0, g2d_width, g2d_height);

			return p_bounds;
		}
		
		public function get tracking():int 
		{
			return g2d_tracking;
		}
		
		public function set tracking(p_tracking:int):void 
		{
			g2d_tracking = p_tracking;
			g2d_invalidate = true;
		}
		
		public function get lineSpace():Number 
		{
			return g2d_lineSpace;
		}
		
		public function set lineSpace(p_value:Number):void 
		{
			g2d_lineSpace = p_value;
			g2d_invalidate = true;
		}
		
		public function get hAlign():int 
		{
			return g2d_hAlign;
		}
		
		public function set hAlign(value:int):void 
		{
			g2d_hAlign = value;
			g2d_invalidate = true;
		}
		
		public function get vAlign():int 
		{
			return g2d_vAlign;
		}
		
		public function set vAlign(value:int):void 
		{
			g2d_vAlign = value;
			g2d_invalidate = true;
		}
		
		public function get height():Number 
		{
			return g2d_height * _scale;
		}
		
		public function set height(value:Number):void 
		{
			g2d_height = value / _scale;
			g2d_invalidate = true;
		}
		
		public function get width():Number 
		{
			return g2d_width * _scale;
		}
		
		public function set width(value:Number):void 
		{
			g2d_width = value / _scale;
			g2d_invalidate = true;
		}

		public function get text():String 
		{
			return g2d_text;
		}
		
		public function set text(value:String):void 
		{
			g2d_text = value;
			g2d_invalidate = true;
		}
		
		public function get font():G2DFont 
		{
			return g2d_font;
		}
		
		public function set font(value:G2DFont):void 
		{
			g2d_font = value;
			g2d_invalidate = true;
			_invalidateSize = true;
		}
		
		public function get autoSize():Boolean 
		{
			return g2d_autoSize;
		}
		
		public function set autoSize(value:Boolean):void 
		{
			g2d_autoSize = value;
			g2d_invalidate = true;
		}
		
		public function get size():Number 
		{
			return _size;
		}
		
		public function set size(value:Number):void 
		{
			_size = value;
			
			_invalidateSize = true;
		}
		
		
	}

}

