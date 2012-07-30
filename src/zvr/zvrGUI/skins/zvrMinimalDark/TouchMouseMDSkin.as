package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrTools.ZvrPnt;
	import zvr.zvrTools.ZvrPntMath;
	import zvr.zvrTools.ZvtGraphics;
	/**
	 * ...
	 * @author Zvir
	 */
	public class TouchMouseMDSkin extends ZvrSkin
	{
		
		private var _indicator:Shape;
		private var _indicatorPosition:ZvrPnt = new ZvrPnt();
										   	
		public static const T		:int = 0;
		public static const TR		:int = 45;
		public static const R		:int = 90;
		public static const BR		:int = 135;
		public static const B		:int = 180;
		public static const BL		:int = 225;
		public static const L		:int = 270;
		public static const TL		:int = 315;
		
		private var _point:Point = new Point();
		private var _p:ZvrPnt = new ZvrPnt();
		
		public function TouchMouseMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		override protected function create():void
		{
			_body = new Sprite();
			_indicator = new Shape();
			Sprite(_body).addChild(_indicator);
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_WEIGHT, drawBackground);
			
			registerStyle("indicatorPosition", updateIndicatorPosition);
			registerStyle("indicatorColor", drawBackground);
		}
		
		override protected function setStyles():void
		{
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_NORMAL_PATERN));
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_WEIGHT, 1, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_ALPHA, 1, ZvrStates.NORMAL);
			setStyle("indicatorPosition", TR);
			setStyle("indicatorColor", ColorsMD.c1);
		}
		
		private function drawBackground():void 
		{
			if (!sprite) return;
			
			sprite.graphics.clear();
			_indicator.graphics.clear();
			
			var tfw:Number = getStyle(ZvrStyles.FR_WEIGHT);
			
			var v:* 
			
			v = getStyle(ZvrStyles.BG_COLOR);
			if (v) 
			{
				sprite.graphics.lineStyle(0, 0, 0);
				sprite.graphics.beginFill(0x00F456, 0);
				ZvtGraphics.drawOctagon(sprite.graphics, -componentWidth, -componentWidth, componentWidth * 3, componentHeight * 3);
				ZvtGraphics.drawOctagon(sprite.graphics, -componentWidth/2, -componentHeight/2, componentWidth * 2, componentHeight * 2);
				sprite.graphics.endFill();	
				sprite.graphics.lineStyle(tfw, getStyle(ZvrStyles.FR_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
				
				sprite.graphics.beginBitmapFill(v);
				ZvtGraphics.drawOctagon(sprite.graphics, 0, 0, componentWidth - tfw * 2, componentHeight - tfw * 2);
				
				
				sprite.graphics.endFill();	
				
				_indicator.graphics.lineStyle(tfw, getStyle(ZvrStyles.FR_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
				_indicator.graphics.beginFill(getStyle("indicatorColor"), 1);
				ZvtGraphics.drawIsoscelesTraingle(_indicator.graphics, -componentWidth / 8, -componentHeight / 8, componentWidth / 4, componentHeight / 4);
				_indicator.graphics.endFill();
				
			}
			updateIndicatorPosition();
		}
		
		
		private function updateIndicatorPosition():void 
		{
			
			_indicatorPosition.x = componentWidth / 2;
			_indicatorPosition.y = componentHeight / 2;
			_p.copyFrom(_indicatorPosition);
			
			var a:Number = getStyle("indicatorPosition");
			var l:Number = componentHeight > componentWidth ? componentWidth * 0.8 : componentHeight * 0.8;
			
			ZvrPntMath.polar(_indicatorPosition, l, a-90);
			
			_indicator.x = _indicatorPosition.x;
			_indicator.y = _indicatorPosition.y;
			
			_indicator.rotation = a;
			
			l = componentHeight > componentWidth ? componentWidth * 0.925 : componentHeight * 0.925;
			
			ZvrPntMath.polar(_p, l, a - 90);
			
			//dot(sprite, _p.x, _p.y, 1, 0xFF2222, 1, 2);
			
			_point.x = _p.x;
			_point.y = _p.y;
		}
		
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		public function get point():Point 
		{
			return _point;
		}
		
		public function get globalPoint():Point 
		{
			return sprite.localToGlobal(_point);
		}
		
	}

}