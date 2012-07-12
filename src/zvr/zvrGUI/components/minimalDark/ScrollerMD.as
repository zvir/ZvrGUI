package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import zvr.zvrGUI.behaviors.ZvrDragScrolable;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrScrollPolicy;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.ScrollerPanelMDSkin;
	import zvr.zvrGUI.utils.Counter;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ScrollerMD extends ZvrScroller
	{

		private var _dragScrolable:ZvrDragScrolable;
		private var _disableBehavior:ZvrDragScrolable;
		
		public function ScrollerMD() 
		{
			var verticalScroll:VScrollMD = new VScrollMD();
			var horozontalScroll:HScrollMD  = new HScrollMD();
			
			verticalScroll.right = 0;
			horozontalScroll.bottom = 0;
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
			super(verticalScroll, horozontalScroll, null, ScrollerPanelMDSkin);
			
			_contents.bottom = 1;
			_contents.right = 1;
			
			_verticalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			_horizontalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			
			_contents.addEventListener(ZvrComponentEvent.RESIZE, contentsResized);
			
			_dragScrolable = new ZvrDragScrolable();
			behaviors.addBehavior(_dragScrolable);
			
			width = 100;
			height = 50;
			
		}
		
		
		private function scrollStateChange(e:ZvrScrollEvent):void 
		{	
			e.scroll.includeInLayout = e.scroll.enabled;
			resized(null);
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			if (_contents.autoSize != ZvrAutoSize.CONTENT) 
			{
				_contents.width = _bounds.width - _verticalScroll.independentBounds.width - 2;
				// _contents.height =  _bounds.height - _horizontalScroll.independentBounds.height - (_horizontalScroll.present ? 2 : 0);
				_contents.height =  _bounds.height - 13;
			}	
			_verticalScroll.height = _bounds.height - 10;
			_horizontalScroll.width = _bounds.width - 10;
		}
		
		private function contentsResized(e:ZvrComponentEvent):void 
		{	
			if (_contents.autoSize != ZvrAutoSize.CONTENT)  return;
			width = _contents.width + _verticalScroll.independentBounds.width + 2;
			height = _contents.height + 13;
		}
		
		override protected function prepareForCustomScroll():void 
		{
			_contents.autoSize = ZvrAutoSize.MANUAL;
			setContentsPosition(0, 0);
			resized(null);
		}
		
	}

}