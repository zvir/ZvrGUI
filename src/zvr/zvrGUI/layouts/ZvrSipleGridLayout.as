package zvr.zvrGUI.layouts 
{
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.core.ZvrContainer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSipleGridLayout extends ZvrLayout
	{
		private var _gap:Number = 10;
		
		public function ZvrSipleGridLayout(cointainer:IZvrContainer, computeContentBounds:Function, registration:Function, contentAreaIndependent:Function) 
		{
			super(cointainer, computeContentBounds, registration, contentAreaIndependent);
		}
		
		override protected function layout():void 
		{
			
			var rowHegiht:Number = 0;
			var row:Number = 0;
			var collumn:Number = 0;
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:IZvrComponent = elementes[i];
				
				var cx:Number;
				
				cx = collumn + comp.bounds.width;
				
				if (cx > _container.childrenAreaWidth)
				{
					row += rowHegiht + _gap;
					collumn = 0;
				}
				
				comp.x = collumn;
				comp.y = row;
				
				collumn += comp.bounds.width + _gap;
				
				rowHegiht = comp.bounds.height > rowHegiht ? comp.bounds.height : rowHegiht;
				
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