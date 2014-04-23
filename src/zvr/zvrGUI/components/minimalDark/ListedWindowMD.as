package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.relays.ZvrPanelRelay;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ListedWindowMD extends ZvrPanelRelay
	{
		
		public var bar:ToggleButtonMD;
		
		public function ListedWindowMD() 
		{
			
			super(ZvrSkin);
			
			percentWidth = 100;
			minHeight = 20;
			
			autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			
			_contents = new ZvrGroup();
			_contents.top = 20;
			_contents.percentWidth = 100;
			_contents.autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			//_contents.childrenPadding.padding = 10;
			_container.addChild(_contents);
			_contents.includeInLayout = false;
			
			bar = new ToggleButtonMD();
			bar.percentWidth = 100;
			bar.autoSize = ZvrAutoSize.MANUAL;
			bar.height = 20;
			_container.addChild(bar);
			bar.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, barSelectdChange);
			bar.label.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0763);

		}
		
		public function fold():void 
		{
			bar.selected = false;
		}
		
		public function expand():void 
		{
			bar.selected = true;
		}
		
		private function barSelectdChange(e:ZvrSelectedEvent):void 
		{
			if (e.selected) _expand(); else _fold();
		}
		
		private function _expand():void 
		{
			_contents.includeInLayout = true;
		}
		
		private function _fold():void 
		{
			_contents.includeInLayout = false;
		}
		
	}

}