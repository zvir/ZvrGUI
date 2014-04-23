package zvr.zvrGUI.components.minimalDark.managers 
{
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.components.minimalDark.PanelMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.core.ZvrComponetStoredSetup;
	import zvr.zvrGUI.core.ZvrExplicitBounds;
	import zvr.zvrGUI.core.ZvrExplicitReport;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class WindowMDStatesManager 
	{
		private var _window:WindowMD;
		private var _store:ZvrComponetStoredSetup;
		
		private var _resizeBehavior:ZvrResizable;
		private var _dragableBehavior:ZvrDragable;
		
		public function WindowMDStatesManager(window:WindowMD,  resizeBehavior:ZvrResizable, dragableBehavior:ZvrDragable) 
		{
			_dragableBehavior = dragableBehavior;
			_resizeBehavior = resizeBehavior;
			_window = window;
			
			_window.addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{	
			
			if (e.isNew(ZvrStates.HILIGHT) || e.isRemoved(ZvrStates.HILIGHT)) return;
			
			if (e.isRemoved(ZvrStates.MINIMALIZED))
			{
				restoreFromMinimalized();
			}
			
			if (e.isRemoved(ZvrStates.MAXIMILIZED))
			{
				restoreFromMaximilized();
			}
			
			if (e.isRemoved(ZvrStates.RESTORED))
			{
				exitRestore();
			}
			
			if (e.isNew(ZvrStates.MAXIMILIZED))
			{
				maximilize();
			}
			
			if (e.isNew(ZvrStates.MINIMALIZED))
			{
				minimalize();
			}
		}
		
		private function restoreFromMinimalized():void
		{
			_store.x = _window.x;
			_store.y = _window.y;
			_store.width = _window.width;
			_store.explicit.x = _window.explicit.x;
			_store.explicit.y = _window.explicit.y;
			_store.explicit.width = _window.explicit.width;
			_store.explicit.height = _window.explicit.height;
			_store.left = _window.left;
			_store.right = _window.right;
			_store.top = _window.top;
			restore();
			
			PanelMD(_window.panel).restore();
		}
		
		private function restoreFromMaximilized():void
		{			
			_resizeBehavior.enabled = true;
			_dragableBehavior.enabled = true;
			restore();
		}
		
		private function minimalize():void
		{
			PanelMD(_window.panel).minimalize();
			
			_window.x = _window.bounds.x;
			_window.y = _window.bounds.y;
			
			_window.minHeight = 27;
			_window.maxHeight = 27;
			_window.height = 27;
		}
		
		private function exitRestore():void
		{
			_store = _window.getStoreSetup();
		}
		
		private function maximilize():void
		{
			
			_window.resetComponent();
			
			_window.top = 0;
			_window.left = 0;
			_window.right = 0;
			_window.bottom = 0;
			
			_resizeBehavior.enabled = false;
			_dragableBehavior.enabled = false;
		}
		
		private function restore():void
		{
			if (_store) _window.setStoreSetup(_store);
		}
		
	}

}