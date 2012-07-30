package zvr.zvrComps.zvrTool.zvrTracer 
{
	import zvr.zvrComps.zvrTool.zvrTracer.ZvrTracerMessageEvent;
	import zvr.zvrGUI.behaviors.ZvrButtonBehavior;
	import zvr.zvrGUI.behaviors.ZvrClickableBehavior;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.ItemRendererMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrTools.ZvrTime;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTracerMessageIR extends ZvrItemRenderer
	{
		protected var _buttonBehavior:ZvrClickableBehavior;
		
		private var _message:ZvrTraceMessage;
		
		private var _id			:LabelMD = new LabelMD();
		private var _sender		:LabelMD = new LabelMD();
		private var _name		:LabelMD = new LabelMD();
		private var _text		:LabelMD = new LabelMD();
		private var _time		:LabelMD = new LabelMD();
		private var _timeDelta	:LabelMD = new LabelMD();
		private var _values		:LabelMD = new LabelMD();
		
		public function ZvrTracerMessageIR() 
		{
			super(ItemRendererMDSkin);
			tabEnabled = false;
			percentWidth = 100;
			minWidth = 400;
			minHeight = 31;
			autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			
			addChild(_id);
			addChild(_sender);
			addChild(_name);
			addChild(_text);
			addChild(_values);
			addChild(_time);
			addChild(_timeDelta);
			
			_id.left = 5;
			_sender.left = 35;
			_text.left = 200;
			_time.right = 0;
			
			_timeDelta.right = 0;
			_timeDelta.y = 12;
			
			_name.left = 35;
			_name.y = 12;
			
			_values.left = 200;
			_values.right = 50;
			_values.y = 12;
			_values.height = 15;
			_values.labelAutoSize = false;
			//_values.multiline = true;
			
			_states.add(ZvrStates.NORMAL);
			
			
			_id.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			_sender.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);			
			_text.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);		
			_time.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			_values.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1);	
			
			_timeDelta.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			_name.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			
			//_name.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			
			_id.delegateStates = this;
			_sender.delegateStates = this;		
			_name.delegateStates = this;	
			_text.delegateStates = this;		
			_time.delegateStates = this;	
			_timeDelta.delegateStates = this;
			_values.delegateStates = this;
			
			
			_buttonBehavior = new ZvrClickableBehavior();
			_behaviors.addBehavior(_buttonBehavior);
			
		
			_id.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);	
			_sender.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			_name.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.SELECTED);
			_text.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			_time.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			_timeDelta.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.SELECTED);
			_values.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c0, ZvrStates.SELECTED);
			trc(this, "tttttttttttttttt");
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
			
			if (_message) _message.removeEventListener(ZvrTracerMessageEvent.CHANGE, messageChange);
			
			_message = data as ZvrTraceMessage;
			
			_message.addEventListener(ZvrTracerMessageEvent.CHANGE, messageChange);
			
			updateMessage();
		}
		
		private function messageChange(e:ZvrTracerMessageEvent):void 
		{
			updateMessage();
		}
		
		
		private function updateMessage():void
		{
			_id.text 		= String(_message.id);
			_sender.text 	= _message.senderType;
			_name.text		= _message.senderName ? _message.senderName : "";
			_text.text 		= _message.message;
			
			var t:Object = ZvrTime.milisecontsToTime(_message.time);
			
			_time.text 		= String(t.minutes+":"+t.seconds+"."+t.miliseconds);
			_timeDelta.text = String(_message.timeDelta);
			_values.text = _message.stringValues;
			
		}
		
		
	}

}