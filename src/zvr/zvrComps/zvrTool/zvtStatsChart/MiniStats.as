package zvr.zvrComps.zvrTool.zvtStatsChart 
{
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.PanelMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.utils.ZvrComponentUtils;
	/**
	 * ...
	 * @author Zvir
	 */
	public class MiniStats extends PanelMD
	{
		
		private var _stats:LabelMD;
		
		public function MiniStats() 
		{
			childrenPadding.padding = 5;
			
			minHeight = 10;
			minWidth = 10;
			
			_stats = new LabelMD();
			_stats.multiline = true;
			_stats.labelAutoSize = true;
			_stats.width = 80;
			_stats.height = 30;
			addChild(_stats);
			
			ZvrComponentUtils.setPanelSizeToContent(this, 80, 30);
			
			//autoSize = ZvrAutoSize.CONTENT;
		}
		
		public function setStats(t:String):void
		{
			_stats.text = t;
		}
		
		
	}

}