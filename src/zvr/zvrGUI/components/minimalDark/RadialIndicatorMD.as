package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.skins.zvrMinimalDark.RadialIndicatorMDSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class RadialIndicatorMD extends ZvrContainer 
	{
		
		private var _value:Number;
		
		public function RadialIndicatorMD() 
		{
			super(RadialIndicatorMDSkin);
			
			minWidth = 15;
			minHeight = 15;
			
		}
		
		public function get value():Number 
		{
			return _value;
		}
		
		public function set value(value:Number):void 
		{
			_value = value;
			radialSkin.updateValue(value);
		}
		
		
		private function get radialSkin():RadialIndicatorMDSkin
		{
			return RadialIndicatorMDSkin(skin);
		}
		
	}

}