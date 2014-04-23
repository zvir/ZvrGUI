package zvr.zvrGUI.layouts.data 
{
	import zvr.zvrGUI.core.data.IZvrDataRenderer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrDynamicListLayout 
	{
		function isLast(item:IZvrDataRenderer):Boolean;
		
		function beginLayout(startPosition:Number):void;
		
		function itemLayout(item:IZvrDataRenderer):Boolean;
		
		function endLayout():void;
		
		function getPixelPositionDelta(d:Number):Number;
		
		function get items():Vector.<IZvrDataRenderer>;
		function set items(v:Vector.<IZvrDataRenderer>):void;
		
	}
	
}