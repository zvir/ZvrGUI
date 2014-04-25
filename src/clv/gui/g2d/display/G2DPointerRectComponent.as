package clv.gui.g2d.display 
{
	import clv.gui.core.Component;
	import clv.gui.core.ComponentSignal;
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GMouseSignal;
	import com.genome2d.signals.GMouseSignalType;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class G2DPointerRectComponent extends GComponent 
	{
		private var _component:Component;
		
		public var rect:Rectangle;
		public var autoSize:Boolean = true;
		
		public function G2DPointerRectComponent(p_node:GNode) 
		{
			super(p_node);
		}
		
		public static function addTo(component:Component):G2DPointerRectComponent
		{
			var p:G2DPointerRectComponent = GNode(component.body.displayBody).addComponent(G2DPointerRectComponent) as G2DPointerRectComponent;
			p.init(component);
			return p;
		}
		
		private function init(component:Component):void 
		{
			_component = component;
			_component.onResized.add(resized);
		}
		
		private function resized(s:ComponentSignal):void 
		{
			if (!autoSize) return;
			
			if (!rect) rect = new Rectangle();
			
			rect.width = _component.bounds.width;
			rect.height = _component.bounds.height;
			
		}
		
		override public function processContextMouseSignal(p_captured:Boolean, p_cameraX:Number, p_cameraY:Number, p_contextSignal:GMouseSignal):Boolean 
		{
			if (!rect) return false;
			
			if (p_captured && p_contextSignal.type == GMouseSignalType.MOUSE_UP) g2d_node.g2d_mouseDownNode = null;
			
			if (p_captured || g2d_node.transform.g2d_worldScaleX == 0 || g2d_node.transform.g2d_worldScaleY == 0)
			{
				if (g2d_node.g2d_mouseOverNode == g2d_node) 
					g2d_node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, g2d_node, 0, 0, p_contextSignal);
				return false;
			}
			
			var mouseLocalPosition:Point = node.transform.globalToLocal(new Point(p_cameraX, p_cameraY));
			
			if (rect.containsPoint(mouseLocalPosition)) 
			{
				node.dispatchNodeMouseSignal(p_contextSignal.type, node, mouseLocalPosition.x, mouseLocalPosition.y, p_contextSignal);
				
				if (g2d_node.g2d_mouseOverNode != g2d_node)
				{
					g2d_node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OVER, g2d_node, mouseLocalPosition.x, mouseLocalPosition.y, p_contextSignal);
				}

				return true;
				
			}
			else
			{
				if (g2d_node.g2d_mouseOverNode == g2d_node)
				{
					g2d_node.dispatchNodeMouseSignal(GMouseSignalType.MOUSE_OUT, g2d_node, mouseLocalPosition.x, mouseLocalPosition.y, p_contextSignal);
				}
			}
			
			return false;
		}
		
	}

}