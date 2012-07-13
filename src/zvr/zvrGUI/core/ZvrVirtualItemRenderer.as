package zvr.zvrGUI.core 
{
	import flash.geom.Rectangle;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrVirtualItemRenderer 
	{
		
		
		public var bounds:Rectangle;
		public var selected:Boolean;
		public var index:int;
		public var data:Object;
		
		public var itemRenderer:ZvrItemRenderer;
		
		public function ZvrVirtualItemRenderer(index:int, data:Object = null, bounds:Rectangle = null, selected:Boolean = false)
		{
			this.index = index;
			this.data = data;
			this.bounds = bounds;
			this.selected = selected;
		}
		
		public function setSelected(v:Boolean):void
		{
			if (!itemRenderer) return;
			selected = v;
			itemRenderer.setup(this);
		}
		
	}

}