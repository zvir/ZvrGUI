package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.ItemRendererMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.utils.Counter;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ItemRendererMD extends ZvrItemRenderer 
	{
		
		private var _label:LabelMD = new LabelMD();
		
		public function ItemRendererMD() 
		{
			super(ItemRendererMDSkin);
			percentWidth = 100;
			minHeight = 15;
			autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			
			addChild(_label);
			_label.right = 5;
			_label.left = 5;
			_label.delegateStates = this;
			_label.autoSize = ZvrAutoSize.CONTENT;
			_label.multiline = true;
			
			tabEnabled = false;
			
			//bottom = 5;
		}
		
		override public function set data(value:Object):void 
		{
			super.data = value;
			//trace("setData:", Counter.count("itemRenderer", "setData"));
			_label.text = String(value);
		}
		
	}

}