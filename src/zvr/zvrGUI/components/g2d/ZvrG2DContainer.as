package zvr.zvrGUI.components.g2d 
{
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.node.GNode;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.textures.factories.GTextureFactory;
	import com.genome2d.textures.GTexture;
	import flash.display.BitmapData;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DContainer extends ZvrContainerBase implements IZvrG2DComponent
	{
		
		private static var _maskTexture:GTexture;
		
		public static function get maskTexture():GTexture
		{
			if (!_maskTexture)
			{
				var bd:BitmapData = new BitmapData(128, 128, false, 0x49FF0D);
				_maskTexture = GTextureFactory.createFromBitmapData("ContainerMask", bd);
			}
			
			return _maskTexture;
			
		}
		
		private var _mask:GSprite;
		
		public function ZvrG2DContainer(skinClass:Class, bodyClass:Class)
		{
			_maskingEnabled = false;
			super(skinClass, bodyClass);
			_maskingEnabled = false;
			
			if (_skin.shell)
			{
				node.addChild(_skin.shell as GNode);
			}
			
		}
		
		override protected function updateMask():void 
		{
			super.updateMask();
			
			if (!_maskingEnabled) return;
			
			var w:Number = bounds.width - _contentPadding.right - _contentPadding.left;
			var h:Number = bounds.height - _contentPadding.bottom - _contentPadding.top;
			
			_mask.node.transform.x = _contentPadding.left + w * 0.5;
			_mask.node.transform.y = _contentPadding.top + h * 0.5;
			
			_mask.node.transform.scaleX = w / 128;
			_mask.node.transform.scaleY = h / 128;
			
		}
		
		override public function set maskingEnabled(value:Boolean):void 
		{
			
			if (_maskingEnabled == value) return;
			
			super.maskingEnabled = value;
			
			if (maskingEnabled)
			{
				if (!_mask)
				{
					_mask = GNodeFactory.createNodeWithComponent(GSprite) as GSprite;
					_mask.texture = maskTexture;
				}
				
				//_base.addChild(_mask.node);
				
				//node.transform.mask = _mask.node;
				
				updateMask();
				
			}
			else
			{
				//if (_mask) _base.removeChild(_mask.node);
				//node.transform.mask = null;
			}
			
		}
		
		public function get node():ZvrG2DBody
		{
			return ZvrG2DBody(body);
		}
		
	}

}