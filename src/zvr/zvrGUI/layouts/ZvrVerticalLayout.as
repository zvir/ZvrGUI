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
	
	public class ZvrVerticalLayout extends ZvrLayout
	{
		
		private var _gap:Number = 10;
		
		public function ZvrVerticalLayout(cointainer:ZvrContainer, computeContentBounds:Function, registration:Function) 
		{
			super(cointainer, computeContentBounds, registration);
		}
		
		override protected function layout():void 
		{
			var y:Number = 0;
			var h:Number = 0;
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:ZvrComponent = elementes[i];
				comp.y = y + h + (isNaN(comp.top) ? 0 : comp.top);
				y = comp.y;
				h = comp.bounds.height + gap;
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