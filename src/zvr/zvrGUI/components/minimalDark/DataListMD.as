package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.data.ZvrDataList;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class DataListMD extends ZvrDataList
	{
		private var _verticalScroll:ZvrScroll;
		private var _horizontalScroll:ZvrScroll;

		public function DataListMD(itemClass:Class, verticalScroll:ZvrScroll, horizontalScroll:ZvrScroll) 
		{
			super(itemClass, ZvrSkin);
			
			_horizontalScroll = horizontalScroll;
			_verticalScroll = verticalScroll;
			
			addEventListener(ZvrComponentEvent.RESIZE, resize);
		}
		
		private function resize(e:ZvrComponentEvent):void 
		{
			trace(childrenAreaWidth);
		}
		
		public function get verticalScroll():ZvrScroll 
		{
			return _verticalScroll;
		}
		
		public function get horizontalScroll():ZvrScroll 
		{
			return _horizontalScroll;
		}
		
	}

}