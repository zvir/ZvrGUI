package zvr.zvrGUI.test.dataTest 
{
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	import zvr.zvrGUI.core.data.ZvrDataListItem;
	import zvr.zvrGUI.core.ZvrAutoSize;
	/**
	 * ...
	 * @author Zvir
	 */
	public class DataListItem extends ButtonMD implements IZvrDataRenderer
	{
		
		public function DataListItem() 
		{
			autoSize = ZvrAutoSize.MANUAL;
			//percentHeight = 100;
			
			width = 100;
			height = 50;
		}
		
		/* INTERFACE zvr.zvrGUI.core.data.IZvrDataRenderer */
		
		public function set data(value:ZvrDataListItem):void 
		{
			//_data = value;
			
			if (value)
			{
				label.text = String(value.data);
				visible = true;
			}
			else
			{
				visible = false;
			}
			
			
		}
		
		public function get data():ZvrDataListItem 
		{
			return null;
		}
		
	}

}