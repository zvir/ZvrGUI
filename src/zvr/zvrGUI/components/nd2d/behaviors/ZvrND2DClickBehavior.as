package zvr.zvrGUI.components.nd2d.behaviors 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.components.nd2d.ZvrND2DComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DClickBehavior extends ZvrBehavior 
	{
		public static const NAME:String = "Dragable";
		
		private var _downTime:int;
		
		public function ZvrND2DClickBehavior() 
		{
			super(NAME);
		}
		
		override protected function enable():void 
		{
			super.enable();
			node.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			node.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.addEventListener(MouseEvent.MOUSE_UP, mouseUp, false, 999999);
			_downTime = getTimer();
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			node.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			if (getTimer() - _downTime < 400)
			{
				component.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
			
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
		}
		
		override protected function disable():void 
		{
			super.disable();
			
			node.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			node.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			
		}
		
		private function get node():Node2D
		{
			return IZvrND2DComponent(component).node;
		}
		
	}

}