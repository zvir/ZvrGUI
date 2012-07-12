package zvr.zvrGUI.events 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrStyleChangeEvent extends Event 
	{
		
		public static const CHANGE:String = "styleChange";
		
		private var _styleName:String;
		private var _value:*;
		
		public function ZvrStyleChangeEvent(type:String, styleName:String, value:*, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_value = value;
			_styleName = styleName;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrStyleChangeEvent(type, styleName, value, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrStyleChange", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get styleName():String 	{ return _styleName; }
		
		public function get value():* {	return _value; }
		
	}
	
}