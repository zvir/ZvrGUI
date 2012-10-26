package zvr.zvrGUI.behaviors 
{
	import flash.events.MouseEvent;
	import utils.display.bringToFront;
	import zvr.zvrGUI.core.ZvrComponent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBringToFrontBehavior extends ZvrBehavior 
	{
		
		public function ZvrBringToFrontBehavior() 
		{
			super("BringToFront");
		}
		
		override protected function enable():void
		{
			component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			bringToFront(ZvrComponent(component));
		}
		
		override protected function disable():void
		{
			component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
	}

}