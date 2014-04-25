package clv.gui.g2d.core 
{
	import clv.gui.core.display.ISkinBody;
	import clv.gui.core.skins.Skin;
	import clv.gui.core.skins.SkinContainer;
	import clv.gui.g2d.display.G2DContainerMask;
	import clv.gui.g2d.display.G2DGuiBody;
	import clv.gui.g2d.display.G2DMaskTexture;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SkinContainerG2D extends SkinContainer
	{
		protected var _componentNode:GNode;
		protected var _maskTexture:GTexture;
		
		private var _offsetX:Number = 0.0
		private var _offsetY:Number = 0.0
		private var _offsetDirty:Boolean;
		
		public function SkinContainerG2D() 
		{
			
		}
		
		override protected function create():void 
		{
			_cointainerBody = GNodeFactory.createNodeWithComponent(G2DGuiBody) as G2DGuiBody;
			_componentBody = _cointainerBody;
			
			_componentNode = G2DGuiBody(_cointainerBody).node;
			
			_childrenBody = GNodeFactory.createNodeWithComponent(G2DGuiBody) as G2DGuiBody;
			_cointainerBody.addElement(_childrenBody);
		}
		
		override public function preUpdate():void 
		{
			super.preUpdate();
			
			if (_offsetDirty)
			{
				positionDirty = true;
				_offsetDirty = false;
			}
		}
		
		override public function updateBounds():void 
		{
			_componentBody.x = _component.bounds.x + offsetX;
			_componentBody.y = _component.bounds.y + offsetY;
		}
		
		override public function set maskEnabled(value:Boolean):void 
		{
			
			if (value && !_mask)
			{
				_mask = GNodeFactory.createNodeWithComponent(G2DContainerMask) as G2DContainerMask;
				G2DContainerMask(_mask).texture = _maskTexture ? _maskTexture : G2DMaskTexture.texture;
			}
			
			_mask.enabled = value;
			
			if (value)
			{
				_componentNode.addChild(G2DContainerMask(_mask).node);
				G2DGuiBody(_childrenBody).node.g2d_mask = G2DContainerMask(_mask).node;
				G2DContainerMask(_mask).node.g2d_usedAsMask++;
			}
			else
			{
				_componentNode.removeChild(G2DContainerMask(_mask).node);
				G2DGuiBody(_childrenBody).node.g2d_mask = null;
				G2DContainerMask(_mask).node.g2d_usedAsMask--;
			}
			
			super.maskEnabled = value;
		}
		
		public function get offsetX():Number 
		{
			return _offsetX;
		}
		
		public function set offsetX(value:Number):void 
		{
			_offsetX = value;
			_offsetDirty = true;
		}
		
		public function get offsetY():Number 
		{
			return _offsetY;
		}
		
		public function set offsetY(value:Number):void 
		{
			_offsetY = value;
			_offsetDirty = true;
		}
		
	}

}