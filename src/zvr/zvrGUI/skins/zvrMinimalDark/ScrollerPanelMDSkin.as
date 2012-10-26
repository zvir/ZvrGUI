package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Graphics;
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrDisable;
	import zvr.zvrGUI.core.IZvrInteractive;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ScrollerPanelMDSkin extends ZvrSkin 
	{
		
		public function ScrollerPanelMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
			_availbleBehaviors = [ZvrDisable];
		}
		
		override protected function create():void
		{
			_shell = new ZvrFlashSkin();
			//drawBackground();
			
			_component.addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
		}
		
		override protected function setStyles():void 
		{
			super.setStyles();
			
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.FILL_PATERN_DARK_DISABLED));
			
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		private function drawBackground():void 
		{
			var graphics:Graphics = Sprite(_shell).graphics;
			
			var b:* = getStyle(ZvrStyles.BG_COLOR)
			
			if (!b) return;
			
			if (!IZvrInteractive(_component).enabled)
			{
				graphics.clear();
				graphics.beginBitmapFill(b);
				graphics.drawRect(0, 0, componentWidth, componentHeight);
				graphics.endFill();
			}
			else
			{
				graphics.clear();
			}
		}
			
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew(ZvrStates.DISABLED))
			{
				drawBackground();
			}
			else if (e.isNew(ZvrStates.ENALBLED))
			{
				Sprite(_shell).graphics.clear();
			}
		}
		
	}

}