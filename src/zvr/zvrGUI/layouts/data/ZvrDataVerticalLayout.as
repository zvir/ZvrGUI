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
	 
	public class ZvrDataVerticalLayout extends ZvrDataLayout 
	{
		
		private var _contentBounds:Rectangle = new Rectangle();
		
		
		public function ZvrDataVerticalLayout(dataContainer:ZvrDataContainer, virtualContent:ZvrDataVirtualContent, itemsManager:ZvrDataItemsManager) 
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
			
			if (virtual.bounds)
			{
				virtual.itemRenderer.layoutPositionX = virtual.itemRenderer.layoutPositionX;
				virtual.itemRenderer.layoutPositionY = virtual.bounds.y - bounds.y;
			}
		}
		
		private function updateScroll(bounds:Rectangle):void
		{
			if (!_scroll) return
			
			/*
			_scroll.verticalScroll.removeEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.verticalScroll.removeEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
			*/
			
			_scroll.verticalScroll.min = 0;
			_scroll.verticalScroll.max = _contentBounds.height;
			_scroll.verticalScroll.range = bounds.height;
			

			
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
			
			var prevY:Number = 0;
			var height:Number
			var bounds:Rectangle = new Rectangle();
			var data:Object = dataProvider.getItemAt(0);
			var item:ZvrVirtualItemRenderer;
			
			_dataContainer.addChild(tester);
			
			
			if (!_variableItemsSize)
			{
				
				tester.data = data;
				bounds = tester.bounds.clone();
				height = tester.independentBounds.height;	
				_contentBounds = bounds.clone();
				
				item = _virtualContent.getElementAt(fromIndex -1);
				
				prevY = item ? item.bounds.bottom : 0;
				
				for (var i:int = fromIndex; i < dataProvider.length; i++) 
				{
					bounds = tester.bounds.clone();
					bounds.y = prevY;
					item = _virtualContent.getItem(i);
					item.bounds = bounds;
					item.data = dataProvider.getItemAt(i);
					prevY += height;
					_contentBounds = _contentBounds.union(bounds);
				}
				
			}
			else
			{
				
				_contentBounds = _virtualContent.getItem(0).bounds;
				
				if (!_contentBounds) _contentBounds = new Rectangle();
				
				var maxT:int = getTimer() + 80;

				
				prevY = fromIndex == 0 ? 0 : _virtualContent.getItem(fromIndex - 1).bounds.bottom;
				
				for (i = fromIndex; i < dataProvider.length; i++) 
				{
					data = dataProvider.getItemAt(i); 	
					tester.data = data;
					bounds = tester.bounds.clone();
					bounds.y = prevY;
					height = tester.independentBounds.height;	
					item = _virtualContent.getItem(i);
					item.bounds = bounds;
					item.data = dataProvider.getItemAt(i);
					prevY += height;
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
			_scroll.horizontalScrollPolicy = ZvrScrollPolicy.OFF;
			_scroll.verticalScroll.boundsSnap = true;
			_scroll.verticalScroll.snapPrority = ZvrScroll.MAX;
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollChange);
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollChange);
		}
		
		override protected function calculateFirstIndexInView(bounds:Rectangle):int
		{
			
			var items:Vector.<ZvrVirtualItemRenderer> = _virtualContent.items;
			
			if (items.length == 0) return 0;
			
			var item:ZvrVirtualItemRenderer;
			var top:Number = bounds.top;
			
			if (!_variableItemsSize)
			{
				return Math.floor(top / _itemsManager.itemTester.height);
			}
			else
			{
				var y:Number = 0;
			
				for (var i:int = 0; i < items.length && y <= top; i++) 
				{
					item = items[i];
					
					if (item.bounds)
					{
						y += item.bounds.height;
					}
					else
					{
						y += SIZE;
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
			var bottom:Number = bounds.bottom;
			var y:Number = _virtualContent.getElementAt(start).bounds.y;
			
			if (!_variableItemsSize)
			{
				return Math.floor(bottom / _itemsManager.itemTester.height);
			}
			else
			{
				for (var i:int = start; i < items.length && y < bottom; i++) 
				{
					item = items[i];
					
					if (item.bounds)
					{
						y += item.bounds.height;
					}
					else
					{
						y += SIZE;
					}
				}
				return i - 1;
			}
		}
		
		private function scrollChange(e:ZvrScrollEvent):void 
		{
			_dataContainer.setContentPosition(0, e.scroll.position);
		}
		
	}

}