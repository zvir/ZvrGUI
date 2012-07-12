package zvr.zvrGUI.layouts 
{
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrHorizontalLayout extends ZvrLayout
	{
		
		private var _gap:Number = 10;
		
		public function ZvrHorizontalLayout(cointainer:ZvrContainer, computeContentBounds:Function, registration:Function) 
		{
			super(cointainer, computeContentBounds, registration);
		}
		
		override protected function layout():void 
		{
			var x:Number = 0;
			var w:Number = 0;
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:ZvrComponent = elementes[i];
				comp.x = x + w + (isNaN(comp.left) ? 0 : comp.left);
				x = comp.x;
				w = comp.bounds.width + gap + (isNaN(comp.right) ? 0 : comp.right);
			}
			
		}
		
		public function get gap():Number 
		{
			return _gap;
		}
		
		public function set gap(value:Number):void 
		{
			_gap = value;
			update();
		}
	}

}