package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.materials.texture.SpriteSheet;
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
			trace("totalFrames", value);
			_totalFrames = value;
		}
		
	}

}