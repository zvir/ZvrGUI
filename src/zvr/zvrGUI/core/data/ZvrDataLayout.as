package zvr.zvrGUI.core.data 
{
	import zvr.zvrGUI.layouts.ZvrLayout;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDataLayout
	{
		protected var _listItems:Vector.<IZvrDataRenderer>;
		protected var _list:ZvrDataList;
		
		private var _layoutClass:Class;
		
		public function ZvrDataLayout(list:ZvrDataList, listItems:Vector.<IZvrDataRenderer>) 
		{
			
			_list = list;
			_listItems = listItems;
			
		}
		
		public function getItemsCount(areaWidth:Number, areaHeight:Number):int
		{
			return 0;
		}
		
		public function getFirstItem():int
		{
			return 0;
		}
		
		public function update(areaWidth:Number, areaHeight:Number, dataLength:int):void
		{
			
		}
		
		public function dispose():void 
		{
			_listItems = null;
			_list = null;
		}
		
	}

}