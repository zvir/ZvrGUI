package zvr.zvrG2D.zvrDrawer 
{
	import com.genome2d.node.GNode;
	import flash.geom.Rectangle;
	import com.genome2d.components.GComponent;
	import com.genome2d.components.renderables.IRenderable;
	import com.genome2d.context.GContextCamera;
	/**
	 * ...
	 * @author Zvir
	 */
	public class GDrawer extends GComponent implements IRenderable
	{
		
		private var _items:Vector.<GDrawerItem> = new Vector.<GDrawerItem>();
		
		public function GDrawer(p_node:GNode = null)
		{
			super(p_node);
		}
		
		public function addItem(item:GDrawerItem):void
		{
			var i:int = _items.indexOf(item);
			if (i == -1) _items.push(item);
		}
		
		public function removeItem(item:GDrawerItem):void
		{
			var i:int = _items.indexOf(item);
			if (i != -1) _items.splice(i, 1);
		}
		
		public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void 
		{
			
			var cos:Number = Math.cos(node.transform.g2d_worldRotation);
			var sin:Number = Math.sin(node.transform.g2d_worldRotation);
			
			for (var i:int = 0; i < _items.length; i++) 
			{
				var item:GDrawerItem = _items[i];
				
				if (item.alpha <= 0 || !item.visible || !item.texture || item.scaleX == 0 || item.scaleY == 0) continue;
				
				var tx:Number = (item.x * cos - item.y * sin) * node.transform.g2d_worldScaleX + node.transform.g2d_worldX;
				var ty:Number = (item.y * cos + item.x * sin) * node.transform.g2d_worldScaleY + node.transform.g2d_worldY;
				
				node.core.getContext().draw(
					item.texture, tx, ty, 
					item.scaleX * node.transform.g2d_worldScaleX, 
					item.scaleY * node.transform.g2d_worldScaleY, 
					item.rotation + node.transform.g2d_worldRotation, 
					item.red * node.transform.g2d_worldRed, 
					item.green * node.transform.g2d_worldGreen, 
					item.blue * node.transform.g2d_worldBlue, 
					item.alpha * node.transform.g2d_worldAlpha, 
					item.blendMode
				);
				
			}
		}
		
		public function getBounds(p_target:Rectangle = null):Rectangle 
		{
			return null;
		}
		
	}

}