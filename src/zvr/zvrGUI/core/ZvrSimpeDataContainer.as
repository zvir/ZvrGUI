package zvr.zvrGUI.core 
{
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.relays.ZvrPanelRelay;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSimpeDataContainer extends ZvrPanelRelay
	{
		
		protected var _verticalScroll:ZvrScroll;
		protected var _horizontalScroll:ZvrScroll;
		
		private var _lastFirstItem:int;
		
		protected var _listItems:Vector.<IZvrSimpleDataItem> = new Vector.<IZvrSimpleDataItem>();
		
		private var _dataItemClass:Class;
		
		private var _scroll:ZvrScroll;
		private var _listItemsNum:int;
		
		public function ZvrSimpeDataContainer(dataItemClass:Class, verticalScroll:ZvrScroll, horizontalScroll:ZvrScroll, skin:Class = null, panelSkin:Class = null) 
		{
			super(skin || ZvrSkin);
			
			_dataItemClass = dataItemClass;
			
			_verticalScroll = verticalScroll;
			_horizontalScroll = horizontalScroll;
			
			_verticalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollRangeChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.MAX_CHANGED, scrollRangeChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.MIN_CHANGED, scrollRangeChanged);
			
			_horizontalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.MAX_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.MIN_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			
			_horizontalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			_horizontalScroll.addEventListener(ZvrScrollEvent.STATE_CHANGE, scrollStateChange);
			
			_contents = new ZvrDisabledContainer(panelSkin || ZvrSkin);
			
			_container.addChild(_contents);
			
			_contents.setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(_contents.layout).gap = 5;
			_scroll = _horizontalScroll;
			
			_verticalScroll.enabled = false;
			
			var item:IZvrSimpleDataItem = getNewListItem(0);
			
			_listItems.push(item);
			_contents.addChild(item as ZvrComponent);
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			
			//updateList(25);
		}
		
		override public function setLayout(layout:Class):void 
		{
			
			if (layout != ZvrHorizontalLayout && layout != ZvrVerticalLayout) return;
			
			_contents.setLayout(layout);
			
			if (layout == ZvrHorizontalLayout)
			{
				_scroll = _horizontalScroll;
				_verticalScroll.enabled = false;
			}
			else
			{
				_scroll = _verticalScroll;
				_horizontalScroll.enabled = false;
			}
			
			_contents.setContentsPosition(0, 0);
			
			//super.setLayout(layout);
			updateList(_listItemsNum);
			resized(null);
			
			
		}

		private function scrollRangeChanged(e:ZvrScrollEvent):void 
		{
			updateScrollsState();
		}
		
		private function scrollStateChange(e:ZvrScrollEvent):void 
		{
			e.scroll.includeInLayout = e.scroll.enabled;
		}
		
		public function updateScrollsState():void
		{
			if (_contents.layout is ZvrHorizontalLayout)
			{
				_horizontalScroll.enabled = _horizontalScroll.percentageRange < 1;
			}
			else
			{
				_verticalScroll.enabled = _verticalScroll.percentageRange < 1;
			}
		}
		
		private function mouseWheel(e:MouseEvent):void 
		{
			var delta:int = e.delta < 0 ? -1 : 1;
			_scroll.position -= delta * _scroll.step; 
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			_contents.width = bounds.width;
			_contents.height = bounds.height;
			
			if (_contents.layout is ZvrHorizontalLayout)
				_scroll.range = _contents.childrenAreaWidth;
			else
				_scroll.range = _contents.childrenAreaHeight;
			
			
			updateScrollsState();
			updateItemCount();
			updateList(_listItemsNum);
		}
		
		private function updateItemCount():void
		{
			var d:Number = itemDimension;
			var items:int = _listItems.length;
			var c:int 
			
			if (_contents.layout is ZvrHorizontalLayout)
				c =  Math.ceil((_contents.childrenAreaWidth) / d) + 1;
			else
				c =  Math.ceil((_contents.childrenAreaHeight) / d) + 1;
			
			for (var i:int = _listItems.length; i < c; i++) 
			{
				var it:IZvrSimpleDataItem = getNewListItem(i);
				_contents.addChild(it as ZvrComponent);
				_listItems.push(it);
			}
			
			while (_listItems.length > c+1)
			{
				var l:IZvrSimpleDataItem = _listItems.pop();
				_contents.removeChild(l as ZvrComponent);
				itemRemoved(l);
			}
			
			if (_listItems.length != items)
			{
				updateListContent();
			}
		}
		
		protected function getNewListItem(index:int):IZvrSimpleDataItem 
		{
			return new _dataItemClass();
		}
		
		protected function scrollPositionChanged(e:ZvrScrollEvent):void 
		{
			var d:Number = itemDimension;
			
			var offset:int = _scroll.position % d;
			var firstItem:int = Math.floor( _scroll.position / d);
			
			//trace(getScrollPosition());
			
			if (_contents.layout is ZvrHorizontalLayout)
				_contents.setContentsPosition(-offset, 0);
			else
				_contents.setContentsPosition(0, -offset);
			
			if (_lastFirstItem != firstItem)
			{
				_lastFirstItem = firstItem;
				updateListContent();
			}
		}
		
		protected function updateList(listItemsNum:int):void 
		{
			_listItemsNum = listItemsNum;
			
			var m:Boolean = _scroll.position == (_scroll.max - _scroll.range);
			
			_scroll.max = itemDimension * listItemsNum;
			
			updateListContent();
			
			if (m)
			{
				_scroll.position = (_scroll.max - _scroll.range);
			}
		}
		
		public function getScrollPosition():Number
		{
			/*var d:Number = itemDimension;
			var offset:int = _scroll.position % d;
			var firstItem:int = Math.floor( _scroll.position / d);
			*/
			return Math.floor( _scroll.position / itemDimension) + (_scroll.position % itemDimension)/itemDimension;
		}
		
		public function setScrollPosition(v:Number):void
		{
			
			_scroll.position = v * itemDimension;
			
			//return Math.floor( _scroll.position / itemDimension) + (_scroll.position % itemDimension)/itemDimension;
		}
		
		private function updateListContent():void
		{
			var p:IZvrSimpleDataItem;
			
			var firstItem:int = Math.floor( _scroll.position / itemDimension);
			
			for (var i:int = 0; i < _listItems.length; i++) 
			{
				p = _listItems[i];
				updateItem(p, i + firstItem);
			}
		}
		
		protected function itemRemoved(item:IZvrSimpleDataItem):void 
		{
			
		}
		
		protected function updateItem(item:IZvrSimpleDataItem, index:int):void
		{
			
		}
		
		private function get itemDimension():Number
		{
			var p:IZvrSimpleDataItem = _listItems[0];
			if (_contents.layout is ZvrHorizontalLayout) return p.width + ZvrHorizontalLayout(_contents.layout).gap;
			return p.height + ZvrVerticalLayout(_contents.layout).gap;
		}
		
	}

}