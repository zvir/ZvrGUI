package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrDragScrolable;
	import zvr.zvrGUI.core.IZvrSimpleDataItem;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrSimpeDataContainer;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.ScrollerPanelMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class SimpleDataScroller extends ZvrSimpeDataContainer
	{
		
		private var _dragScrolable:ZvrDragScrolable;
		private var _disableBehavior:ZvrDragScrolable;
		
		public function SimpleDataScroller(dataItemClass:Class) 
		{
			var verticalScroll:VScrollMD = new VScrollMD();
			var horizontalScroll:HScrollMD  = new HScrollMD();
			
			verticalScroll.right = 0;
			horizontalScroll.bottom = 0;
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
			verticalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			horizontalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			
			super(dataItemClass, verticalScroll, horizontalScroll, null, ScrollerPanelMDSkin);
			
			/*_contents.top = 0;
			_contents.left = 0;
			_contents.bottom = 1;
			_contents.right = 1;*/
			
			//setLayout(ZvrVerticalLayout);
			
			/*_contents.addEventListener(ZvrComponentEvent.RESIZE, contentsResized);
			
			_dragScrolable = new ZvrDragScrolable();
			behaviors.addBehavior(_dragScrolable);
			*/
			_container.addChild(_verticalScroll);
			_container.addChild(_horizontalScroll);
			
			
			width = 100;
			height = 50;
			
			updateList(25);
			
		}
		
		private function scrollStateChange(e:ZvrScrollEvent):void 
		{
			e.scroll.includeInLayout = e.scroll.enabled;
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			_verticalScroll.height = _bounds.height;
			_horizontalScroll.width = _bounds.width;
		}
		
		override protected function updateItem(item:IZvrSimpleDataItem, index:int):void 
		{
			item.data = index;
		}
		
	}

}