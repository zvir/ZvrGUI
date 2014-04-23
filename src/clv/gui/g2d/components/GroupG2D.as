package clv.gui.g2d.components 
{
	import clv.gui.core.Container;
	import clv.gui.g2d.core.IG2DComponent;
	import clv.gui.g2d.core.SkinContainerG2D;
	import clv.gui.g2d.display.G2DGuiBody;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class GroupG2D extends Container implements IG2DComponent
	{
		
		private var _groupSkin:SkinContainerG2D;
		
		public function GroupG2D() 
		{
			_groupSkin = new SkinContainerG2D()
			super(_groupSkin);
		}
		
		public function get node():GNode 
		{
			return G2DGuiBody(body).node;
		}
		
		public function get groupSkin():SkinContainerG2D 
		{
			return _groupSkin;
		}
		
	}

}