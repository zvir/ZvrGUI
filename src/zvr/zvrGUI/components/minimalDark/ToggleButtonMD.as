package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.core.IZvrSelectable;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.ToggleButtonMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "userInput", type = "zvr.zvrGUI.events.ZvrEvent")]
	[Event(name = "selectedChange",    type = "zvr.zvrGUI.events.ZvrSelectedEvent")]
	
	public class ToggleButtonMD extends ButtonMD implements IZvrSelectable
	{
		
		protected var _selectableBehavior:ZvrSelectable
		
		private var _enabledLabelText:String;
		private var _disabledLabelText:String;
		
		public function ToggleButtonMD() 
		{
			super(ToggleButtonMDSkin);
			_selectableBehavior = new ZvrSelectable();
			behaviors.addBehavior(_selectableBehavior);
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (_enabledLabelText && e.isNew(ZvrStates.SELECTED))
			{
				label.text = _enabledLabelText;
			}
			else if (_disabledLabelText && e.isRemoved(ZvrStates.SELECTED))
			{
				label.text = _disabledLabelText;
			}
		
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.SELECTED);
		}
		
		public function set selected(v:Boolean):void
		{
			if (v == selected) return;
			
			if (v)
				addState(ZvrStates.SELECTED);
			else
				removeState(ZvrStates.SELECTED);
		}
		
		public function get selected():Boolean
		{
			return checkState(ZvrStates.SELECTED);
		}
		
		public function get enabledLabelText():String 
		{
			return _enabledLabelText;
		}
		
		public function set enabledLabelText(value:String):void 
		{
			_enabledLabelText = value;
			if (selected)
			{
				label.text = _enabledLabelText;
			}
		}
		
		public function get disabledLabelText():String 
		{
			return _disabledLabelText;
		}
		
		public function set disabledLabelText(value:String):void 
		{
			_disabledLabelText = value;
			if (!selected)
			{
				label.text = _disabledLabelText;
			}
		}
		
		override public function addState(state:String):void 
		{
			var s:Boolean = checkState(ZvrStates.SELECTED);
			
			super.addState(state);
			
			if (state == ZvrStates.SELECTED && s != checkState(ZvrStates.SELECTED))
			{
				dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, this, !s));
			}
		}
		
		override public function removeState(state:String):void 
		{
			var s:Boolean = checkState(ZvrStates.SELECTED);
			
			super.removeState(state);
			
			if (state == ZvrStates.SELECTED && s != checkState(ZvrStates.SELECTED))
			{
				dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, this, !s));
			}
		}
		/*
		public function setSelectedWituotDispachingEvent(v:Boolean):void
		{
			if (v)
				super.addState(ZvrStates.SELECTED);
			else
				super.removeState(ZvrStates.SELECTED);
		}*/
	}

}