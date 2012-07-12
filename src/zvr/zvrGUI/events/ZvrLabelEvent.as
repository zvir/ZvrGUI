package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrLabelEvent extends Event 
	{
		
		public static const TEXT_CHANGE:String = "textChange";
		
		private var _component:ZvrLabel;
		private var _kind:String;
		private var _content:String;
		
		public function ZvrLabelEvent(type:String, component:ZvrLabel, kind:String = "", content:String = "", bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_component = component;
			_kind = kind == "" ? ZvrLabelChangeKind.REPLACE : kind;
			_content = content;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrLabelEvent(type, component, kind, content, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrLabelEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get component():ZvrLabel {	return _component;	}
		
		public function get kind():String {	return _kind; }
		
		public function get content():String {	return _content; }
		
	}
	
}