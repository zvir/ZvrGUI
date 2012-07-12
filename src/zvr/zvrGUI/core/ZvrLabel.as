package zvr.zvrGUI.core 
{
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www		www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name = "textChange", 		type = "zvr.zvrGUI.events.ZvrLabelEvent")]
	 
	public class ZvrLabel extends ZvrComponent
	{
		
		protected var _text:String = "";
		
		public function ZvrLabel(skin:Class) 
		{
			super(skin);
		}
		
		public function get text():String 
		{
			return _text;
		}
		
		public function set text(value:String):void 
		{
			if (_text == value) return;
			enterMassChangeMode();
			_text = value;
			_dispatchEvent(ZvrLabelEvent.TEXT_CHANGE, ZvrLabelChangeKind.REPLACE, value);
			exitMassChangeMode();
		}
		
		public function appendText(value:String):void
		{
			_text = _text + value;
			_dispatchEvent(ZvrLabelEvent.TEXT_CHANGE, ZvrLabelChangeKind.APPEND, value);
		}
		
		protected function _dispatchEvent(type:String, kind:String, content:String = ""):void
		{
			dispatchEvent(new ZvrLabelEvent(type, this, kind, content));
		}
		
	}

}