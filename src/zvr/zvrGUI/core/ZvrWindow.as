package zvr.zvrGUI.core
{
	import flash.display.DisplayObject;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.events.ZvrWindowEvent;
	import zvr.zvrGUI.layouts.ZvrLayout;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 *
	 */
	
	[Event(name="close",type="zvr.zvrGUI.events.ZvrWindowEvent")]
	[Event(name="minimalize",type="zvr.zvrGUI.events.ZvrWindowEvent")]
	[Event(name="restore",type="zvr.zvrGUI.events.ZvrWindowEvent")]
	[Event(name="maximilize",type="zvr.zvrGUI.events.ZvrWindowEvent")]
	
	public class ZvrWindow extends ZvrPanel
	{
		
		private var _panel:ZvrPanel;
		
		public function ZvrWindow(skin:Class)
		{
			super(skin);
			addState(ZvrStates.RESTORED);
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
		}
		
		override protected function defineStates():void
		{
			_states.define(ZvrStates.RESTORED);
			_states.define(ZvrStates.MINIMALIZED);
			_states.define(ZvrStates.MAXIMILIZED);
		}
		
		public function set panel(value:ZvrPanel):void
		{
			_panel = value;
			_contents = value;
		}
		
		public function get panel():ZvrPanel
		{
			return _panel;
		}
		
		final public function close():void
		{
			closed();
			_dispatchEvent(ZvrWindowEvent.CLOSE);
		}
		
		final public function restore():void
		{
			if (currentStates.indexOf(ZvrStates.RESTORED) != -1)
				return;
				
			manageStates(ZvrStates.RESTORED, [ZvrStates.MAXIMILIZED, ZvrStates.MINIMALIZED]);
		}
		
		final public function minimalize():void
		{
			if (currentStates.indexOf(ZvrStates.MINIMALIZED) != -1)
				return;
				
			manageStates(ZvrStates.MINIMALIZED, [ZvrStates.MAXIMILIZED, ZvrStates.RESTORED]);
		}
		
		final public function maximilize():void
		{
			if (currentStates.indexOf(ZvrStates.MAXIMILIZED) != -1)
				return;
				
			manageStates(ZvrStates.MAXIMILIZED, [ZvrStates.RESTORED, ZvrStates.MINIMALIZED]);
		}
		
		protected function closed():void
		{
			// to be overrided
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void
		{
			if (e.newStates.indexOf(ZvrStates.RESTORED) != -1 && (currentStates.indexOf(ZvrStates.MAXIMILIZED) != -1 && currentStates.indexOf(ZvrStates.MINIMALIZED) != -1))
				throw new Error("wrong states management in window");
			if (e.newStates.indexOf(ZvrStates.MAXIMILIZED) != -1 && (currentStates.indexOf(ZvrStates.RESTORED) != -1 && currentStates.indexOf(ZvrStates.MINIMALIZED) != -1))
				throw new Error("wrong states management in window");
			if (e.newStates.indexOf(ZvrStates.MINIMALIZED) != -1 && (currentStates.indexOf(ZvrStates.MAXIMILIZED) != -1 && currentStates.indexOf(ZvrStates.RESTORED) != -1))
				throw new Error("wrong states management in window");
			
			if (e.newStates.indexOf(ZvrStates.RESTORED) != -1)
			{
				_dispatchEvent(ZvrWindowEvent.RESTORE);
				return;
			}
			
			if (e.newStates.indexOf(ZvrStates.MAXIMILIZED) != -1)
			{
				_dispatchEvent(ZvrWindowEvent.MAXIMILIZE);
				return;
			}
			
			if (e.newStates.indexOf(ZvrStates.MINIMALIZED) != -1)
			{
				_dispatchEvent(ZvrWindowEvent.MINIMALIZE);
				return;
			}
		}
		
		private function _dispatchEvent(type:String):void
		{
			dispatchEvent(new ZvrWindowEvent(type, this));
		}
	
	}

}