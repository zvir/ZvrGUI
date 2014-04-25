package clv.gui.components.dataList 
{
	import clv.gui.core.Component;
	import clv.gui.g2d.components.GroupG2D;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ListItemVertical
	{
		private var _next:IDataListItem;
		private var _prev:IDataListItem;
		private var _component:Component;
		
		public var gap:Number = 0;
		
		public function ListItemVertical(component:Component) 
		{
			_component = component;
		}
		
		public function setItemAfterPosition(listPostition:Number, itemPosition:int):Boolean
		{
			if (prev) 
			{
				_component.y = prev.independentBounds.B + gap;
			}
			else 
			{
				_component.y = -(_component.height + gap) * (listPostition - Math.floor(listPostition));
			}
			
			return _component.independentBounds.B + gap < _component.container.contentAreaHeight;
		}
		
		public function setItemBeforePosition(position:Number, itemPosition:int):Boolean 
		{
			
			if (next) 
			{
				_component.y = next.y - _component.independentBounds.h - gap;
			}
			
			return _component.independentBounds.T > -_component.container.contentAreaHeight;
		}
		
		public function getPercentScrol(v:Number):Number 
		{
			var p:Number = v / (_component.independentBounds.h + gap);
			
			if (Math.abs(p) > 1)
			{
				if (p > 0 &&  next) p = next.getPercentScrol(v - (_component.independentBounds.h + gap)) + 1;
				if (p < 0 &&  prev) 
				{
					p = prev.getPercentScrol(v + (_component.independentBounds.h + gap)) - 1;
				}
			}
			
			return p;
		}
		
		public function getEnd():Number 
		{
			return _component.container.contentAreaHeight - _component.independentBounds.B - gap;
		}
		
		public function get next():IDataListItem 
		{
			return _next;
		}
		
		public function set next(value:IDataListItem):void 
		{
			_next = value;
		}
		
		public function get prev():IDataListItem 
		{
			return _prev;
		}
		
		public function set prev(value:IDataListItem):void 
		{
			_prev = value;
		}
		
	}

}