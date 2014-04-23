package clv.gui.core.behaviors 
{
	import clv.gui.core.IComponent;
	import clv.gui.core.Pointer;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IPointerComponent extends IComponent
	{
		function get pointer():Pointer;
	}
	
}