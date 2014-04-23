package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.common.styles.ImageStyleCrop;
	import clv.gui.g2d.core.SkinG2D;
	import clv.gui.g2d.display.G2DGuiBody;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.factory.GNodeFactory;
	import flash.geom.Rectangle;
	import zvr.zvrG2D.ZvrGSprite;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SpriteComponetnSkin extends SkinG2D
	{
		private var _sprite:ZvrGSprite;
		private var _crop:String;
		
		private var _maskRect:Rectangle;
		
		public function SpriteComponetnSkin() 
		{
			
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ImageStyle.CROP	, setCrop);
			registerStyle(ImageStyle.IMAGE	, setImage);
		}
		
		override protected function setStyles():void 
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.NO_SCALE);
		}
		
		override protected function create():void 
		{
			super.create();
			
			_sprite = _skinNode.addComponent(ZvrGSprite) as ZvrGSprite;
			_maskRect = new Rectangle();
			
		}
		
		override public function preUpdate():void 
		{
			super.preUpdate();
			
			if (_crop == ImageStyleCrop.NO_SCALE && _sprite.texture)
			{
				if (_component.width != _sprite.texture.width) _component.width = _sprite.texture.width;
				if (_component.height != _sprite.texture.height) _component.height = _sprite.texture.height;
			}
		}
		
		override public function updateBounds():void 
		{
			super.updateBounds();
			
			if (!positionDirty && !sizeDirty) return;
			
			if (sizeDirty)
			{
				if (_crop == ImageStyleCrop.NO_SCALE || _crop == ImageStyleCrop.FILL)
				{
					_skinNode.transform.scaleX = _component.bounds.width / _sprite.texture.width;
					_skinNode.transform.scaleY = _component.bounds.height / _sprite.texture.height;
					
					_sprite.maskRect = null;
				}
				else
				{
					var rc:Number = _component.bounds.width / _component.bounds.height;
					var ri:Number = _sprite.texture.width / _sprite.texture.height;
					
					if (_crop == ImageStyleCrop.INSIDE)
					{
						
						if (rc < ri)
						{
							_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.width / _sprite.texture.width;
						}
						else
						{
							_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.height / _sprite.texture.height;
						}
						
					}
					else if (_crop == ImageStyleCrop.OUTSIDE)
					{
						if (rc > ri)
						{
							_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.width / _sprite.texture.width;
						}
						else
						{
							_sprite.node.transform.scaleX = _sprite.node.transform.scaleY = _component.bounds.height / _sprite.texture.height;
						}
						
					}
					
					_maskRect.x = -_component.bounds.width / 2;
					_maskRect.y = -_component.bounds.height / 2;
					
					_maskRect.width = _component.bounds.width;
					_maskRect.height = _component.bounds.height;
					
					_sprite.maskRect = _maskRect
				}
			}
			
			
			_skinNode.transform.x = int(_component.bounds.x + _component.bounds.width / 2);
			_skinNode.transform.y = int(_component.bounds.y + _component.bounds.height / 2);
		}
		
		private function setCrop():void 
		{
			_crop = getStyle(ImageStyle.CROP);
		}
		
		private function setImage():void 
		{
			_sprite.texture = getStyle(ImageStyle.IMAGE);
		}
	}
}