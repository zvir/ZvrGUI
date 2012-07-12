package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrBringToFrontBehavior;
	import zvr.zvrGUI.behaviors.ZvrDisable;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.components.minimalDark.TestPanel;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class WindowMDSkin extends ZvrSkin 
	{
		public static const STATUS_LABEL_COLOR:String = "statusLabelColor";
		
		private var _blend:Sprite;
		
		public function WindowMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
			_availbleBehaviors = [ZvrDragable, ZvrRollOverHilight, ZvrBringToFrontBehavior, ZvrResizable];
		}
		
		override protected function setStyles():void 
		{
			registerStyle(STATUS_LABEL_COLOR, window.status.getStylesRegistration(ZvrStyles.LABEL_COLOR));
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
			
			setStyle(STATUS_LABEL_COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			setStyle(STATUS_LABEL_COLOR, ColorsMD.c1, ZvrStates.OVER);
			
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.OVER);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.HILIGHT);
			
		}
		
		override protected function create():void
		{
			_body = new Sprite();
			drawBackground();
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		private function drawBackground():void 
		{
			sprite.graphics.clear();
			sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 1, false, "normal", CapsStyle.NONE);
			sprite.graphics.moveTo(componentWidth - 40.5, 14.5);
			sprite.graphics.lineTo(componentWidth - 1, 14.5);
			
			/*sprite.graphics.beginFill(0x64ADFF, 0.5);
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
			*/
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		private function get window():WindowMD
		{
			return _component as WindowMD;
		}
	}

}