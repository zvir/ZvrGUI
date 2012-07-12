package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.core.relays.ZvrPanelRelay;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrPanel extends ZvrPanelRelay
	{
		
		private var _scroller:ZvrScroller;
		
		public function ZvrPanel(skin:Class) 
		{
			super(skin);
		}
		
		public function get scroller():ZvrScroller 
		{
			return _scroller;
		}
		
		public function set scroller(value:ZvrScroller):void 
		{
			_scroller = value;
			_contents = scroller;
		}
		
	}

}