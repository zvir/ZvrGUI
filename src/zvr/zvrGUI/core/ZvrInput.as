package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.events.ZvrLabelEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name = "textChange", 		type = "zvr.zvrGUI.events.ZvrLabelEvent")]
	 
	public class ZvrInput extends ZvrComponent
	{
		
		private var _text:String
		
		public function ZvrInput(skin:Class) 
		{
			super(skin);
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.DOWN);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
			_states.define(ZvrStates.FOCUSED);
			_states.define(ZvrStates.HILIGHT);
			_states.add(ZvrStates.NORMAL);
			
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			_text = value;
			_dispatchEvent(ZvrLabelEvent.TEXT_CHANGE);
		}
		
		private function _dispatchEvent(type:String):void
		{
			//dispatchEvent(new ZvrLabelEvent(type, this));
		}
	}

}