package zvr.zvrGUI.core 
{
	import flash.display.DisplayObject;
	import zvr.zvrGUI.events.ZvrViewStackEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name = "viewAdded",    		type = "zvr.zvrGUI.events.ZvrViewStackEvent")]
	[Event(name = "viewRemoved",    	type = "zvr.zvrGUI.events.ZvrViewStackEvent")]
	[Event(name = "currentCiewChanged",	type = "zvr.zvrGUI.events.ZvrViewStackEvent")]
	[Event(name = "viewIndexChanged",	type = "zvr.zvrGUI.events.ZvrViewStackEvent")]
	 
	public class ZvrViewStack extends ZvrContainer implements IZvrViewStack
	{
		
		private var _views:Vector.<ZvrComponent> = new Vector.<ZvrComponent>;
		private var _selectedIndex:int = 0;
		private var _currentView:ZvrComponent;
		private var _oldView:ZvrComponent;
		
		public function ZvrViewStack(skin:Class) 
		{
			super(skin);
		}
		
		public function addView(child:DisplayObject):DisplayObject 
		{
			_views.push(child);
			
			_dispachEvent(ZvrViewStackEvent.VIEW_ADDED, child as ZvrComponent);
			
			if (_views.length == 1)
			{
				selectedIndex = _selectedIndex;
			}
			
			//wch(this, "views", _views.length);
			return child;
			
		}
		
		public function removeView(child:DisplayObject):DisplayObject 
		{
			_views.splice(_views.indexOf(child), 1);
			
			if (child == _currentView)
			{
				selectedIndex = _selectedIndex;
			}
			
			_dispachEvent(ZvrViewStackEvent.VIEW_REMOVED, child as ZvrComponent);
			
			//wch(this, "views", _views.length);
			
			return child;
		}
		
		
		public function get selectedIndex():int 
		{
			return _selectedIndex;
		}
		
		public function set selectedIndex(value:int):void 
		{
			if (value < 0) value = _views.length - 1;
			if (value >= _views.length) value = 0;
			
			_selectedIndex = value;	
			
			_currentView && super.removeChild(_currentView);
			_oldView = _currentView;
			_currentView = getViewAt(_selectedIndex);
			
			_currentView && super.addChild(_currentView);
			
			_dispachEvent(ZvrViewStackEvent.CURRENT_VIEW_CHANGED, _currentView);
			
			//wch(this, "selectedIndex", selectedIndex);
			
		}
		
		public function get viewsNum():int
		{
			return _views.length;
		}
		
		public function get currentView():ZvrComponent 
		{
			return _currentView;
		}
		
		public function set currentView(value:ZvrComponent):void 
		{
			selectedIndex = _views.indexOf(value);
		}
		
		public function get oldView():ZvrComponent 
		{
			return _oldView;
		}
		
		public function getViewAt(index:int):ZvrComponent
		{
			
			if (_views.length == 0) return null;
			
			return _views[index];
		}
		
		public function getViewIndex(value:ZvrComponent):int
		{
			return _views.indexOf(value);
		}
		
		public function setViewIndex(view:ZvrComponent, index:int):void
		{
			var oldIndex:int
			oldIndex = _views.indexOf(view);
			
			if (oldIndex == -1 || oldIndex == index) return;
			
			_views.splice(oldIndex, 1);
			_views.splice(index, 0, view);
			
			
			_dispachEvent(ZvrViewStackEvent.VIEW_INDEX_CHANGED, view);
		}
		
		
		
		private function _dispachEvent(type:String, item:ZvrComponent):void
		{
			dispatchEvent(new ZvrViewStackEvent(type, this, item));
		}
		

		
	}

}