package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DFNTStyle;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DLabelSkin;
	import zvr.zvrND2D.FNTSpriteSheet;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DLabel extends ZvrND2DComponent 
	{
		
		private var _text:String;
		
		public function ZvrND2DLabel(fntTexture:Texture2D, fntSpriteSheet:FNTSpriteSheet) 
		{
			super(ZvrND2DLabelSkin, ZvrND2DFNTBody);
			
			setStyle(ZvrND2DFNTStyle.FONT_TEXTURE, fntTexture);
			setStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, fntSpriteSheet);
			
		}
		
		public function get text():String 
		{
			return fntBody.text;
		}
		
		public function set text(value:String):void 
		{
			fntBody.text = value;
		}
		
		public function get fntBody():ZvrND2DFNTBody
		{
			return _body as ZvrND2DFNTBody;
		}
		
	}

}