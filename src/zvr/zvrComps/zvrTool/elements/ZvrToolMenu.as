package zvr.zvrComps.zvrTool.elements 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import zvr.zvrComps.zvrTool.ZvrTool;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextureFillsMD;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToolMenu extends ZvrGroup
	{
		private var _tool:ZvrTool;
		
		public var closeBt		:ButtonMD;
		public var hide			:ButtonMD;
		public var hideAll		:ButtonMD;
		public var watcher		:ZvrToolButton;
		public var stats		:ZvrToolButton;
		public var tracer		:ZvrToolButton;
		public var tracy		:ZvrToolButton;
		public var toggler		:ZvrToolButton;
		public var sounder		:ZvrToolButton;
		
		
		public function ZvrToolMenu(tool:ZvrTool) 
		{
			_tool = tool;
			
			setLayout(ZvrHorizontalLayout);
			
			ZvrHorizontalLayout(layout).gap = 1;
			
			hide = new ButtonMD();	
			hideAll = new ButtonMD();	
			watcher = new ZvrToolButton(_tool.watcher, _tool);
			stats = new ZvrToolButton(_tool.statsChart, _tool);	
			tracer = new ZvrToolButton(_tool.tracer, _tool);	
			tracy = new ZvrToolButton(_tool.tracy, _tool);		
			toggler = new ZvrToolButton(_tool.toggler, _tool);		
			sounder = new ZvrToolButton(_tool.sounder, _tool);		
			closeBt = new ButtonMD();
			
			closeBt.contentPadding.padding = 5;
			hide.contentPadding.padding = 5;			
			hideAll.contentPadding.padding = 5;			
			watcher.contentPadding.padding = 5;	
			stats.contentPadding.padding = 5;	
			tracer.contentPadding.padding = 5;	
			tracy.contentPadding.padding = 5;	
			toggler.contentPadding.padding = 5;	
			sounder.contentPadding.padding = 5;	
			
			hide.label.text = ">";
			hideAll.label.text = "Hide All";
			closeBt.icon.bitmap = TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_16);
			watcher.label.text = "Watcher";
			stats.label.text = "Chats";
			tracer.label.text = "Tracer";
			tracy.label.text = "Tracy";	
			toggler.label.text = "Toggler";	
			sounder.label.text = "Sounder";	
			
			hideAll.exlcudeIn = "hided";
			watcher.exlcudeIn = "hided";
			stats.exlcudeIn = "hided";
			tracer.exlcudeIn = "hided";	
			tracy.exlcudeIn = "hided";
			toggler.exlcudeIn = "hided";
			sounder.exlcudeIn = "hided";
			
			
			
			addChild(hide);
			addChild(hideAll);
			addChild(watcher);
			addChild(stats);
			addChild(tracer);
			addChild(tracy);
			addChild(toggler);
			addChild(sounder);
			addChild(closeBt);
			
			watcher.selected = true;
			stats.selected = true;
			tracer.selected = true;
			tracy.selected = true;
			toggler.selected = true;
			sounder.selected = true;
			
			
			if (Multitouch.supportsTouchEvents)
			{
				closeBt.addEventListener(TouchEvent.TOUCH_TAP, closeClick);
				hideAll.addEventListener(TouchEvent.TOUCH_TAP, hideAllClick);
				hide.addEventListener(TouchEvent.TOUCH_TAP, hideClick);
			}
			else
			{
				closeBt.addEventListener(MouseEvent.CLICK, closeClick);
				hideAll.addEventListener(MouseEvent.CLICK, hideAllClick);
				hide.addEventListener(MouseEvent.CLICK, hideClick);
			}
			
			
			
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
		}
		
		private function hideAllClick(e:Event):void 
		{
			_tool.watcher.close();
			_tool.statsChart.close();
			_tool.tracer.close();
			_tool.tracy.close();
			_tool.toggler.close();
			_tool.sounder.close();
		}
		
		private function closeClick(e:Event):void 
		{
			_tool.toggleVisible();
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew("hided"))
			{
				hide.label.text = "<";
			}
			else
			{
				hide.label.text = ">";
			}
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define("hided");
		}
		
		private function hideClick(e:Event):void 
		{
			if (checkState("hided"))
			{
				removeState("hided");
			}
			else
			{
				addState("hided");
			}
		}
		
	}

}