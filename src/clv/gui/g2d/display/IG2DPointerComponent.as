package clv.gui.g2d.display 
{
	import clv.gui.core.behaviors.IPointerComponent;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IG2DPointerComponent extends IPointerComponent
	{
		function get node():GNode;
	}
	
}