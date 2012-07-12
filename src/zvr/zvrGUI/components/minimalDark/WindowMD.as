package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrBringToFrontBehavior;
	import zvr.zvrGUI.behaviors.ZvrDisable;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.components.minimalDark.managers.WindowMDStatesManager;
	import zvr.zvrGUI.core.IZvrInteractive;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.core.ZvrWindow;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.WindowMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowMD extends ZvrWindow implements IZvrInteractive
	{
		
		public var title:WindowTitleMD;
		public var status:LabelMD;
		public var options:WindowOptionsMD;
		
		private var _statusContainer:ZvrGroup;
		
		private var _resizeBehavior:ZvrResizable;
		
		private var _interactiveBehavior:ZvrRollOverHilight;
		private var _dragableBehavior:ZvrDragable;
		private var _disableBehavior:ZvrDisable;
		
		private var _stateManager:WindowMDStatesManager;
		
		public function WindowMD() 
		{
			
			status = new LabelMD();
			super(WindowMDSkin);
			
			minHeight = 100;
			minWidth = 100;
			
			panel = new PanelMD();
			panel.minHeight = 10;
			panel.minWidth = 10;
			
			panel.behaviors.getBehavior(ZvrResizable.NAME).enabled = false;
			
			panel.delegateStates = this;
			panel.top = 15;
			panel.bottom = 0;
			panel.right = 0;
			panel.left = 0;
			
			_interactiveBehavior = new ZvrRollOverHilight();
			_behaviors.addBehavior(_interactiveBehavior);
			_behaviors.addBehavior(new ZvrBringToFrontBehavior());
			
			/*_disableBehavior = new ZvrDisable();
			_behaviors.addBehavior(_disableBehavior);*/
			
			_container.addChild(panel);
			
			title = new WindowTitleMD();
			title.delegateStates = this;
			title.left = 0;
			title.right = 40;
			title.titleLabel.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0763);
			title.behaviors.getBehavior("RollOver").enabled = false;
			
			_container.addChild(title);
			
			_statusContainer = new ZvrGroup();
			_container.addChild(_statusContainer);
			_statusContainer.left = 0;
			_statusContainer.right = 13;
			_statusContainer.bottom = 0;
			_statusContainer.mouseEnabled = false;
			_statusContainer.mouseChildren = false;
			
			status.bottom = 0;
			status.text = "status";
			status.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);
			status.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			status.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.HILIGHT);
			status.delegateStates = this;
			status.mouseEnabled = false;
			status.mouseChildren = false;
			_statusContainer.addChild(status);
			
			options = new WindowOptionsMD(this);
			options.right = 2;
			options.top = 4;
			options.delegateStates = this;
			_container.addChild(options);
			
			panel.behaviors.getBehavior("Dragable").enabled = false;
			panel.behaviors.getBehavior("RollOver").enabled = false;
			
			_dragableBehavior = new ZvrDragable();
			_behaviors.addBehavior(_dragableBehavior);
			
			_dragableBehavior.addHandler(panel.skin.body as Sprite);
			_dragableBehavior.addHandler(panel.scroller.skin.body as Sprite);
			_dragableBehavior.addHandler(title);
			
			_resizeBehavior = new ZvrResizable(PanelMD(panel).resizeButton);
			_behaviors.addBehavior(_resizeBehavior);
			
			_states.add(ZvrStates.NORMAL);
			
			_stateManager = new WindowMDStatesManager(this, _resizeBehavior, _dragableBehavior);
			
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
		
		override protected function setSuperPosition(x:Number, y:Number):void 
		{
			super.setSuperPosition(Math.round(x * 0.5)*2, Math.round(y * 0.5)*2);
		}
		
		public function addStatusComponent(component:ZvrComponent):void
		{
			component.bottom = 0;
			component.delegateStates = this;
			component.mouseEnabled = false;
			component.mouseChildren = false;
			_statusContainer.addChild(component);
		}
		
		public function addStatusLabel(label:ZvrComponent):void
		{
			label.bottom = 0;
			label.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);
			label.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			label.setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.HILIGHT);
			label.delegateStates = this;
			label.mouseEnabled = false;
			label.mouseChildren = false;
			_statusContainer.addChild(label);
		}
		
		/* INTERFACE zvr.zvrGUI.core.IZvrInteractive */
		
		public function set enabled(value:Boolean):void 
		{
			panel.scroller.enabled = value;
		}
		
		public function get enabled():Boolean 
		{
			return panel.scroller.enabled;
		}
		
		/*public function set enabled(value:Boolean):void 
		{
			_disableBehavior.enabledValue = value;
		}
		
		public function get enabled():Boolean 
		{
			return _disableBehavior.enabledValue;
		}*/
		
		override protected function closed():void 
		{
			if (owner) owner.removeChild(this);
		}
		
	}

}