package zvr.zvrComps.zvrTool.zvtStatsChart 
{
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	/**
	 * ...
	 * @author Zvir
	 */
	public class MiniStats extends ZvrGroup
	{
		
		private var _stats:LabelMD;
		
		public function MiniStats() 
		{
			autoSize = ZvrAutoSize.CONTENT;
			
			_stats = new LabelMD();
			_stats.multiline = true;
			_stats.labelAutoSize = true;
			_stats.width = 80;
			addChild(_stats);
		}
		
		public function setStats(t:String):void
		{
			_stats.text = t;
		}
		
		
	}

}