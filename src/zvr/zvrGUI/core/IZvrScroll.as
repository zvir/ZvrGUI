package zvr.zvrGUI.core 
{
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrScroll extends IZvrComponent
	{
		
		function get max():Number;
		function set max(value:Number):void
		
		function get min():Number;
		function set min(value:Number):void 
		
		function setUp(contentBegin:Number, contentEnd:Number, size:Number):void;
		
		function get step():Number;
		function set step(value:Number):void 
		
		function get minRange():Number;
		function set minRange(value:Number):void 
		
		function get percentagePosition():Number;
		function set percentagePosition(value:Number):void
		
		function get position():Number;
		function set position(value:Number):void
		
		function get dynamicRange():Boolean;
		function set dynamicRange(value:Boolean):void 
		
		function get enabled():Boolean;
		function set enabled(value:Boolean):void 
		
		function get percentageRangeEnd():Number
		function set percentageRangeEnd(value:Number):void
		
		function get rangeEnd():Number;
		function set rangeEnd(value:Number):void
		
		function get percentageRangeBegin():Number;
		function set percentageRangeBegin(value:Number):void 
		
		function get rangeBegin():Number;
		function set rangeBegin(value:Number):void 
		
		function get range():Number;
		function set range(value:Number):void 
	}
	
}