package zvr.zvrG2D 
{
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GMouseSignal;
	import com.genome2d.signals.GMouseSignalType;
	import flash.events.TouchEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.geom.Vector3D;
	import com.genome2d.components.GComponent;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrG2DMouseRectComponent extends GComponent 
	{
		
		public var rect:Rectangle = new Rectangle();
		public var reportOuside:Boolean;
		
		public var ouside:Boolean;
		
		public function ZvrG2DMouseRectComponent() 
		{
			super();
		}
		
		override public function processContextMouseSignal(p_captured:Boolean, p_cameraX:Number, p_cameraY:Number, p_contextSignal:GMouseSignal):Boolean 
		{
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
				ouside = false;
				//trace(p_contextSignal.type);
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
			
			if (!rect.containsPoint(mouseLocalPosition) && reportOuside)
			{
				ouside = true;
				node.dispatchNodeMouseSignal(p_contextSignal.type, node, mouseLocalPosition.x, mouseLocalPosition.y, p_contextSignal);
				return false;
			}
			
			return false;
		}
		
		
	}

}