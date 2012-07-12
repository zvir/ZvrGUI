package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrBringToFrontBehavior;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.core.IZvrViewStack;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.core.ZvrViewStack;
	import zvr.zvrGUI.core.ZvrWindow;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrViewStackEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.PanelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestPanelSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.WindowStackMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowStackMD extends ZvrContainer implements IZvrViewStack
	{
		private var _tabs:WindowTabNavigatorMD;
		private var _stack:ZvrViewStack;
		private var _interactiveBehavior:ZvrRollOverHilight;
		private var _resizeBehavior:ZvrResizable;
		
		public function WindowStackMD() 
		{
			super(WindowStackMDSkin);
			
			autoSize = ZvrAutoSize.CONTENT;
			
			minHeight = 100;
			minWidth = 100;
			
			_resizeBehavior = new ZvrResizable(null);
			_behaviors.addBehavior(_resizeBehavior);
			_interactiveBehavior = new ZvrRollOverHilight();
			_behaviors.addBehavior(_interactiveBehavior);
			_behaviors.addBehavior(new ZvrBringToFrontBehavior());
			_behaviors.addBehavior(ZvrBehaviors.get(ZvrBehaviors.DRAGABLE));
			_stack = new ZvrViewStack(ZvrSkin);

			_stack.top = 15;
			_stack.bottom = 0;
			_stack.right = 0;
			_stack.left = 0;
			//_stack.autoSize = ZvrAutoSize.CONTENT;
			addChild(_stack);
			
			_stack.addEventListener(ZvrViewStackEvent.CURRENT_VIEW_CHANGED, updateDelegateAndSkin);
			_stack.addEventListener(ZvrViewStackEvent.VIEW_INDEX_CHANGED, updateDelegateAndSkin);
			
			_tabs = new WindowTabNavigatorMD();
			_tabs.left = 0;
			_tabs.right = 40;
			_tabs.height = 15;
			_tabs.stack = _stack;
			_tabs.addEventListener(ZvrContainerEvent.CONTENT_SIZE_CHANGE, tabsChange);
			addChild(_tabs);
			
		}
		
		override protected function defineStates():void 
		{
			super.defineStates();
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
			_states.define(ZvrStates.FOCUSED);
			_states.define(ZvrStates.HILIGHT);
		}
		
		private function tabsChange(e:ZvrContainerEvent):void 
		{
			updateSkin();
		}
		
		private function updateDelegateAndSkin(e:ZvrViewStackEvent = null):void 
		{
			delegateStates = _stack.currentView;
			updateSkin();
		}
		
		public function addView(child:DisplayObject):DisplayObject 
		{
			
			if (!(child is WindowStackItemMD)) 
			{
				throw new Error("child is not WindowStackItemMD");
			}
			
			var panel:WindowStackItemMD = child as WindowStackItemMD;
			panel.autoSize = ZvrAutoSize.MANUAL;
			panel.percentHeight = 100;
			panel.percentWidth = 100;
			panel.behaviors.getBehavior("Dragable").enabled = false;
			//panel.behaviors.getBehavior("RollOver").enabled = false;
			panel.behaviors.getBehavior(ZvrResizable.NAME).enabled = false;
			//panel.delegateStates = this;
			ZvrDragable(behaviors.getBehavior("Dragable")).addHandler(panel.skin.body as Sprite);
			ZvrDragable(behaviors.getBehavior("Dragable")).addHandler(panel.scroller.skin.body as Sprite);
			
			_resizeBehavior.addHandler(panel.resizeButton);
			
			ZvrDragable(behaviors.getBehavior("Dragable")).addHandler(panel.title as Sprite);
			updateDelegateAndSkin();
			return _stack.addView(child);
			
		}
		
		public function removeView(child:DisplayObject):DisplayObject 
		{
			if (!child) return null;
			var panel:WindowStackItemMD = child as WindowStackItemMD;
			ZvrDragable(behaviors.getBehavior("Dragable")).removeHandler(panel.title);
			updateDelegateAndSkin();
			return _stack.removeView(child);
		}
		
		/* INTERFACE zvr.zvrGUI.core.IZvrViewStack */
		
		public function getViewAt(index:int):ZvrComponent 
		{
			return _stack.getViewAt(index);
		}
		
		public function setViewIndex(view:ZvrComponent, index:int):void 
		{
			_stack.setViewIndex(view, index);
		}
		
		public function get selectedIndex():int 
		{
			return _stack.selectedIndex;
		}
		
		public function set selectedIndex(value:int):void 
		{
			_stack.selectedIndex = value;
		}
		
		public function get viewsNum():int 
		{
			return _stack ? _stack.viewsNum : 0;
		}
		
		public function get currentView():ZvrComponent 
		{
			return _stack.currentView;
		}
		
		public function set currentView(value:ZvrComponent):void 
		{
			_stack.currentView = value;
		}
		
		public function get tabs():WindowTabNavigatorMD 
		{
			return _tabs;
		}
		
		
		
	}

}