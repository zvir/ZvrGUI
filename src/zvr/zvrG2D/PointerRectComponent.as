package zvr.zvrG2D 
{
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
	
	public class PointerRectComponent extends GComponent 
	{
		public var rect:Rectangle;
		
		public function PointerRectComponent(p_node:GNode) 
		{
			super(p_node);
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