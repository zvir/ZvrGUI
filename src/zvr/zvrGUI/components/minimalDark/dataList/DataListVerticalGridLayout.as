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
	public class DataListVerticalGridLayout extends ZvrDataLayout
	{
		private var _listMD:DataListMD;
		private var _lastFirstItem:int;
		private var _areaWidth:Number;
		private var _areaHeight:Number;
		
		public function DataListVerticalGridLayout(list:DataListMD, listItems:Vector.<IZvrDataRenderer>) 
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
				trace(_lastFirstItem);
				_list.updateListContent(firstItem);
			}
			
		}
		
		override public function getItemsCount(areaWidth:Number, areaHeight:Number):int 
		{
			var w:int = Math.floor(areaWidth / _listItems[0].width) ;
			var h:int = Math.ceil(areaHeight / _listItems[0].height) + 1;
			
			/*var h:Number = _listItems[0].width
			var c:int = Math.ceil(areaWidth / h) + 1;*/
			
			return w * h;
		}
		
		override public function update(areaWidth:Number, areaHeight:Number, dataLength:int):void 
		{
			_areaHeight = areaHeight;
			_areaWidth = areaWidth;
			
			var w:int = Math.floor(areaWidth / _listItems[0].width) ;
			var h:int = Math.ceil(areaHeight / _listItems[0].height) + 1;
			
			_listMD.verticalScroll.range = areaHeight;
			_listMD.verticalScroll.max = _listItems[0].height * Math.ceil(dataLength / w);
			
			_listMD.verticalScroll.enabled = _listMD.verticalScroll.max > _listMD.verticalScroll.range;
			
			trace(_listMD.verticalScroll.range,_listMD.verticalScroll.max);
			
			var k:int;
			
			for (var i:int = 0; i < h; i++) 
			{
				for (var j:int = 0; j < w; j++) 
				{
					_listItems[k].y = _listItems[k].height * i;
					_listItems[k].x = _listItems[k].width * j;
					
					k++;
				}
				
			}
			
			_list.updateListContent(getFirstItem());
			
		}
		
		override public function getFirstItem():int 
		{
			var w:int = Math.floor(_areaWidth / _listItems[0].width) ;
			
			var f:int = Math.floor( _listMD.verticalScroll.position / _listItems[0].height) * w;
			
			return f;
		}
		
	}

}