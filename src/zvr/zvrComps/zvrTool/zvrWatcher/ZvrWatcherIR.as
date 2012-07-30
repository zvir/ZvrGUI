package zvr.zvrComps.zvrTool.zvrWatcher 
{
	import avmplus.extendsXml;
	import flash.text.TextFormatAlign;
	import utils.type.getClass;
	import utils.type.getName;
	import zvr.zvrGUI.behaviors.ZvrClickableBehavior;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.ItemRendererMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrTools.ZvrTime;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrWatcherIR extends ZvrItemRenderer
	{
		protected var _buttonBehavior:ZvrClickableBehavior;
		
		private var _watch:ZvrWatchItem;
		
		private var _sender				:LabelMD = new LabelMD();
		private var _valueName			:LabelMD = new LabelMD();
		private var _value				:LabelMD = new LabelMD();
		
		
		public function ZvrWatcherIR() 
		{
			
			super(ItemRendererMDSkin);
			
			tabEnabled = false;
			percentWidth = 100;
			minWidth = 250;
			minHeight = 15;
			height = 15;
			
			addChild(_sender);
			addChild(_value);
			addChild(_valueName);
			
			_sender.left = 0;
			
			_valueName.right = 180;
			//_valueName.align = TextFormatAlign.RIGHT;
			//_valueName.width = 45;
			
			
			_value.width = 140;
			_value.right = 0;
			_value.minWidth = 170;
			_value.height = 15;
			
			_states.add(ZvrStates.NORMAL);
			
			
			_value.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0763);
			
			_sender.delegateStates = this;
			_valueName.delegateStates = this;
			_value.delegateStates = this;
			
			_value.labelAutoSize = false;
			//_valueName.autoSize = false;
				
			_buttonBehavior = new ZvrClickableBehavior();
			_behaviors.addBehavior(_buttonBehavior);
			
			
			_sender.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);	
			_value.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			_valueName.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			
			
			_sender.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.SELECTED);	
			_value.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			_valueName.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.DOWN);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
		}
		
		override public function set data(value:Object):void 
		{
			super.data = value;
			
			if (_watch) _watch.removeEventListener(ZvrWatcherItemEvent.CHANGE, messageChange);
			
			_watch = data as ZvrWatchItem;
			
			_watch.addEventListener(ZvrWatcherItemEvent.CHANGE, messageChange);
			
			updateMessage();
		}
		
		private function messageChange(e:ZvrWatcherItemEvent):void 
		{
			updateMessage();
		}
		
		
		private function updateMessage():void
		{
			var s:String;
			
			if (_watch.sender is String)
			{
				s = _watch.sender as String;
			}
			else
			{  
				s = getName(getClass(_watch.sender)) + (_watch.sender.hasOwnProperty("name") ? " (" + _watch.sender.name + ")" : "");;
			}
			
			_sender.text		= s;
			_valueName.text		= _watch.name;
			_value.text 		= String(_watch.value);
			
		}
		
	}

}