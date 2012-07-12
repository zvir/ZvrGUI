package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.skins.base.ZvrSkin;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class VScrollMDSkin extends ZvrSkin
	{
		
		public function VScrollMDSkin(scroll:ZvrScroll, registration:Function)
		{
			super(scroll, registration);
		}
		
		override protected function create():void
		{
			_body = new Sprite();
		}
		
		
	}

}