package zvr.zvrGUI.core.data 
{
	import zvr.zvrGUI.core.IZvrComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IZvrDataRenderer extends IZvrComponent
	{
		
		function set index(v:int):void;
		function get index():int;
		
		function set data(v:Object):void;
		function get data():Object;
		
		
		
		
	}
	
}