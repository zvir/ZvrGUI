package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.components.minimalDark.PanelMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.utils.Counter;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class PanelMDSkin extends ZvrSkin 
	{
		
		private var _matrix:Matrix = new Matrix();
		
		public function PanelMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
			_availbleBehaviors = [ZvrDragable, ZvrResizable, ZvrRollOverHilight];
		}
		
		
		
		override protected function create():void
		{
			_body = new ZvrFlashSkin();
			drawBackground();
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_ALPHA, drawBackground);
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FT_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
		}
		
		override protected function setStyles():void
		{	
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_NORMAL_FILL_PATERN));
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_OVER_FILL_PATERN), ZvrStates.HILIGHT);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.PANEL_NORMAL_FILL_PATERN), ZvrStates.FOCUSED);
			setStyle(ZvrStyles.BG_ALPHA, 0.5);
			
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.HILIGHT);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c1, ZvrStates.FOCUSED);
			setStyle(ZvrStyles.FR_ALPHA, 1);
			
			setStyle(ZvrStyles.FT_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.FOOTER_NORMAL_PATTERN));
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
			
		protected function drawBackground():void 
		{	
			
			var b1:* = getStyle(ZvrStyles.BG_COLOR)
			var b2:* = getStyle(ZvrStyles.FT_COLOR)
			
			sprite.graphics.clear();
			
			if (b1 && b2) 
			{
				
				/*var p:Point = new Point();
				p = _body.localToGlobal(p);
				_matrix.tx = -p.x;
				_matrix.ty = -p.y;*/
				
				
				sprite.graphics.beginBitmapFill(b1, _matrix);
				sprite.graphics.moveTo(0, 0);
				sprite.graphics.lineTo(componentWidth - 1.5, 0);
				sprite.graphics.lineTo(componentWidth - 1.5, componentHeight - 12);
				sprite.graphics.lineTo(0, componentHeight - 12);
				sprite.graphics.lineTo(0, 0);
				sprite.graphics.endFill();
				
				sprite.graphics.beginBitmapFill(b2, _matrix);
				sprite.graphics.moveTo(0, componentHeight - 12);
				sprite.graphics.lineTo(componentWidth - 1.5, componentHeight - 12);
				sprite.graphics.lineTo(componentWidth - 1.5, componentHeight - 10);
				sprite.graphics.lineTo(componentWidth - 10, componentHeight - 1.5);
				sprite.graphics.lineTo(0, componentHeight - 1.5);
				sprite.graphics.lineTo(0, componentHeight - 12);
				sprite.graphics.endFill();
				
				sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 0);
				sprite.graphics.moveTo(0, 0);
				
				sprite.graphics.lineTo(componentWidth - 1.5, 0);
				sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), getStyle(ZvrStyles.FR_ALPHA));
				sprite.graphics.lineTo(componentWidth - 1.5, componentHeight - 10);
				sprite.graphics.lineTo(componentWidth - 10, componentHeight - 1.5);
				sprite.graphics.lineTo(0, componentHeight - 1.5);
				sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 0);
				sprite.graphics.lineTo(0, 0);
			}
			
		}
		
		protected function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		protected function get panel():PanelMD
		{
			return _component as PanelMD;
		}
		
	}

}