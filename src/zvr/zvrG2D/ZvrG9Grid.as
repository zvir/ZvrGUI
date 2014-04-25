package zvr.zvrG2D 
{
	import com.genome2d.components.GComponent;
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.context.GContextCamera;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrG9Grid extends GComponent implements IRenderable
	{
		private var _texture:GTexture;
		public var blendMode:int = GBlendMode.NORMAL;
		
		private var _maskRectX1:Number = 0;
		private var _maskRectY1:Number = 0;
		private var _maskRectX2:Number = 0;
		private var _maskRectY2:Number = 0;
		
		private var _useMaskRect:Boolean;

		protected var g2d_vertices:Array;
		protected var g2d_uvs:Array;

		private var _verticesDirty:Boolean;
		
		private var _gridX1:Number = 0.0;
		private var _gridX2:Number = 0.0;
		
		private var _gridY1:Number = 0.0;
		private var _gridY2:Number = 0.0;
		
		private var _gx1:Number = 0.0;
		private var _gx2:Number = 0.0;
		private var _gy1:Number = 0.0;
		private var _gy2:Number = 0.0;
		
		private var _width:Number;
		private var _height:Number;
		
		public function ZvrG9Grid(p_node:GNode)
		{
			super(p_node);
			g2d_vertices = [];
			g2d_uvs = [];
		}
		
		private function addPart(uv1x:Number, uv1y:Number, uv2x:Number, uv2y:Number, p1x:Number, p1y:Number, p2x:Number, p2y:Number):void
		{
			
			if (useMaskRect)
			{
				
				var r:Number;
				
				if (p1x < _maskRectX1) 
				{
					uv1x = uv1x + (uv2x - uv1x) * (_maskRectX1 - p1x) / (p2x - p1x);
					p1x = _maskRectX1;
				}
				
				if (p1x > _maskRectX2) 
				{
					return;
					uv1x = uv1x + (uv2x - uv1x) * (_maskRectX2 - p1x) / (p2x - p1x);
					p1x = _maskRectX2;
				}
				
				if (p2x < _maskRectX1)
				{
					return;
					uv2x = uv1x + (uv2x - uv1x) * (_maskRectX1 - p1x) / (p2x - p1x);
					p2x = _maskRectX1;
				}
				
				if (p2x > _maskRectX2) 
				{
					uv2x = uv1x + (uv2x - uv1x) * (_maskRectX2 - p1x) / (p2x - p1x);
					p2x = _maskRectX2;
				}
				
				if (p1y < _maskRectY1)
				{
					uv1y = uv1y + (uv2y - uv1y) * (_maskRectY1 - p1y) / (p2y - p1y);
					p1y = _maskRectY1;
				}
				
				if (p1y > _maskRectY2)
				{
					return;
					uv1y = uv1y + (uv2y - uv1y) * (_maskRectY2 - p1y) / (p2y - p1y);
					p1y = _maskRectY2;
				}
				
				if (p2y < _maskRectY1)
				{
					return;
					uv2y = uv1y + (uv2y - uv1y) * (_maskRectY1 - p1y) / (p2y - p1y);
					p2y = _maskRectY1;
				}
				
				if (p2y > _maskRectY2)
				{
					uv2y = uv1y + (uv2y - uv1y) * (_maskRectY2 - p1y) / (p2y - p1y);
					p2y = _maskRectY2;
				}
			}
			
			if (p1x == p2x || p1y == p2y || p2x < p1x || p2y < p1y) return;
			
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

		private function updateVertices():void 
		{
			
			if (!texture) return;
			
			g2d_vertices.length = 0;
			g2d_uvs.length = 0;
			
			var w:Number = texture.width;
			var h:Number = texture.height;
			
			var W:Number = isNaN(_width) ? texture.width : _width;
			var H:Number = isNaN(_height) ? texture.height : _height;
			
						
			_gx1 = _gridX1 / w;
			_gx2 = (w - _gridX2) / w;
			
			_gy1 = _gridY1 / h;
			_gy2 = (h - _gridY2) / h;
			
			
			var x1:Number = 0 + texture.pivotX;
			var x2:Number = _gx1 * w+ texture.pivotX;
			var x3:Number = W - (w - _gx2 * w)+ texture.pivotX;
			var x4:Number = W+ texture.pivotX;
			
			var y1:Number = 0 + texture.pivotY;
			var y2:Number = _gy1 * h + texture.pivotY;
			var y3:Number = H - (h - _gy2 * h) + texture.pivotY;
			var y4:Number = H + texture.pivotY;
			
			addPart(0000, 0000, _gx1, _gy1, x1 ,y1 , x2, y2);
			addPart(_gx1, 0000, _gx2, _gy1, x2 ,y1 , x3, y2);
			addPart(_gx2, 0000, 0001, _gy1, x3 ,y1 , x4, y2);
														 
			addPart(0000, _gy1, _gx1, _gy2, x1 ,y2 , x2, y3);
			addPart(_gx1, _gy1, _gx2, _gy2, x2 ,y2 , x3, y3);
			addPart(_gx2, _gy1, 0001, _gy2, x3 ,y2 , x4, y3);
														 
			addPart(0000, _gy2, _gx1, 0001, x1 ,y3 , x2, y4);
			addPart(_gx1, _gy2, _gx2, 0001, x2 ,y3 , x3, y4);
			addPart(_gx2, _gy2, 0001, 0001, x3 ,y3 , x4, y4);
			
			
		}

		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void
		{
			if (texture == null || g2d_vertices == null || g2d_uvs == null) return;
			
			if (_verticesDirty)
			{
				updateVertices();
				_verticesDirty = false;
			}
			
			var transform:GTransform = node.transform;
			node.core.getContext().drawPoly(texture, g2d_vertices, g2d_uvs, transform.g2d_worldX, transform.g2d_worldY, transform.g2d_worldScaleX, transform.g2d_worldScaleY, transform.g2d_worldRotation, transform.g2d_worldRed, transform.g2d_worldGreen, transform.g2d_worldBlue, transform.g2d_worldAlpha, blendMode);
		}
		

		public function getBounds(p_target:Rectangle = null):Rectangle
		{
			return null;
		}
		
		public function get gridX1():Number 
		{
			return _gridX1;
		}
		
		public function set gridX1(value:Number):void 
		{
			_gridX1 = value;
			_verticesDirty = true;
		}
		
		public function get gridX2():Number 
		{
			return _gridX2;
		}
		
		public function set gridX2(value:Number):void 
		{
			_gridX2 = value;
			_verticesDirty = true;
		}
		
		public function get gridY1():Number 
		{
			return _gridY1;
		}
		
		public function set gridY1(value:Number):void 
		{
			_gridY1 = value;
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
		
		public function get gridY2():Number 
		{
			return _gridY2;
		}
		
		public function set gridY2(value:Number):void 
		{
			_gridY2 = value;
			_verticesDirty = true;
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
		
		public function get useMaskRect():Boolean 
		{
			return _useMaskRect;
		}
		
		public function set useMaskRect(value:Boolean):void 
		{
			_useMaskRect = value;
			_verticesDirty = true;
		}
		
		public function get maskRectY2():Number 
		{
			return _maskRectY2;
		}
		
		public function set maskRectY2(value:Number):void 
		{
			_maskRectY2 = value;
			_verticesDirty = true;
		}
		
		public function get maskRectX2():Number 
		{
			return _maskRectX2;
		}
		
		public function set maskRectX2(value:Number):void 
		{
			_maskRectX2 = value;
			_verticesDirty = true;
		}
		
		public function get maskRectY1():Number 
		{
			return _maskRectY1;
		}
		
		public function set maskRectY1(value:Number):void 
		{
			_maskRectY1 = value;
			_verticesDirty = true;
		}
		
		public function get maskRectX1():Number 
		{
			return _maskRectX1;
		}
		
		public function set maskRectX1(value:Number):void 
		{
			_maskRectX1 = value;
			_verticesDirty = true;
		}
	}

}