package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrFlashSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrTools.ZvrPnt;
	import zvr.zvrTools.ZvrPntMath;
	/**
	 * ...
	 * @author Zvir
	 */
	public class RadialIndicatorMDSkin extends ZvrSkin
	{
		private var _value:Number = 0;
		
		public function RadialIndicatorMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void
		{
			_body = new ZvrFlashSkin();
			drawBackground();
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
			registerStyle("pointer", drawBackground);
			
		}
		
		override protected function setStyles():void
		{	
 			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_NORMAL_PATERN));
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle("pointer", ColorsMD.c1, ZvrStates.NORMAL);
		}
		
		private function drawBackground():void 
		{
			if (!sprite) return;
			
			sprite.graphics.clear();
			
			var v:* 
			v = getStyle(ZvrStyles.BG_COLOR);
			
			if (v) 
			{
				sprite.graphics.beginBitmapFill(v);
				sprite.graphics.lineStyle(1, getStyle(ZvrStyles.FR_COLOR));
				var r:Number = componentWidth < componentHeight ? componentWidth * 0.5 : componentHeight * 0.5;
				sprite.graphics.drawCircle(componentWidth * 0.5, componentHeight * 0.5, r);
				sprite.graphics.endFill();
				
				sprite.graphics.moveTo(componentWidth * 0.5, componentHeight * 0.5);
				
				var p:ZvrPnt = new ZvrPnt(componentWidth * 0.5, componentHeight * 0.5);
				
				ZvrPntMath.polar(p, r, _value);
				
				sprite.graphics.lineStyle(3, getStyle("pointer"));
				
				sprite.graphics.lineTo(p.x, p.y);
			}
			
		}
		
		
		
		public function updateValue(value:Number):void 
		{
			_value = value;
			drawBackground();
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
	}

}