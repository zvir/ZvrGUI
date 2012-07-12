package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.DisplayObjectContainer;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.events.ZvrStyleChangeEvent;
	import zvr.zvrGUI.layouts.ZvrAlignment;
	import zvr.zvrGUI.layouts.ZvrButtonLayout;
	import zvr.zvrGUI.layouts.ZvrHorizontalAlignment;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.layouts.ZvrVerticalAlignment;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.ButtonMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextureFillsMD;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ButtonMD extends ZvrButton 
	{
		private var _label:LabelMD = new LabelMD();
		private var _icon:ZvrBitmap = new ZvrBitmap();
		
		public function ButtonMD(skin:Class = null) 
		{

			super(skin ? skin : ButtonMDSkin);
			
			autoSize = ZvrAutoSize.CONTENT;
			
			minWidth = 16;
			minHeight = 16;
			
			//_behaviors.addBehavior(new ZvrDragable());
			
			contentPadding.padding = 4;
			
			super.setLayout(ZvrButtonLayout);
			buttonLayout.gap = 2;
			buttonLayout.alignment = ZvrAlignment.HORIZONTAL;
			buttonLayout.horizontalAlign = ZvrHorizontalAlignment.CENTER;
			buttonLayout.verticalAlign = ZvrVerticalAlignment.MIDDLE;
			
			
			addChild(_icon);
			_icon.includeInLayout = false;
			_icon.addEventListener(ZvrStyleChangeEvent.CHANGE, iconStyleChange);
			_icon.delegateStates = this;
			
			// TODO remove after tests;
			//_icon.bitmap = TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_16);
			
			addChild(_label);
			_label.includeInLayout = false;
			_label.labelAutoSize = true;
			_label.delegateStates = this;
			_label.top = -2;
			_label.addEventListener(ZvrLabelEvent.TEXT_CHANGE, labelChange);
			mouseChildren = false;
			
			
		}
		
		private function labelChange(e:ZvrLabelEvent):void 
		{
			_label.includeInLayout = e.content != "";
		}
		
		private function iconStyleChange(e:ZvrStyleChangeEvent):void 
		{
			if (e.styleName !=  ZvrStyles.BITMAP) return;
			var bitmap:Boolean = (e.value != null);
			if (_icon.includeInLayout != bitmap) _icon.includeInLayout = bitmap;
		}
		
		public function get buttonLayout():ZvrButtonLayout
		{
			return layout as ZvrButtonLayout;
		}
		
		override public function setLayout(layout:Class):void 
		{
			throw new Error("Cannot change button layout");
		}
		
		public function get label():LabelMD 
		{
			return _label;
		}
		
		override protected function get cointainer():DisplayObjectContainer
		{
			return _skin.body as DisplayObjectContainer;
		}
		
		public function get icon():ZvrBitmap 
		{
			return _icon;
		}
		
	}

}