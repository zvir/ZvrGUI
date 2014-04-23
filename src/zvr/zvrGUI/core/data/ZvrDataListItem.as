package zvr.zvrGUI.core.data 
{
	import flash.events.EventDispatcher;
	import zvr.zvrGUI.core.custom.IZvrComponentBody;
	import zvr.zvrGUI.core.ZvrExplicitReport;
	import flash.events.Event;
	import zvr.zvrGUI.skins.base.ZvrSkinStyle;
	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.behaviors.ZvrComponentBehaviors;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDataListItem extends EventDispatcher
	{
		
		public var states:Object = { };
		
		public var data:Object;
		
		public var index:int;
		
		public function ZvrDataListItem() 
		{
			
		}
		
	}

}