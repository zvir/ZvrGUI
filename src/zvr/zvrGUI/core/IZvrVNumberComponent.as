package zvr.zvrGUI.core 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IZvrVNumberComponent 
	{
		function get change():Signal;
		
		function set value(v:Number):void
		function get value():Number;
		
	}
	
}