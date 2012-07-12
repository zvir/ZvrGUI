package zvr.zvrGUI.core 
{
	import flash.display.DisplayObject;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public interface IZvrViewStack 
	{
		function addView(child:DisplayObject):DisplayObject;
		function removeView(child:DisplayObject):DisplayObject 
		function getViewAt(index:int):ZvrComponent
		function setViewIndex(view:ZvrComponent, index:int):void
		function get selectedIndex():int 
		function set selectedIndex(value:int):void 
		function get viewsNum():int
		function get currentView():ZvrComponent 
		function set currentView(value:ZvrComponent):void 
	}
	
}