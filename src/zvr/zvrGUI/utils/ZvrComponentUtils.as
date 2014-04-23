package zvr.zvrGUI.utils 
{
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
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
		
		public static function setupStaticWindow(window:WindowMD):void
		{
			
			window.options.visible = false;
			//window.panel.scroller.behaviors.getBehavior("DragScrolable").enabled = false;
			ZvrDragable(window.behaviors.getBehavior("Dragable")).enabled = false;
			ZvrResizable(window.behaviors.getBehavior(ZvrResizable.NAME)).enabled = false;
			
		}
		
	}

}