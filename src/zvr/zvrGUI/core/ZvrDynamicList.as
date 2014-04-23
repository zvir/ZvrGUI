package zvr.zvrGUI.core 
{
	import com.blackmoon.theFew.common.copy.NotificationsTxt;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.layouts.data.IZvrDynamicListLayout;
	import zvr.zvrGUI.layouts.data.ZvrDLVerticalLayout;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDynamicList extends ZvrGroup
	{
		
		private var _items:Vector.<IZvrDataRenderer> = new Vector.<IZvrDataRenderer>;
		private var _trash:Vector.<IZvrDataRenderer> = new Vector.<IZvrDataRenderer>;
		
		private var _itemClass:Class;
		
		private var _position:Number = 0;
		
		public function ZvrDynamicList(itemRenderer:Class) 
		{
			super();
			
			_itemClass = itemRenderer;
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addNewItem();
			
			setLayout(ZvrDLVerticalLayout);
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
		}
		
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		}
		
		
		protected function getNewItem():IZvrDataRenderer
		{
			return new _itemClass();
		}
		
		protected function updateItem(item:IZvrDataRenderer, index:int):Boolean
		{
			item.data = index;
			return true;
		}
		
		private function updateItemIndex(item:IZvrDataRenderer, index:int):Boolean 
		{
			if (item.index == index)
			{
				return true;
			}
			item.index = index;
			return updateItem(item, index);
		}
		
		protected function updateList():void
		{
			
			var pos:int = Math.floor(_position);
			var item:IZvrDataRenderer = _items[0];
			var area:Rectangle = contentRect;
			
			updateItem(item, pos);
			
			dlLayout.beginLayout(_position);
			
			var c:int;
			var b:Boolean;
			
			while (item)
			{	
				if (c > 100) break;
				
				b = updateItemIndex(item, pos);
				
				if (!b) break;
				
				b = dlLayout.itemLayout(item);
				
				c++;
				pos++;
				
				if (b)
				{
					item = getItem(c);
				}
				else
				{
					item = null;
				}
			}
			
			while (c < _items.length && _items.length > 1)
			{
				trashItem(_items[_items.length -1]);
			}
			
			dlLayout.endLayout();
			
			//trace(_items.length);
			
		}
		
		private function mouseWheel(e:MouseEvent):void 
		{	
			moveList(e.delta > 0 ? -10 : 10);
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			updateList();
		}
		
		private function addNewItem():IZvrDataRenderer 
		{
			var item:IZvrDataRenderer = _trash.pop();
			if (!item) item = getNewItem();
			_items.push(item);
			addChild(item as DisplayObject);
			return item;
		}
		
		private function getItem(i:int):IZvrDataRenderer 
		{	
			if (i > _items.length - 1)
			{
				return addNewItem();
			}
			
			return _items[i];
		}
		
		private function trashItem(item:IZvrDataRenderer):void 
		{
			var i:int = _items.indexOf(item);
			if (i != -1) _items.splice(i, 1);
			_trash.push(item);
			item.data = null;
			removeChild(item as DisplayObject);
		}
		
		private function enterFrame(e:Event):void 
		{
			moveList(1);
		}
		
		public function get position():Number 
		{
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			_position = value;
		}
		
		public function moveList(value:Number):void
		{
			_position += dlLayout.getPixelPositionDelta(value);
			updateList();
			trace(_items[0].bounds.top);
		}
		
		override public function setLayout(layout:Class):void 
		{
			try
			{
				super.setLayout(layout);
				IZvrDynamicListLayout(this.layout).items = _items;
			}
			catch (err:Error)
			{
				throw new Error("Layout is not IZvrDynamicListLayout");
			}
		}
		
		private function get dlLayout():IZvrDynamicListLayout
		{
			return layout as IZvrDynamicListLayout;
		}
		
	}

}