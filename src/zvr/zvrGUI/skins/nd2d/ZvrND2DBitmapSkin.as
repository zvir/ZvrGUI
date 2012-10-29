package zvr.zvrGUI.skins.nd2d 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.Sprite2DMaterial;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import de.nulldesign.nd2d.utils.TextureHelper;
	import flash.geom.Point;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.layouts.ZvrBitmapAutoSize;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrND2D.Sprite2DBitmapMaterial;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DBitmapSkin extends ZvrSkin 
	{
		
		public function ZvrND2DBitmapSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			_body = new ZvrND2DSkin();
			updateTexture();
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(ZvrND2DStyles.TEXTURE, updateTexture);
			registerStyle(ZvrStyles.AUTO_SIZE, updateTextureSize);
		}
		
		override protected function setStyles():void 
		{
			setStyle(ZvrStyles.AUTO_SIZE, ZvrBitmapAutoSize.AUTO_TO_NO_SCALE);
		}
		
		override protected function updateSize():void 
		{
			super.updateSize();
			updateTextureSize();
			_component.validateBounds(false);
		}
		
		private function updateTexture():void 
		{
			var t:Texture2D;
			
			t = getStyle(ZvrND2DStyles.TEXTURE);
			
			if (t)
			{
				if (!sprite.texture)
				{
					sprite.setMaterial(new Sprite2DBitmapMaterial());
					sprite.setTexture(t);
				}
				else
				{
					sprite.texture = t;
				}
			}
			
			updateTextureSize();
			
		}
		
		private function updateTextureSize():void 
		{
			
			var a:String = getStyle(ZvrStyles.AUTO_SIZE);
			
			if (!texture) return;
			
			
			if (a == ZvrBitmapAutoSize.AUTO_TO_NO_SCALE)
			{
				var dimensions:Point = TextureHelper.getTextureDimensionsFromSize(texture.bitmapWidth, texture.bitmapHeight);
				
				texture.textureHeight = dimensions.y;
				texture.textureWidth = dimensions.x;
				
				sprite.x = sprite.width * 0.5;
				sprite.y = sprite.height * 0.5;
				
				updateComponentSize(texture.bitmapWidth, texture.bitmapHeight);
			}
			else if (a == ZvrBitmapAutoSize.NO_SCALE_TO_MAUAL)
			{
				sprite.x = componentWidth * 0.5 - texture.bitmapWidth * 0.5;
				sprite.y = componentHeight * 0.5 - texture.bitmapHeight * 0.5;
			}
			else if (a == ZvrBitmapAutoSize.FILL)
			{
				sprite.width = componentWidth;
				sprite.height = componentHeight;
				
				sprite.x = sprite.width * 0.5;
				sprite.y = sprite.height * 0.5;
				
			}
			
			else if (a == ZvrBitmapAutoSize.KEEP_RATIO_INSIDE)
			{
				var br:Number = texture.bitmapWidth / texture.bitmapHeight;
				var vr:Number = componentWidth / componentHeight;
				
				/*dimensions = TextureHelper.getTextureDimensionsFromSize(texture.bitmapWidth, texture.bitmapHeight);
				
				Sprite2DBitmapMaterial(sprite.material).customWidth = NaN;
				Sprite2DBitmapMaterial(sprite.material).customHeight = NaN;
				
				sprite.material.uvScaleY = 1;
				sprite.material.uvScaleX = 1;
				
				sprite.material.uvOffsetY = 0
				sprite.material.uvOffsetX = 0;
				
				sprite.scaleX = 1;
				sprite.scaleY = 1;*/
				
				if (br < vr)
				{
					sprite.height = componentHeight;
					sprite.width = sprite.height * br;
				}
				else
				{
					sprite.width = componentWidth;
					sprite.height = sprite.width / br;
				}
				
				sprite.x = componentWidth * 0.5;
				sprite.y = componentHeight * 0.5;

				
			}
			else if (a == ZvrBitmapAutoSize.KEEP_RATIO_OUTSIDE)
			{
				br = texture.bitmapWidth / texture.bitmapHeight;
				vr = componentWidth / componentHeight;
				
				dimensions = TextureHelper.getTextureDimensionsFromSize(texture.bitmapWidth, texture.bitmapHeight);
				
				Sprite2DBitmapMaterial(sprite.material).customWidth = NaN;
				Sprite2DBitmapMaterial(sprite.material).customHeight = NaN;
				
				sprite.material.uvScaleY = 1;
				sprite.material.uvScaleX = 1;
				
				sprite.material.uvOffsetY = 0
				sprite.material.uvOffsetX = 0;
				
				sprite.scaleX = 1;
				sprite.scaleY = 1;
				
				if (br > vr)
				{
					sprite.height = componentHeight;
					sprite.width = sprite.height * br;
				}
				else
				{
					sprite.width = componentWidth;
					sprite.height = sprite.width / br;
				}
				
				sprite.x = componentWidth * 0.5;
				sprite.y = componentHeight * 0.5;

				
			}
			else if (a == ZvrBitmapAutoSize.KEEP_RATIO_OUTSIDE_CLIP)
			{
				dimensions = TextureHelper.getTextureDimensionsFromSize(texture.bitmapWidth, texture.bitmapHeight);
				
				br = texture.bitmapWidth / texture.bitmapHeight;
				vr = componentWidth / componentHeight;
				
				Sprite2DBitmapMaterial(sprite.material).customWidth = componentWidth;
				Sprite2DBitmapMaterial(sprite.material).customHeight = componentHeight;
				
				sprite.scaleX = 1;
				sprite.scaleY = 1;
				
				var s:Number;
			
				if (br > vr)
				{
					
					s = componentHeight / texture.bitmapHeight;
					
					sprite.material.uvScaleY = componentHeight / (dimensions.y*s);
					sprite.material.uvScaleX = componentWidth / (dimensions.x*s);
					
					sprite.material.uvOffsetX = (1 - (componentWidth / (dimensions.x * s))) * 0.5;
					sprite.material.uvOffsetY = (1 - texture.bitmapHeight/dimensions.y) * 0.5;
				}
				else
				{
					s = componentWidth / texture.bitmapWidth
					
					sprite.material.uvScaleY = componentHeight / (dimensions.y*s);
					sprite.material.uvScaleX = componentWidth / (dimensions.x*s);
					
					sprite.material.uvOffsetY = (1 - (componentHeight / (dimensions.y * s))) * 0.5;
 					sprite.material.uvOffsetX = (1 - texture.bitmapWidth/dimensions.x) * 0.5;
				}
				
				sprite.x = componentWidth * 0.5;
				sprite.y = componentHeight * 0.5;
			}
			
		}
		
		public function get texture():Texture2D
		{
			return Sprite2D(_body).texture;
		}
		
		public function get sprite():Sprite2D
		{
			return Sprite2D(_body);
		}
	}

}