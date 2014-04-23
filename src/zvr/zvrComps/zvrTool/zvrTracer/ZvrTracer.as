package zvr.zvrComps.zvrTool.zvrTracer 
{
	import flash.events.Event;
	//import mx.collections.ArrayCollection;

	import zvr.zvrGUI.components.minimalDark.DataContainerMD;
	import zvr.zvrGUI.components.minimalDark.ItemRendererMD;
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
	
	public class ZvrTracer extends WindowMD
	{
		private var _data:ZvrTracerData;
		//private var _dataProvider:ArrayCollection;
		private var _numStatus:LabelMD = new LabelMD();
		
		private var _messagesToAdd:Array = new Array();
		private var _statusText:String;
		
		public function ZvrTracer() 
		{
			_data = new ZvrTracerData();
			_data.itemRendererClass = ZvrTracerMessageIR;
			_data.percentWidth = 100;
			_data.percentHeight = 100;
			_data.setLayout(ZvrDataVerticalLayout);
			//_dataProvider = new ArrayCollection();
			//_data.getLayout().variableItemsSize = true;
			addChild(_data);
			_data.scroll = panel.scroller;
			//_data.dataProvider = _dataProvider;
			
			minWidth = 350;
			
			height = 180;
			width = 800;
			
			title.text = "Zvr Tracer v1.0"
			
			addStatusLabel(_numStatus);
			_numStatus.right = 0;
			_numStatus.text = "0";
			
			name = "Tracer";
			
			addEventListener(Event.EXIT_FRAME, exitFrame);
			
		}
		
		private function exitFrame(e:Event):void 
		{
			if (!visible) return;
			if (_messagesToAdd.length > 0)
			{
				
				for (var i:int = 0; i < _messagesToAdd.length; i++) 
				{
					/*_dataProvider.addItem(_messagesToAdd[i]);*/
				}
				/*_numStatus.text = String(_dataProvider.length);*/
				_messagesToAdd.length = 0;
			}
			
			if (_statusText != null)
			{
				status.text = _statusText;
				_statusText = null;
			}
			
		}
		
		public function startData(messages:Array):void
		{
			trace("wtf do with it ?");
		}
		
		public function addMessage(message:ZvrTraceMessage):void
		{
			
			_messagesToAdd.push(message);
			
			_statusText = "added: " + message.id + ", " + message.senderType +" (" + message.senderName + "), " + message.message + " " + message.stringValues;
			
			/*
			_dataProvider.addItem(message);
			status.text = "added: " + message.id + ", " + message.senderType +" (" + message.senderName + "), " + message.message + " " + message.stringValues;
			*/
		}
		
		public function itemUpdated(message:ZvrTraceMessage):void
		{
			_statusText = "update: " + message.id + ", " + message.senderType +" (" + message.senderName + "), " + message.message + " " + message.stringValues;
		}
		
	}

}