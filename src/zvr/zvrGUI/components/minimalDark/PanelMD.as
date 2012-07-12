package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrPanel;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.PanelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextureFillsMD;
	import zvr.zvrGUI.skins.ZvrStyles;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class PanelMD extends ZvrPanel
	{
		
		protected var _interactiveBehavior:ZvrRollOverHilight;
		
		public var resizeButton:ResizeButtonMD;
		private var _resizeBehavior:ZvrResizable;
		
		public function PanelMD(skin:Class = null) 
		{
			super(skin ? skin : PanelMDSkin);
			
			width = 100;
			height = 100;
			
			minWidth = 10;
			minHeight = 10;
			
			scroller = new ScrollerMD();
			_container.addChild(scroller);
			
			scroller.percentWidth = 100;
			scroller.percentHeight = 100;
			
			scroller.delegateStates = this;
			scroller.combineWithDelegateStates = true;
			
			resizeButton = new ResizeButtonMD();
			_container.addChild(resizeButton);
			
			resizeButton.bottom = 0;
			resizeButton.right = 0;
			resizeButton.delegateStates = this;
			resizeButton.combineWithDelegateStates = true;
			
			resizeButton.setStyle(ZvrStyles.BG_COLOR, ColorsMD.c2, [ZvrStates.HILIGHT]);
			
			_interactiveBehavior = new ZvrRollOverHilight();
			_behaviors.addBehavior(_interactiveBehavior);
			
			_resizeBehavior = new ZvrResizable(resizeButton);
			_behaviors.addBehavior(_resizeBehavior);
			
			_behaviors.addBehavior(ZvrBehaviors.get(ZvrBehaviors.DRAGABLE));
			ZvrDragable(_behaviors.getBehavior("Dragable")).addHandler(Sprite(scroller.skin.body));
			
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
			
			_states.add(ZvrStates.NORMAL);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.HILIGHT);
			_states.define(ZvrStates.ENALBLED);
			_states.define(ZvrStates.DISABLED);
			_states.define(ZvrStates.FOCUSED);
		}
		
		/*override protected function autoSizeToContent(width:Boolean, height:Boolean):void 
		{
			setSize(scroller.bounds.width, scroller.bounds.height);
		}*/
		
		/*override public function set autoSize(value:String):void 
		{
			super.autoSize = value;
			
			scroller.autoSize = autoSize;
			
			if (autoSize == ZvrAutoSize.CONTENT)
			{
				scroller.autoSize = autoSize;
			}
			else
			{
				scroller.autoSize = ZvrAutoSize.MANUAL;
				scroller.percentHeight = 100;
				scroller.percentWidth = 100;
			}
		}*/
		
		public function set resizable(value:Boolean):void
		{
			_resizeBehavior.enabled = value;
			resizeButton.includeInLayout = _resizeBehavior.enabled;
		}
		
		public function get resizable():Boolean
		{
			return _resizeBehavior.enabled;
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.newStates.indexOf(ZvrStates.ENALBLED) != -1)
			{
				_interactiveBehavior.enabled = true;
				_resizeBehavior.enabled = true;
			}
			if (e.newStates.indexOf(ZvrStates.DISABLED) != -1)
			{
				_interactiveBehavior.enabled = false;
				_resizeBehavior.enabled = false;
			}
			
			//trace(">", e.currentStates);
		}
		
		public function minimalize():void
		{
			_container.removeChild(scroller);
		}
		
		public function restore():void
		{
			_container.addChild(scroller);
			_container.setChildIndex(resizeButton, _container.numChildren - 1);
		}
		
	}
	
}