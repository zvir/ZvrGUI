package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextureFillsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.WindowTitleMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowTitleMD extends ZvrContainer 
	{
		
		public var titleLabel:LabelMD;
		public var icon:ZvrBitmap;
		
		public function WindowTitleMD() 
		{
			tabEnabled = false;
			
			icon = new ZvrBitmap();
			titleLabel = new LabelMD();
			
			super(WindowTitleMDSkin);
			
			minWidth = 30;
			minHeight = 15;
			
			mouseChildren = false;
			
			_behaviors.addBehavior(new ZvrRollOverHilight());
			
			icon.verticalCenter = 0;
			icon.left = 3;
			icon.delegateStates = this;
			icon.setStyle(ZvrStyles.COLOR_ALPHA, 1);
			icon.setStyle(ZvrStyles.BITMAP, TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_WHITE));
			addChild(icon);
			
			titleLabel.delegateStates = this;
			titleLabel.labelAutoSize = false;
			titleLabel.height = 15;
			titleLabel.right = 20;
			titleLabel.left = 0;
			titleLabel.cutLabel = true;
			addChild(titleLabel);
			
			_states.add(ZvrStates.NORMAL);
			
			setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(layout).gap = 2;
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.OVER);
			_states.define(ZvrStates.FOCUSED);
			_states.define(ZvrStates.HILIGHT);
		}
		
		
		override protected function updateMask():void 
		{
			_mask.graphics.clear();
			
			_mask.graphics.beginFill(0xFF0909, 1);
			_mask.graphics.lineStyle(0, 0, 0);
			_mask.graphics.moveTo(0, 0);
			_mask.graphics.lineTo(validateWidth(_bounds.width) - validateHeight(_bounds.height), 0);
			_mask.graphics.lineTo(validateWidth(_bounds.width), validateHeight(_bounds.height));
			_mask.graphics.lineTo(0, validateHeight(_bounds.height));
			_mask.graphics.lineTo(0, 0);
			
			_mask.graphics.endFill();
			
		}
		
		public function set text(value:String):void
		{
			titleLabel.text = value;
		}
		
		public function get text():String
		{
			return titleLabel.text;
		}
	}

}