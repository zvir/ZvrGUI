package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	/**
	 * ...
	 * @author Zvir
	 */
	public class DynamicTexture 
	{
		private var _bitmapClass:Class;
		
		private var _texture:Texture2D;
		private var _sprites:Vector.<Sprite2D>;
		
		public function DynamicTexture(bitmapClass:Class) 
		{
			_bitmapClass = bitmapClass;
		}
		
		public function addSprite(s:Sprite2D):void
		{
			if (_sprites.indexOf(s) == -1)
			{
				_sprites.push(s);
			}
			
			s.setTexture(texture);
			
		}
		
		public function removeSprite(s:Sprite2D):void
		{
			var i:int = _sprites.indexOf(s);
			
			if (i != -1)
			{
				_sprites.splice(s, 1);
			}
			
			if (_sprites.length == 0)
			{
				_texture.dispose();
				_texture = null;
			}
		}
		
		private function get texture():Texture2D
		{
			if (!_texture)
			{
				_texture = Texture2D.textureFromBitmapClass(_bitmapClass);
			}
			
			return _texture;
		}
	}

}