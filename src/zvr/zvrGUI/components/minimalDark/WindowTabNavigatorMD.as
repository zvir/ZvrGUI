package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.MouseEvent;
	import flash.utils.Dictionary;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.core.ZvrViewStack;
	import zvr.zvrGUI.events.ZvrViewStackEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowTabNavigatorMD extends ZvrContainer 
	{
		private var _stack:ZvrViewStack;
		private var _tabs:Dictionary = new Dictionary();
		private var _titles:Dictionary = new Dictionary();
		private var _lastItem:WindowTitleMD;
		
		public function WindowTabNavigatorMD() 
		{
			super(ZvrSkin);	
			setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(layout).gap = 0;
		}
		
		private function addEventListenerToStack():void
		{
			_stack.addEventListener(ZvrViewStackEvent.VIEW_ADDED, viewAdded);
			_stack.addEventListener(ZvrViewStackEvent.VIEW_REMOVED, viewRemoved);
			_stack.addEventListener(ZvrViewStackEvent.VIEW_INDEX_CHANGED, indexChanged);
			_stack.addEventListener(ZvrViewStackEvent.CURRENT_VIEW_CHANGED, currentStackChanged);
		}
		
		private function removeEventListenerToStack():void
		{
			_stack.removeEventListener(ZvrViewStackEvent.VIEW_ADDED, viewAdded);
			_stack.removeEventListener(ZvrViewStackEvent.VIEW_REMOVED, viewRemoved);
			_stack.removeEventListener(ZvrViewStackEvent.VIEW_INDEX_CHANGED, indexChanged);
			_stack.removeEventListener(ZvrViewStackEvent.CURRENT_VIEW_CHANGED, currentStackChanged);
		}
		
		private function currentStackChanged(e:ZvrViewStackEvent):void 
		{
			var view:WindowTitleMD = _stack.currentView as WindowTitleMD;
			_stack.currentView && _tabs[_stack.currentView] && WindowTitleMD(_tabs[_stack.currentView]).addState(ZvrStates.FOCUSED);
			_stack.oldView && _tabs[_stack.oldView] && WindowTitleMD(_tabs[_stack.oldView]).removeState(ZvrStates.FOCUSED);
		}
		
		private function indexChanged(e:ZvrViewStackEvent):void 
		{
			_tabs[e.item] && setChildIndex(_tabs[e.item], _stack.getViewIndex(e.item));
		}
		
		private function viewRemoved(e:ZvrViewStackEvent):void 
		{
			var view:WindowStackItemMD = e.item  as WindowStackItemMD;
			delete _tabs[view];
			delete _titles[view.title];
			view.title.removeEventListener(MouseEvent.CLICK, titleClick);
			removeChild(view.title);
		}
		
		private function viewAdded(e:ZvrViewStackEvent):void 
		{
			var view:WindowStackItemMD = e.item  as WindowStackItemMD;
			_tabs[view] = view.title;
			_titles[view.title] = view;
			
			
			view.title.width = 200;
			
			view.title.x = 0;
			
			addChild(view.title);
			
			view.title.addEventListener(MouseEvent.CLICK, titleClick);
		}
		
		
		private function titleClick(e:MouseEvent):void 
		{
			_stack.currentView = _titles[e.target];
		}
		
		public function get stack():ZvrViewStack 
		{
			return _stack;
		}
		
		public function set stack(value:ZvrViewStack):void 
		{
			if (_stack) removeEventListenerToStack();
			_stack = value;
			if (_stack) addEventListenerToStack();
		}
		
	}

}