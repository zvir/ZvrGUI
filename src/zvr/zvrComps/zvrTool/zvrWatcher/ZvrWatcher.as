package zvr.zvrComps.zvrTool.zvrWatcher 
{
	//import mx.collections.ArrayCollection;
	import mx.collections.ArrayCollection;
	import zvr.zvrComps.zvrTool.zvrTracer.ZvrTracerData;
	import zvr.zvrComps.zvrTool.zvrWatcher.ZvrWatchItem;
	import zvr.zvrGUI.components.minimalDark.DataContainerMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.layouts.data.ZvrDataVerticalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrWatcher extends WindowMD
	{
		
		private var _data:DataContainerMD;
		private var _dataProvider:ArrayCollection;
		private var _numStatus:LabelMD = new LabelMD();
		
		public function ZvrWatcher() 
		{
			_data = new ZvrTracerData();
			_data.itemRendererClass = ZvrWatcherIR;
			_data.percentWidth = 100;
			_data.percentHeight = 100;
			_data.setLayout(ZvrDataVerticalLayout);
			_dataProvider = new ArrayCollection();
			
			addChild(_data);
			_data.scroll = panel.scroller;
			_data.dataProvider = _dataProvider;
			
			minWidth = 350;
			
			height = 180;
			width = 255;
			
			title.text = "Zvr Watcher v1.0"
			
			addStatusLabel(_numStatus);
			_numStatus.right = 0;
			_numStatus.text = "0";
			
			status.labelAutoSize = false;
			status.right = 30;
			status.x = 0;
			name = "Watcher";
			
		}
		
		public function updateWatch(w:ZvrWatchItem):void 
		{
			status.text = "update: " + w.sender + ", " + w.name + ":"+ String(w.value);
		}
		
		public function addWatch(w:ZvrWatchItem):void 
		{
			_dataProvider.addItem(w);
			status.text = "update: " + w.sender + ", " + w.name + ":"+ String(w.value);
			updateStatics();
		}
		
		public function deleteWatch(w:ZvrWatchItem):void
		{
			var i:int = _dataProvider.getItemIndex(w);
			if (i != -1) _dataProvider.removeItemAt(i);
			w.dispose();
			updateStatics();
		}
		
		public function addFirstWatch(watch:ZvrWatchItem):void 
		{
			_dataProvider.addItem(watch);
		}
		
		private function updateStatics():void
		{
			_numStatus.text = String(_dataProvider.length);
		}
		
	}

}