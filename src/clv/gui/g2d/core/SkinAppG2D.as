package clv.gui.g2d.core 
{
	import clv.gui.core.display.ISkinBody;
	import clv.gui.core.skins.Skin;
	import clv.gui.core.skins.SkinContainer;
	import clv.gui.g2d.display.G2DGuiBody;
	import com.genome2d.node.factory.GNodeFactory;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SkinAppG2D extends SkinContainer
	{
		private var _containerNode:GNode;
		
		
		public function SkinAppG2D() 
		{
			
		}
		
		override protected function create():void 
		{
			
			_cointainerBody = GNodeFactory.createNodeWithComponent(G2DGuiBody) as G2DGuiBody;
			_componentBody = _cointainerBody;
			
			_childrenBody = GNodeFactory.createNodeWithComponent(G2DGuiBody) as G2DGuiBody;
			_cointainerBody.addElement(_childrenBody);
			
			_containerNode = G2DGuiBody(_componentBody).node
			
			_containerNode.onAddedToStage.addOnce(addedToStage);
		}
		
		private function addedToStage():void 
		{
			_containerNode.onRemovedFromStage.addOnce(removedFromStage);
			_containerNode.core.onPreRender.add(updateApp);
		}
		
		private function updateApp():void 
		{
			AppG2D(_component).updateApp(0, 0, _containerNode.core.getContext().getNativeStage().stageWidth, _containerNode.core.getContext().getNativeStage().stageHeight); 
		}
		
		private function removedFromStage():void 
		{
			_containerNode.onAddedToStage.addOnce(addedToStage);
			_containerNode.core.onPreRender.remove(updateApp);
		}
		
		override public function updateBounds():void 
		{
			super.updateBounds();
			
			_componentBody.x = _component.bounds.x;
			_componentBody.y = _component.bounds.y;
		}
		
		public function get containerNode():GNode 
		{
			return _containerNode;
		}
		
	}

}