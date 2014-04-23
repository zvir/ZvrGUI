package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.g2d.core.SkinContainerG2D;
	import flash.geom.Rectangle;
	import zvr.zvrG2D.ZvrGSprite;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class BackgroudContainerSkin extends SkinContainerG2D
	{
		private var _maskRect:Rectangle;
		private var _sprite:ZvrGSprite;
		
		public function BackgroudContainerSkin() 
		{
			
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ImageStyle.IMAGE	, setImage);
		}
		
		override protected function create():void 
		{
			super.create();
			
			_sprite = _componentNode.addComponent(ZvrGSprite) as ZvrGSprite;
			_maskRect = new Rectangle();
			
		}
		
		override public function updateBounds():void 
		{
			super.updateBounds();
			
			if (!positionDirty && !sizeDirty) return;
			
			if (sizeDirty)
			{
				
				var rc:Number = _component.bounds.width / _component.bounds.height;
				var ri:Number = _sprite.texture.width / _sprite.texture.height;
				
				if (rc > ri)
				{
					_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.width / _sprite.texture.width;
				}
				else
				{
					_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.height / _sprite.texture.height;
				}
					
				_maskRect.x = -_component.bounds.width / 2;
				_maskRect.y = -_component.bounds.height / 2;
				
				_maskRect.width = _component.bounds.width;
				_maskRect.height = _component.bounds.height;
				
				_sprite.maskRect = _maskRect
				
			}
			
			_componentNode.transform.x = int(_component.bounds.x + _component.bounds.width / 2);
			_componentNode.transform.y = int(_component.bounds.y + _component.bounds.height / 2);
		}
		
		private function setImage():void 
		{
			_sprite.texture = getStyle(ImageStyle.IMAGE);
		}
		
	}

}