package zvr.zvrGUI.core 
{
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IZvrVBooleanComponent 
	{
		function get change():Signal;
		
		function set value(v:Boolean):void
		function get value():Boolean;
		
	}
	
}