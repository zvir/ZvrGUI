package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.SpriteSheet;
	import de.nulldesign.nd2d.materials.texture.SpriteSheetAnimation;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSheet extends SpriteSheet
	{
		
		private var _totalFrames:int = -1;
		
		public function ZvrSheet(sheetWidth:Number, sheetHeight:Number, spriteWidth:Number, spriteHeight:Number, fps:uint, spritesPackedWithoutSpace:Boolean = false)
		{
			super(sheetWidth, sheetHeight, spriteWidth, spriteHeight, fps, spritesPackedWithoutSpace);
		}
		
		override public function get totalFrames():uint 
		{
			return _totalFrames == -1 ? super.totalFrames : _totalFrames;
		}
		
		public function set totalFrames(value:uint):void 
		{
			//trace("totalFrames", value);
			_totalFrames = value;
		}
		
		override public function clone():ASpriteSheetBase 
		{
			var s:ZvrSheet = new ZvrSheet(_sheetWidth, _sheetHeight, _spriteWidth, _spriteHeight, fps, spritesPackedWithoutSpace);

			for(var name:String in animationMap) {
				var anim:SpriteSheetAnimation = animationMap[name];
				s.addAnimation(name, anim.frames.concat(), anim.loop);
			}

			s.frame = frame;
			s.totalFrames = _totalFrames;
			return s;
		}
		
	}

}