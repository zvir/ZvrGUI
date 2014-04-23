package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestSkin;

	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDataGroup extends ZvrContainer 
	{
		
		public function ZvrDataGroup() 
		{
			super(TestSkin);
			addEventListener(ZvrComponentEvent.ADDED, added);
		}
		
		private function added(e:ZvrComponentEvent):void 
		{
			removeEventListener(ZvrComponentEvent.ADDED, added);
			owner.addEventListener(ZvrComponentEvent.RESIZE, ownerResize);
			ownerResize(null);
		}
		
		private function ownerResize(e:ZvrComponentEvent):void 
		{
			width = owner.width;
			height = owner.height;
		}
		
	}

}