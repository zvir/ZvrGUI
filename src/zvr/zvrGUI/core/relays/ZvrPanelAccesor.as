package zvr.zvrGUI.core.relays
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.layouts.ZvrLayout;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrPanelAccesor extends ZvrContainerAccesor
	{
		
		public function ZvrPanelAccesor(superFunction:Function, superGetter:Function, superSetter:Function)
		{
			super(superFunction, superGetter, superSetter);
		}
		
		public function setLayout(layout:Class):void 
		{
			_superFunction("setLayout", layout);			
		}
		
		public function get layout():ZvrLayout 
		{
			return _superGetter("layout");
		}
		
		public function set autoSize(value:String):void 
		{
			_superSetter("autoSize", value);
		}
		
		public function get autoSize():String 
		{
			return _superGetter("autoSize");
		}
		
		
	}

}