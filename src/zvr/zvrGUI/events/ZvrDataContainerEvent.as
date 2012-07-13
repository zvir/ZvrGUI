package zvr.zvrGUI.events 
{
	import flash.events.Event;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrDataContainerEvent extends Event 
	{
		
		public static const ITEM_RENDERER_CREATED	:String = "itemRendererCreated";
		public static const SELECTED_CHANGE			:String = "selectionChange";
		
		public static const ITEM_MOUSE_DOWN			:String = "item_mouseDown";
		public static const ITEM_MOUSE_UP			:String = "item_mouseUp";	
		public static const ITEM_MOUSE_CLICK		:String = "item_click";	
		public static const ITEM_MOUSE_MOVE			:String = "item_mouseMove";
		public static const ITEM_DOUBLE_CLICK 		:String = "item_doubleClick";
		public static const ITEM_MOUSE_OUT 			:String = "item_mouseOut";
		public static const ITEM_MOUSE_OVER 		:String = "item_mouseOver";
		public static const ITEM_MOUSE_WHEEL 		:String = "item_mouseWheel";
		public static const ITEM_ROLL_OUT 			:String = "item_rollOut";
		public static const ITEM_ROLL_OVER 			:String = "item_rollOver";
		
		
		private var _items:Array;
		private var _selectedIdexes:Vector.<int>;
		
		public function ZvrDataContainerEvent(type:String, items:Array, selectedIdexes:Vector.<int>, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			_selectedIdexes = selectedIdexes;
			_items = items;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrDataContainerEvent(type, _items, _selectedIdexes, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrDataContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get items():Array 
		{
			return _items;
		}
		
		public function get selectedIdexes():Vector.<int>
		{
			return _selectedIdexes;
		}
		
	}
	
}