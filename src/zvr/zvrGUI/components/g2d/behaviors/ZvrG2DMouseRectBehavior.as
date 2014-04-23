package zvr.zvrGUI.components.g2d.behaviors 
{
	import com.genome2d.node.GNode;
	import flash.geom.Rectangle;
	import zvr.zvrG2D.ZvrG2DMouseRectComponent;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.g2d.IZvrG2DComponent;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DMouseRectBehavior extends ZvrBehavior
	{
		public static const NAME:String = "MouseRect";
		
		private var _mouseRect:ZvrG2DMouseRectComponent
		
		public function ZvrG2DMouseRectBehavior() 
		{
			super(NAME);
		}
		
		override protected function enable():void 
		{
			super.enable();
			
			_mouseRect = node.addComponent(ZvrG2DMouseRectComponent) as ZvrG2DMouseRectComponent;
			component.addEventListener(ZvrComponentEvent.RESIZE, resized);
			resized(null);
		}
		
		override protected function disable():void 
		{
			super.disable();
			component.removeEventListener(ZvrComponentEvent.RESIZE, resized);
			node.removeComponent(ZvrG2DMouseRectComponent);
			_mouseRect.dispose();
			_mouseRect = null;
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			_mouseRect.rect.width = component.bounds.width;
			_mouseRect.rect.height = component.bounds.height;
		}
		
		private function get node():GNode
		{
			return IZvrG2DComponent(component).node;
		}
		
	}

}