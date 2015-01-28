package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrGroup;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ProgressBarUI extends ZvrGroup
	{
		
		public const bar:ProgressBarMD = new ProgressBarMD();
		public const label:LabelMD = new LabelMD();
		
		public function ProgressBarUI() 
		{
			super();
			
			bar.percentWidth = 100;
			
			bar.top = 20;
			bar.bottom = 0;
			
			addChild(label);
			
			addChild(bar);
			
			
			
		}
		
	}

}