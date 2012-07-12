package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrItemRendererEvent extends Event 
	{
		
		public static const DATA_CHANGE:String = "dataChange";
		
		private var _itemRenderer:ZvrItemRenderer;
		
		public function ZvrItemRendererEvent(type:String, itemRenderer:ZvrItemRenderer, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_itemRenderer = itemRenderer;
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrItemRendererEvent(type, _itemRenderer, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("zvrItemRendererEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get itemRenderer():ZvrItemRenderer 
		{
			return _itemRenderer;
		}
		
	}
	
}