package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.zvrMinimalDark.ProgressBarMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ProgressBarMD extends ZvrComponent
	{
		
		public function ProgressBarMD() 
		{
			super(ProgressBarMDSkin);
			setStyle("progress", 1);

		}
		
		public function get progress():Number 
		{
			return getStyle("progress");
		}
		
		public function set progress(value:Number):void 
		{
			setStyle("progress", value);
		}
		
	}

}