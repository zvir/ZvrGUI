package clv.gui.g2d.display 
{
	import clv.gui.core.display.IContainerMask;
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class G2DContainerMask extends GSprite implements IContainerMask
	{
		
		public function G2DContainerMask(p_node:GNode=null) 
		{
			super(p_node);
		}
		
		public function updateMask(top:Number, left:Number, width:Number, height:Number):void 
		{
			if (!texture) return;
			
			node.transform.x = top + width / 2;
			node.transform.y = left + height / 2;
			
			node.transform.scaleX = width / texture.width;
			node.transform.scaleY = height / texture.height;
			
		}
		
		public function set enabled(value:Boolean):void 
		{
			node.transform.visible = value;
		}
		
	}

}