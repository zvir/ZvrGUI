package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrBringToFrontBehavior;
	import zvr.zvrGUI.behaviors.ZvrTouchMouseBehavior;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.skins.zvrMinimalDark.TouchMouseMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class TouchMouseMD extends ZvrContainer
	{
		
		private var _touchMouseBehavior:ZvrTouchMouseBehavior;
		private var _bringToFrontBehavior:ZvrBringToFrontBehavior;
		
		public function TouchMouseMD() 
		{
			super(TouchMouseMDSkin);
			
			width = 100;
			height = 100;
			
			_touchMouseBehavior = new ZvrTouchMouseBehavior();
			_bringToFrontBehavior = new ZvrBringToFrontBehavior();
			_behaviors.addBehavior(_touchMouseBehavior);
			_behaviors.addBehavior(_bringToFrontBehavior);
		}
		
	}

}