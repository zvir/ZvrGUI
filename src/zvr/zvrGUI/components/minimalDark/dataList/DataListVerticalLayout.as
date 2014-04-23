package zvr.zvrGUI.components.minimalDark.dataList 
{
	import zvr.zvrGUI.components.minimalDark.DataListMD;
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	import zvr.zvrGUI.core.data.ZvrDataLayout;
	import zvr.zvrGUI.core.data.ZvrDataList;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class DataListVerticalLayout extends ZvrDataLayout
	{
		private var _listMD:DataListMD;
		private var _lastFirstItem:int;
		
		public function DataListVerticalLayout(list:DataListMD, listItems:Vector.<IZvrDataRenderer>) 
		{
			super(list, listItems);
			
			_listMD = list;
			
			_listMD.verticalScroll.max = 100;
			_listMD.verticalScroll.range = 10;
			
			_listMD.verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, positionChanged);
		}
		
		private function positionChanged(e:ZvrScrollEvent):void 
		{
			
			var p:IZvrDataRenderer = _listItems[0];
			
			var d:Number = p.height;
			
			var offset:int = _listMD.verticalScroll.position % (d);
			var firstItem:int = getFirstItem();
			
			_listMD.setContentsPosition(0, -offset);
			
			if (_lastFirstItem != firstItem)
			{
				_lastFirstItem = firstItem;
				_list.updateListContent(firstItem);
			}
			
		}
		
		override public function getItemsCount(areaWidth:Number, areaHeight:Number):int 
		{
			
			var h:Number = _listItems[0].height
			var c:int = Math.ceil(areaHeight / h) + 1;
			
			return c;
		}
		
		override public function update(areaWidth:Number, areaHeight:Number, dataLength:int):void 
		{
			_listMD.verticalScroll.range = areaHeight;
			_listMD.verticalScroll.max = _listItems[0].height * dataLength;
			
			_listMD.verticalScroll.enabled = _listMD.verticalScroll.range < _listMD.verticalScroll.max;
			
			for (var i:int = 0; i < _listItems.length; i++) 
			{
				_listItems[i].y = _listItems[i].height * i;
			}
			
			
			_list.updateListContent(getFirstItem());
			
		}
		
		override public function getFirstItem():int 
		{
			return Math.floor( _listMD.verticalScroll.position / _listItems[0].height);
		}
		
	}

}