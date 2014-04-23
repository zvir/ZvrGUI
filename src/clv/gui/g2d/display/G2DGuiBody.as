package clv.gui.g2d.display 
{
	import clv.gui.core.display.IChildrenBody;
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.display.IContainerBody;
	import clv.gui.core.display.ISkinBody;
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class G2DGuiBody extends GComponent implements IContainerBody, ISkinBody, IChildrenBody
	{
		private var _skinFront:ISkinBody;
		private var _skinBack:ISkinBody;
		
		public function G2DGuiBody(p_node:GNode = null) 
		{
			super(p_node);
		}
		
		public function addElement(v:IComponentBody):void 
		{
			node.addChild(v.displayBody as GNode);
		}
		
		public function removeElement(v:IComponentBody):void 
		{
			node.removeChild(v.displayBody as GNode);
		}
		
		/* INTERFACE clv.gui.core.display.IContainerBody */
		
		public function getElementIndex(v:IComponentBody):int 
		{
			return node.getChildIndex(v.displayBody);
		}
		
		public function setElementIndex(v:IComponentBody, index:int):void 
		{
			node.setChildIndex(v.displayBody as GNode, index);
		}
		
		public function get displayBody():* 
		{
			return node;
		}
		
		public function set x(value:Number):void 
		{
			node.transform.x = value;
		}
		
		public function set y(value:Number):void 
		{
			node.transform.y = value;
		}
		
		public function set visible(value:Boolean):void 
		{
			node.transform.visible = value;
		}
		
		public function set skinFront(value:ISkinBody):void 
		{
			if (_skinFront) node.removeChild(_skinFront.displayBody);
			
			_skinFront = value;
			
			if (_skinFront) node.addChild(_skinFront.displayBody);
		}
		
		public function set skinBack(value:ISkinBody):void 
		{
			if (_skinBack) node.removeChild(_skinBack.displayBody);
			
			_skinBack = value;
			
			if (_skinBack) node.addChild(_skinBack.displayBody);
		}
	}

}