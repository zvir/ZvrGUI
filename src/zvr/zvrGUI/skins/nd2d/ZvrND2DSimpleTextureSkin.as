package zvr.zvrGUI.skins.nd2d 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import zvr.zvrGUI.components.nd2d.ZvrND2DSprite2DBatchComponent;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSimpleTextureSkin extends ZvrND2DTextureSkin 
	{
		
		public function ZvrND2DSimpleTextureSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			_body = IZvrSkinLayer(_component.body);
		}
		
	}

}