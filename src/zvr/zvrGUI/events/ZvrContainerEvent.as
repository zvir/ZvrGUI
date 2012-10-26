package zvr.zvrGUI.events 
{
	import flash.events.Event;

	import zvr.zvrGUI.core.IZvrComponent;

	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.utils.Counter;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrContainerEvent extends Event 
	{
		
		public static const ELEMENT_ADDED			:String = "elementAdded";
		public static const ELEMENT_REMOVED			:String = "elementRemoved";
		public static const CONTENT_SIZE_CHANGE		:String = "cotntentSizeChanged";
		public static const CONTENT_POSITION_CHANGE	:String = "contentPositionChanged";
		
		private var _cointainer:IZvrContainer;
		private var _element:IZvrComponent;
		
		public function ZvrContainerEvent(type:String, cointainer:IZvrContainer, element:IZvrComponent, bubbles:Boolean=false, cancelable:Boolean=false)
		{ 
			
			super(type, bubbles, cancelable);
			_element = element;
			_cointainer = cointainer;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrContainerEvent(type, _cointainer, element, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrContainerEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get cointainer():IZvrContainer
		{
			return _cointainer;
		}
		
		public function get element():IZvrComponent
		{
			return _element;
		}
		
	}
	
}