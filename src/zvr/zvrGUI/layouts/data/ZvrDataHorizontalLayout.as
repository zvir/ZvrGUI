package zvr.zvrGUI.layouts.data 
{
	import flash.events.Event;
	import flash.utils.getTimer;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import flash.geom.Rectangle;
	import mx.collections.ArrayCollection;
	import zvr.zvrGUI.core.ZvrDataContainer;
	import zvr.zvrGUI.core.ZvrDataVirtualContent;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrScrollPolicy;
	import zvr.zvrGUI.core.ZvrVirtualItemRenderer;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.managers.ZvrDataItemsManager;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	/**
	 * For now use olny with _variableItemsSize set to false
	 * 
	 * in else case it will crush yor aplication.
	 * 
	 */ 
	 
	public class ZvrDataHorizontalLayout extends ZvrDataLayout 
	{
		
		private var _contentBounds:Rectangle = new Rectangle();
		
		
		public function ZvrDataHorizontalLayout(dataContainer:ZvrDataContainer, virtualContent:ZvrDataVirtualContent, itemsManager:ZvrDataItemsManager) 
		{
			super(dataContainer, virtualContent, itemsManager);
		}
		
		override public function update(bounds:Rectangle):void 
		{
			super.update(bounds);
			if (_variableItemsSize) updateItemsBounds();
			updateScroll(bounds);
		}
		
		override protected function updateItem(virtual:ZvrVirtualItemRenderer, bounds:Rectangle):void
		{
			super.updateItem(virtual, bounds);
			virtual.itemRenderer.setLayoutPosition(virtual.bounds.x - bounds.x, virtual.itemRenderer.getLayoutPositionY());
		}
		
		private function updateScroll(bounds:Rectangle):void
		{
			if (!_scroll) return
			
			/*
			_scroll.verticalScroll.removeEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.verticalScroll.removeEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
			*/
			
			_scroll.horizontalScroll.min = 0;
			_scroll.horizontalScroll.max = _contentBounds.width;
			_scroll.horizontalScroll.range = bounds.width;
			

			
			/*
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
			*/
		}
		
		override public function updateItemsBounds(fromIndex:int = 0):void 
		{
			if (!_dataContainer.dataProvider) return;
			var dataProvider:ArrayCollection = _dataContainer.dataProvider;
			if (dataProvider.length == 0) return;
			if (fromIndex >= dataProvider.length) return;
			var tester:ZvrItemRenderer = _itemsManager.itemTester;
			
			var prevX:Number = 0;
			var width:Number
			var bounds:Rectangle = new Rectangle();
			var data:Object = dataProvider.getItemAt(0);
			var item:ZvrVirtualItemRenderer;
			
			_dataContainer.addChild(tester);
			
			
			if (!_variableItemsSize)
			{
				
				tester.data = data;
				bounds = tester.bounds.clone();
				width = tester.independentBounds.width;	
				_contentBounds = bounds.clone();
				
				item = _virtualContent.getElementAt(fromIndex -1);
				
				prevX = item ? item.bounds.right : 0;
				
				for (var i:int = fromIndex; i < dataProvider.length; i++) 
				{
					bounds = tester.bounds.clone();
					bounds.x = prevX;
					item = _virtualContent.getItem(i);
					item.bounds = bounds;
					item.data = dataProvider.getItemAt(i);
					prevX += width;
					_contentBounds = _contentBounds.union(bounds);
				}
				
			}
			else
			{
				
				_contentBounds = _virtualContent.getItem(0).bounds;
				
				if (!_contentBounds) _contentBounds = new Rectangle();
				
				var maxT:int = getTimer() + 80;

				
				prevX = fromIndex == 0 ? 0 : _virtualContent.getItem(fromIndex - 1).bounds.right;
				
				for (i = fromIndex; i < dataProvider.length; i++) 
				{
					data = dataProvider.getItemAt(i); 	
					tester.data = data;
					bounds = tester.bounds.clone();
					bounds.x = prevX;
					width = tester.independentBounds.width;	
					item = _virtualContent.getItem(i);
					item.bounds = bounds;
					item.data = dataProvider.getItemAt(i);
					prevX  += width;
					_contentBounds = _contentBounds.union(bounds);
					
					/*if (maxT < getTimer())
					{
						//tester.addEventListener(Event.ENTER_FRAME, updateItemsBoundsEnterFrame);
						_updateFromIndex = i;
						break;
					}*/
				}
			}
			
			_dataContainer.removeChild(tester);
		}
		
		private function updateItemsBoundsEnterFrame(e:Event):void 
		{
			_itemsManager.itemTester.removeEventListener(Event.ENTER_FRAME, updateItemsBoundsEnterFrame);
			updateItemsBounds(_updateFromIndex);
		}
		
		override public function set scroll(value:ZvrScroller):void 
		{
			super.scroll = value;
			_scroll.customScroll = true;
			_scroll.verticalScrollPolicy = ZvrScrollPolicy.OFF;
			_scroll.horizontalScroll.boundsSnap = true;
			_scroll.horizontalScroll.snapPrority = ZvrScroll.MAX;
			_scroll.horizontalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
		}
		
		override protected function calculateFirstIndexInView(bounds:Rectangle):int
		{
			
			var items:Vector.<ZvrVirtualItemRenderer> = _virtualContent.items;
			
			if (items.length == 0) return 0;
			
			var item:ZvrVirtualItemRenderer;
			var left:Number = bounds.left;
			
			if (!_variableItemsSize)
			{
				return Math.floor(left / _itemsManager.itemTester.width);
			}
			else
			{
				var x:Number = 0;
			
				for (var i:int = 0; i < items.length && x <= left; i++) 
				{
					item = items[i];
					
					if (item.bounds)
					{
						x += item.bounds.width;
					}
					else
					{
						x += SIZE;
					}
				}
				return i-1;
			}
		}
		
		override protected function calculateLastIndexInView(start:int, bounds:Rectangle):int 
		{
			var items:Vector.<ZvrVirtualItemRenderer> = _virtualContent.items;
			
			if (items.length == 0) return 0;
			
			var item:ZvrVirtualItemRenderer;
			var right:Number = bounds.right;
			var x:Number = _virtualContent.getElementAt(start).bounds.x;
			
			if (!_variableItemsSize)
			{
				return Math.floor(right / _itemsManager.itemTester.width);
			}
			else
			{
				for (var i:int = start; i < items.length && x < right; i++) 
				{
					item = items[i];
					
					if (item.bounds)
					{
						x += item.bounds.width;
					}
					else
					{
						x += SIZE;
					}
				}
				return i - 1;
			}
		}
		
		private function scrollChange(e:ZvrScrollEvent):void 
		{
			_dataContainer.setContentPosition(e.scroll.position, 0);
		}
		
	}

}