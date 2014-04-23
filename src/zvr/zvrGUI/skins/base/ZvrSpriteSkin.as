package zvr.zvrGUI.skins.base 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.IZvrComponent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSpriteSkin extends ZvrSkin
	{
		
		public function ZvrSpriteSkin(component:IZvrComponent, registration:Function)
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			super.create();
			
			_body = new ZvrFlashSkin();
			
		}
		
	}

}