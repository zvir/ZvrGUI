package zvr.zvrGUI.core.custom 
{
	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDataListBase
	{
		
		private var _looper:IZvrDataListItem;
		protected var _first:IZvrDataListItem;
		private var _trash:IZvrDataListItem;
		
		
		
		private var _position:Number = 0;
		
		private var _max:int = int.MAX_VALUE;
		
		protected var _container:IZvrContainer;
		
		private var _endPosition:Number;
		
		public function ZvrDataListBase(container:IZvrContainer) 
		{
			_container = container;
			_container.addEventListener(ZvrComponentEvent.RESIZE, resized);
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			update();
		}
		
		public function moveBy(v:Number):void
		{
			var value:Number = pixelsToPosition(v);
			position = _position + value;
		}
		
		protected function pixelsToPosition(v:Number):Number
		{
			return  (!_first) ?  0 : _first.getPercentScrol(v);
		}
		
		public function update():void
		{
			
			var next:Boolean = true;
			var item:IZvrDataListItem;
			var n:IZvrDataListItem;
			var i:int
			
			_endPosition = NaN;
			
			i = Math.floor(_position);
			
			if (!_first) _first = createNewItem();
			
			item = _first;
			
			while(next)
			{
				updateItem(item, i);
				
				next = item.setItemAfterPosition(_position, i);
				
				if (i == _max) 
				{
					_endPosition = _position - pixelsToPosition(item.getEnd());
				}
				
				if (next) item = getNextItem(item); 
				
				i++;
			}
			
			item = item.next;
			if (item && item.prev) item.prev.next = null;
			
			while (item)
			{
				n = item.next;
				if (item.prev) item.prev.next = item.next;
				if (item.next) item.next.prev = item.prev;
				
				item.prev = null;
				if (_trash) _trash.prev = item;
				item.next = _trash;
				_trash = item;
				_container.removeComponent(item);
				item = n;
			}
			
			if (!_looper)
			{
				_looper = createNewItem();
				_looper.next = _first;
			}
			
			next = true;
			i = Math.floor(_position - 1);
			item = _looper;
			
			while(next)
			{
				updateItem(item, i);
				
				next = item.setItemBeforePosition(_position, i);
				
				if (next) item = getPrevItem(item); 
				
				i--;
			}
			
			item = item.prev;
			if (item && item.next) item.next.prev = null;
			
			while (item)
			{
				n = item.prev;
				
				if (item.prev) item.prev.next = item.next;
				if (item.next) item.next.prev = item.prev;
				
				item.prev = null;
				
				if (_trash) _trash.prev = item;
				item.next = _trash;
				_trash = item;
				_container.removeComponent(item);
				
				item = n;
			}
			
		}
		
		private function getNextItem(item:IZvrDataListItem):IZvrDataListItem 
		{
			var i:IZvrDataListItem;
			
			if (!item.next)
			{
				if (_trash)
				{
					i = _trash;
					_trash = i.next;
					if (_trash) _trash.prev = null;
					i.next = null;
					item.next = i;
					i.prev = item;
					_container.addComponent(i);
					return i;
				}
				
				i = createNewItem();
				i.prev = item;
				item.next = i;
				
				return i;
			}
			
			return item.next;
		}
		
		public function getPrevItem(item:IZvrDataListItem):IZvrDataListItem 
		{
			var i:IZvrDataListItem;
			
			if (!item.prev)
			{
				if (_trash)
				{
					i = _trash;
					_trash = i.next;
					if (_trash) _trash.prev = null;
					i.next = item;
					item.prev = i;
					i.prev = null;
					_container.addComponent(i);
					return i;
				}
				
				i = createNewItem();
				i.next = item;
				item.prev = i;
				
				return i;
				
			}
			
			return item.prev;
		}
		
		private function createNewItem():IZvrDataListItem 
		{
			var i:IZvrDataListItem = getNewItem();
			_container.addComponent(i);
			return i;
		}
		
		protected function getNewItem():IZvrDataListItem
		{
			throw new Error("getNewItem() must be override");
			return null;
		}
		
		protected function updateItem(item:IZvrDataListItem, index:int):void
		{
			throw new Error("updateItem() must be override");
		}
		
		public function get position():Number 
		{
			return _position;
		}
		
		public function set position(value:Number):void 
		{
			if (_position == value) return;
			
			_position = value;
			
			update();
		}
		
		public function get max():int 
		{
			return _max;
		}
		
		public function set max(value:int):void 
		{
			_max = value;
		}
		
		public function get endPosition():Number 
		{
			return _endPosition;
		}
		
	}

}