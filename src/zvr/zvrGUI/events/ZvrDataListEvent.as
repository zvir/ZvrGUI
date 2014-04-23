package zvr.zvrGUI.events 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	import zvr.zvrGUI.core.data.ZvrDataList;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDataListEvent extends Event 
	{
		public var dataList:ZvrDataList;
		public var dataItem:IZvrDataRenderer;
		
		static public const ITEM_ADDED:String = "itemAdded";
		static public const ITEM_REMOVED:String = "itemRemoved";
		
		public function ZvrDataListEvent(type:String, dataList:ZvrDataList, dataItem:IZvrDataRenderer, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.dataList = dataList;
			this.dataItem = dataItem;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrDataListEvent(type, dataList, dataItem, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrDataListEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}