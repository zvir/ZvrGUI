package clv.gui.g2d.behaviors 
{
	import com.genome2d.node.GNode;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IButtonComponent 
	{
		function get pointerSensitive():GNode;
		
		function get onClick():Signal;
		
	}
	
}