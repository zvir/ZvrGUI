package zvr.zvrGUI.utils 
{
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrPanel;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrComponentUtils 
	{
		
		public static function setPanelSizeToContent(panel:ZvrContainer, width:Number, height:Number):void
		{
			panel.width = width + panel.contentAreaWidth - panel.childrenAreaWidth;
			panel.height = height + panel.contentAreaHeight - panel.childrenAreaHeight;
		}
		
	}

}