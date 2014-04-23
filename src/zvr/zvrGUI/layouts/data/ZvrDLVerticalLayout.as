package zvr.zvrGUI.layouts.data 
{
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.layouts.ZvrLayout;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDLVerticalLayout extends ZvrLayout implements IZvrDynamicListLayout
	{
		private var _startPosition:Number;
		private var _currentIndex:Number;
		private var _lastLocation:Number;
		
		public var gap:int = 10;
		
		private var _items:Vector.<IZvrDataRenderer> = new Vector.<IZvrDataRenderer>;
		
		public function ZvrDLVerticalLayout(cointainer:IZvrContainer, computeContentBounds:Function, registration:Function, contentAreaIndependent:Function) 
		{
			super(cointainer, computeContentBounds, registration, contentAreaIndependent);
		}
		
		/* INTERFACE zvr.zvrGUI.layouts.data.IZvrDynamicListLayout */
		
		public function isLast(item:IZvrDataRenderer):Boolean 
		{
			var contentRect:Rectangle = _container.contentRect;
			
			contentRect.x = 0;
			contentRect.y = 0;
			contentRect.width = _container.childrenAreaWidth;
			contentRect.height = _container.childrenAreaHeight;
			
			//trace(contentRect.bottom, item.bounds.top, item.bounds.bottom);
			
			return contentRect.intersects(item.bounds);
		}
		
		public function setItem():void
		{
			
		}
		
		public function beginLayout(startPosition:Number):void 
		{
			_startPosition = startPosition;
			_currentIndex = 0;
		}
		
		public function itemLayout(item:IZvrDataRenderer):Boolean 
		{
			if (isNaN(_lastLocation))
			{
				item.y = - item.bounds.height * (_startPosition - Math.floor(_startPosition));
			}
			else
			{
				item.y = _lastLocation + gap;
			}
			
			_lastLocation = item.bounds.bottom;
			
			return _lastLocation < _container.childrenAreaHeight;
			
		}
		
		public function endLayout():void 
		{
			_startPosition = NaN;
			_lastLocation = NaN;
		}
		
		public function getPixelPositionDelta(delta:Number):Number
		{
			
			if (_items[0].bounds.top >= 0 && delta < 0) return 0;
			
			var direction:Number = delta < 0 ? -1 : 1;
			
			delta = Math.abs(delta);
			
			var s:Number = delta / _items[0].bounds.height;
			
			var i:int = 0;
			
			trace(s);
			
			while (s > 1 && i < _items.length-1 && i > 0)
			{
				delta += _items[i].bounds.height * -direction;
				
				i += direction;
				
				s = (delta / _items[i].bounds.height);
			}
			
			s += i;
			
			trace(i, s);
			
			if (i >= _items.length)
			{
				s = _items.length;
			}
			
			return s * direction;
			
		}
		
		public function get items():Vector.<IZvrDataRenderer> 
		{
			return _items;
		}
		
		public function set items(value:Vector.<IZvrDataRenderer>):void 
		{
			_items = value;
		}
		
	}

}