package zvr.zvrG2D 
{
	import com.genome2d.components.GTransform;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.context.GBlendMode;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GContextCamera;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrGSprite extends GSprite
	{
		
		public var maskRect:Rectangle;
		
		private var _maskRect:Rectangle = new Rectangle();
		
		public function ZvrGSprite(p_node:GNode=null) 
		{
			super(p_node);
		}
		
		override public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void 
		{
			
			if (!maskRect)
			{
				node.maskRect = null;
			}
			else
			{
				_maskRect.x 		= maskRect.x + node.g2d_transform.g2d_worldX;
				_maskRect.y 		= maskRect.y + + node.g2d_transform.g2d_worldY;
				_maskRect.width 	= maskRect.width;
				_maskRect.height 	= maskRect.height;
				
				node.maskRect = _maskRect;
			}
			
			super.render(p_camera, p_useMatrix);
		}
		
	}

}