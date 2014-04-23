package zvr.zvrG2D 
{
	import com.genome2d.context.GContextCamera;
	import com.genome2d.node.GNode;
	import flash.geom.Rectangle;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class FNTCaret extends FNTLetter
	{
		
		public var blinkInterval:int = 250;
		
		public function FNTCaret(p_node:GNode) 
		{
			super(p_node);
		}
		
		override public function render(p_camera:GContextCamera, p_useMatrix:Boolean):void
		{
			
			node.transform.visible = int(getTimer() / blinkInterval) % 2 == 0;
			
			super.render(p_camera, p_useMatrix);
		}
		
	}

}