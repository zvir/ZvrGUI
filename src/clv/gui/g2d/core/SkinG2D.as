package clv.gui.g2d.core 
{
	import clv.gui.core.display.ISkinBody;
	import clv.gui.core.skins.Skin;
	import clv.gui.g2d.display.G2DGuiBody;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SkinG2D extends Skin
	{
		
		protected var _skinNode:GNode;
		
		public function SkinG2D() 
		{
			
		}
		
		override protected function create():void 
		{
			super.create();
			
			_componentBody = GNodeFactory.createNodeWithComponent(G2DGuiBody) as G2DGuiBody;
			_skinNode = G2DGuiBody(_componentBody).node;
		}
		
		override public function updateBounds():void 
		{
			super.updateBounds();
			
			_componentBody.x = _component.bounds.x;
			_componentBody.y = _component.bounds.y;
			
		}
		
		public function get skinNode():GNode 
		{
			return _skinNode;
		}
		
		
	}

}