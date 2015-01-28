package zvr.zvrGUI.components.minimalDark 
{
	import org.osflash.signals.Signal;
	import zvr.zvrGUI.core.relays.ZvrSwitchGroup;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SwitchMD extends ZvrSwitchGroup
	{
		private var _value:Boolean;
		
		public var on:ToggleButtonMD;
		public var off:ToggleButtonMD;
		
		public var onSelectedChange:Signal = new Signal(Boolean);
		
		public function SwitchMD() 
		{
			super();
			
			autoSize = ZvrAutoSize.CONTENT;
			
			setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(layout).gap = 0;
			
			on = new ToggleButtonMD();
			off = new ToggleButtonMD();
			
			on.label.text = "ON";
			off.label.text = "OFF";
			
			addChild(on);
			addChild(off);
			
			
			addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selectChange);
			
		}
		
		private function selectChange(e:ZvrSelectedEvent):void 
		{
			if (!e.selected) return;
			_value = (e.component == on);
			
			onSelectedChange.dispatch(_value);
			
		}
		
		public function get value():Boolean 
		{
			return _value;
		}
		
		public function set value(value:Boolean):void 
		{
			removeEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selectChange);
			_value = value;
			
			on.selected = _value;
			
			addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, selectChange);
		}
		
	}

}