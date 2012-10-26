package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class WindowOptionsMDSkin extends ZvrSkin 
	{
		
		public function WindowOptionsMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
			
		}
		
		override protected function create():void 
		{
			_body = new ZvrFlashSkin();
		}
		
		override protected function updateSize():void 
		{
			var sp:Sprite = _body as Sprite;
			sp.graphics.clear();
			sp.graphics.beginFill(0x8EFF28, 0);
			sp.graphics.drawRect(0, 0, componentWidth, componentHeight - 3);
			sp.graphics.endFill();
		}
		
	}
	
}