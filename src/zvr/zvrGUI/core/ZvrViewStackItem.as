package zvr.zvrGUI.core 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrViewStackItem 
	{
	
		private var _view:ZvrComponent;
		public var index:int;
		public var next:ZvrViewStackItem;
		public var prev:ZvrViewStackItem;
		
		public function ZvrViewStackItem(view:ZvrComponent) 
		{
			_view = view;
		}
		
		public function get view():ZvrComponent 
		{
			return _view;
		}
		
		public function moveIndex(delta:int = 1):void
		{
			index += delta;
			next && moveIndex(delta);
		}
		
		public function remove():void
		{
			if(prev) prev.next = next;
			next.moveIndex( -1);
		}
		
	}

}