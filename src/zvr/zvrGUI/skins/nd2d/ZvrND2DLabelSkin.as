package zvr.zvrGUI.skins.nd2d 
{
	import flash.events.Event;
	import zvr.zvrGUI.components.nd2d.ZvrND2DFNTBody;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DLabelSkin extends ZvrSkin 
	{
		
		private var fnt:ZvrND2DFNTBody;
		
		public function ZvrND2DLabelSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function registerStyles():void 
		{
			super.registerStyles();
			
			registerStyle(ZvrND2DFNTStyle.FONT_TEXTURE, setFntTexture);
			registerStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, setFntSpriteSheet);
			registerStyle(ZvrND2DFNTStyle.FONT_COLOR, setFontColor);
			registerStyle(ZvrND2DFNTStyle.FONT_SPACING, setFontSpacing);
		}
		
		private function setFontSpacing():void 
		{
			fnt.spacing = getStyle(ZvrND2DFNTStyle.FONT_SPACING);
		}
		
		private function setFontColor():void 
		{
			fnt.tint = getStyle(ZvrND2DFNTStyle.FONT_COLOR);
		}
		
		private function setFntTexture():void 
		{
			fnt.texture = getStyle(ZvrND2DFNTStyle.FONT_TEXTURE);
		}
		
		private function setFntSpriteSheet():void 
		{
			fnt.setSpriteSheet(getStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET));
		}
		
		override protected function create():void 
		{
			_body = IZvrSkinLayer(_component.body);
			fnt = _body as ZvrND2DFNTBody;
			fnt.addEventListener(Event.CHANGE, change);
		}
		
		private function change(e:Event):void 
		{
			updateComponentSize(fnt.width, fnt.height);
		}
		
	}

}