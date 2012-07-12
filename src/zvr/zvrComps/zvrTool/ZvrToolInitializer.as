package zvr.zvrComps.zvrTool 
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToolInitializer 
	{
		
		static public function init(mainDocumentClass:Sprite):WindowMD
		{
			mainDocumentClass.stage.scaleMode = StageScaleMode.NO_SCALE;
			mainDocumentClass.stage.align = StageAlign.TOP_LEFT;
			
			var tool:ZvrTool = new ZvrTool();
			tool.setDocumentClass(mainDocumentClass);
			
			var appWindow:WindowMD = new WindowMD();
			
			appWindow.left = 10;
			appWindow.top = 10;
			appWindow.bottom = 170;
			appWindow.right = 470;
			appWindow.behaviors.getBehavior(ZvrResizable.NAME).enabled = false;
			appWindow.behaviors.getBehavior(ZvrDragable.NAME).enabled = false;
			
			tool.addChild(appWindow);
			mainDocumentClass.addChild(tool);
			
			return appWindow;
			
		}
		
	}

}