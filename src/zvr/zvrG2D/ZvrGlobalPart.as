package zvr.zvrG2D 
{
	import com.genome2d.components.GComponent;
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.context.GContextCamera;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GMouseSignal;
	import com.genome2d.signals.GMouseSignalType;
	import com.genome2d.textures.GTexture;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrGlobalPart extends GComponent implements IRenderable
	{
		public var blendMode:int = GBlendMode.NORMAL;
		

		private var _width:Number = 0;
		private var _height:Number = 0;
		
		private var _x:Number = 0;
		private var _y:Number = 0;
		
		private var _globalWidth:Number = 0;
		private var _globalHeight:Number = 0;
		
		private var _globalX:Number = 0;
		private var _globalY:Number = 0;
		
		
		private var _global:Rectangle;
		
		private var _texture:GTexture;
		private var _verticesDirty:Boolean;
		
		protected var g2d_vertices:Array;
		protected var g2d_uvs:Array;
		
		public function ZvrGlobalPart() 
		{
			super();
			
			g2d_vertices = [];
			g2d_uvs = [];
		}
		
		private function updateVertices():void 
		{
			g2d_vertices.length = 0;
			g2d_uvs.length = 0;
			
			var x1:Number = _x;
			var x2:Number = _x + _width;
			
			var y1:Number = _y;
			var y2:Number = _y + height;
			
			
			var r1:Number = _texture.width / _texture.height;
			var r2:Number = _globalWidth / _globalHeight;
			
			var f:Number;
			var o:Number;
			
			var u1:Number;
			var u2:Number;
			             
			var v1:Number;
			var v2:Number;
			
			if (r1 > r2)
			{
				
				f =  r2 / r1;
				o = (1 - f) / 2;
				
				u1 = o + (x1 / _globalWidth) * f;
				u2 = o + (x2 / _globalWidth) * f;
				   
				v1 = y1 / _globalHeight;
				v2 = y2 / _globalHeight;
				
			}
			else
			{
				
				f =   r1 / r2;
				o = (1 - f) / 2;
				
				
				u1 = x1 / _globalWidth;
				u2 = x2 / _globalWidth;
				  
				v1 = o + (y1 / _globalHeight) * f;
				v2 = o + (y2 / _globalHeight) * f;
				
			}
			
			/*u1 *= x1 / _globalWidth;
			u2 *= x2 / _globalWidth;
			   
			v1 *= y1 / _globalHeight;
			v2 *= y2 / _globalHeight;*/
			
			addPart(u1, v1, u2, v2, x1, y1, x2, y2);
		}
		
		
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void
		{
			if (texture == null || g2d_vertices == null || g2d_uvs == null) return;
			
			var transform:GTransform = node.transform;
			
			if (_x != transform.g2d_worldX || _y != transform.g2d_worldY)
			{
				_x = transform.g2d_worldX;
				_y = transform.g2d_worldY;
				
				_verticesDirty = true;
			}
			
			if (_verticesDirty)
			{
				updateVertices();
				_verticesDirty = false;
			}
			
			
			node.core.getContext().drawPoly(texture, g2d_vertices, g2d_uvs, _globalX, _globalY, 1, 1, 0, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
		}
		
		override public function processContextMouseSignal(p_captured:Boolean, p_cameraX:Number, p_cameraY:Number, p_contextSignal:GMouseSignal):Boolean 
		{
			
			if (p_captured && p_contextSignal.type == GMouseSignalType.MOUSE_UP) node.g2d_mouseDownNode = null;

			if (p_captured || texture == null || _width == 0 || _height == 0 || node.transform.g2d_worldScaleX == 0 || node.transform.g2d_worldScaleY == 0)
			{
				if (node.g2d_mouseOverNode == node) node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, node, 0, 0, p_contextSignal);
				return false;
			}

			// Invert translations
			var tx:Number = p_cameraX - node.transform.g2d_worldX;
			var ty:Number = p_cameraY - node.transform.g2d_worldY;

			if (node.transform.g2d_worldRotation != 0)
			{
				var cos:Number = Math.cos(-node.transform.g2d_worldRotation);
				var sin:Number = Math.sin(-node.transform.g2d_worldRotation);

				var ox:Number = tx;
				tx = (tx * cos - ty * sin);
				ty = (ty * cos + ox * sin);
			}

			tx /= node.transform.g2d_worldScaleX * _width;
			ty /= node.transform.g2d_worldScaleY * _height;

			if (tx >= 0 && tx <= 1 && ty >= 0 && ty <= 1)
			{
				node.dispatchNodeMouseSignal(p_contextSignal.type, node, tx * _width, ty * _height, p_contextSignal);
				
				if (node.g2d_mouseOverNode != node)
				{
					node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OVER, node, tx * _width, ty * _height, p_contextSignal);
				}

				return true;
			} 
			else 
			{
				if (node.g2d_mouseOverNode == node)
				{
					node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, node, tx * _width, ty * _height, p_contextSignal);
				}
			}

			return false;
		}
		
		public function getBounds(p_target:Rectangle = null):Rectangle 
		{
			return null;
		}
		
		
		private function addPart(uv1x:Number, uv1y:Number, uv2x:Number, uv2y:Number, p1x:Number, p1y:Number, p2x:Number, p2y:Number):void
		{
			
			if (p1x == p2x || p1y == p2y) return;
			
			g2d_vertices.push
			(
				p1x, p1y, 
				p2x, p1y, 
				p1x, p2y, 
				
				p2x, p1y,
				p2x, p2y,
				p1x, p2y
			);
			
			g2d_uvs.push
			(
				uv1x, uv1y,
				uv2x, uv1y,
				uv1x, uv2y,
				
				uv2x, uv1y,
				uv2x, uv2y,
				uv1x, uv2y
			);
		}
		
		public function get texture():GTexture 
		{
			return _texture;
		}
		
		public function set texture(value:GTexture):void 
		{
			_texture = value;
			_verticesDirty = true;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			_width = value;
			_verticesDirty = true;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			_height = value;
			_verticesDirty = true;
		}
		
		public function get y():Number 
		{
			return _y;
		}
		
		/*public function set y(value:Number):void 
		{
			_y = value;
			_verticesDirty = true;
		}
		
		public function get x():Number 
		{
			return _x;
		}*/
		
		public function set x(value:Number):void 
		{
			_x = value;
			_verticesDirty = true;
		}
		
		public function get globalY():Number 
		{
			return _globalY;
		}
		
		public function set globalY(value:Number):void 
		{
			_globalY = value;
			_verticesDirty = true;
		}
		
		public function get globalX():Number 
		{
			return _globalX;
		}
		
		public function set globalX(value:Number):void 
		{
			_globalX = value;
			_verticesDirty = true;
		}
		
		public function get globalHeight():Number 
		{
			return _globalHeight;
		}
		
		public function set globalHeight(value:Number):void 
		{
			_globalHeight = value;
			_verticesDirty = true;
		}
		
		public function get globalWidth():Number 
		{
			return _globalWidth;
		}
		
		public function set globalWidth(value:Number):void 
		{
			_globalWidth = value;
			_verticesDirty = true;
		}
		
		
	}

}