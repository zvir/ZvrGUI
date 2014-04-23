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
	public class DataListHorizontallGridLayout extends ZvrDataLayout
	{
		private var _listMD:DataListMD;
		private var _lastFirstItem:int;
		private var _areaWidth:Number;
		private var _areaHeight:Number;
		
		public function DataListHorizontallGridLayout(list:DataListMD, listItems:Vector.<IZvrDataRenderer>) 
		{
			super(list, listItems);
			
			_listMD = list;
			
			_listMD.horizontalScroll.max = 100;
			_listMD.horizontalScroll.range = 10;
			
			_listMD.horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, positionChanged);
		}
		
		private function positionChanged(e:ZvrScrollEvent):void 
		{
			var p:IZvrDataRenderer = _listItems[0];
			
			var d:Number = p.width;
			
			var offset:int = _listMD.horizontalScroll.position % (d);
			var firstItem:int = getFirstItem();
			
			_listMD.setContentsPosition(-offset, 0);
			
			if (_lastFirstItem != firstItem)
			{
				_lastFirstItem = firstItem;
				_list.updateListContent(firstItem);
			}
			
		}
		
		override public function getItemsCount(areaWidth:Number, areaHeight:Number):int 
		{
			var w:int = Math.ceil(areaWidth / _listItems[0].width) + 1;
			var h:int = Math.floor(areaHeight / _listItems[0].height);
			
			/*var h:Number = _listItems[0].width
			var c:int = Math.ceil(areaWidth / h) + 1;*/
			
			return w * h;
		}
		
		override public function update(areaWidth:Number, areaHeight:Number, dataLength:int):void 
		{
			_areaHeight = areaHeight;
			_areaWidth = areaWidth;
			
			var w:int = Math.ceil(areaWidth / _listItems[0].width) + 1;
			var h:int = Math.floor(areaHeight / _listItems[0].height);
			
			_listMD.horizontalScroll.range = areaWidth;
			_listMD.horizontalScroll.max = _listItems[0].width * Math.ceil(dataLength / h);
			
			trace(_listMD.horizontalScroll.range,_listMD.horizontalScroll.max);
			
			var k:int;
			
			
			for (var i:int = 0; i < w; i++) 
			{
				for (var j:int = 0; j < h; j++) 
				{
					_listItems[k].x = _listItems[k].width * i;
					_listItems[k].y = _listItems[k].height * j;
					
					k++;
				}
				
			}
			
			_list.updateListContent(getFirstItem());
			
		}
		
		override public function getFirstItem():int 
		{
			var h:int = Math.floor(_areaHeight / _listItems[0].height);
			
			return Math.floor( _listMD.horizontalScroll.position / _listItems[0].width) * h;
		}
		
	}

}