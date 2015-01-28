package zvr.zvrGUI.core 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IZvrVStringComponent 
	{
		function get change():Signal;
		
		function set value(v:String):void
		function get value():String;
		
	}
	
}