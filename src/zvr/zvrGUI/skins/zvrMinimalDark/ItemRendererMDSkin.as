package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.core.ZvrButton;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.events.ZvrStyleChangeEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ItemRendererMDSkin extends ZvrSkin 
	{
		private var _matrix:Matrix = new Matrix();
		
		public function ItemRendererMDSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void
		{
			_body = new Sprite();
			_component.addEventListener(ZvrStateChangeEvent.CHANGE, stateChange);
			drawBackground();
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		override protected function registerStyles():void
		{
			registerStyle(ZvrStyles.BG_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_TOP_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_BOTTOM_COLOR, drawBackground);
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_BOTTOM_WEIGHT, drawBackground);
			registerStyle(ZvrStyles.FR_TOP_WEIGHT, drawBackground);
		}	
			
		override protected function setStyles():void
		{	
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_NORMAL_PATERN), ZvrStates.NORMAL);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_OVER_PATERN), ZvrStates.OVER);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_OVER_PATERN), [ZvrStates.SELECTED, ZvrStates.NORMAL]);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_DOWN_PATERN), ZvrStates.DOWN);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_DOWN_OVER_PATERN), [ZvrStates.DOWN, ZvrStates.OVER]);
			
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c2, ZvrStates.OVER);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c1, [ZvrStates.SELECTED, ZvrStates.NORMAL]);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c1, [ZvrStates.SELECTED, ZvrStates.OVER]);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c6, [ZvrStates.DOWN, ZvrStates.OVER]);
			
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c5, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c5, ZvrStates.OVER);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c4, [ZvrStates.SELECTED, ZvrStates.NORMAL]);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c4, [ZvrStates.SELECTED, ZvrStates.OVER]);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c2, [ZvrStates.DOWN, ZvrStates.OVER]);
			
			setStyle(ZvrStyles.FR_BOTTOM_WEIGHT, 2, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_BOTTOM_WEIGHT, 1, ZvrStates.DOWN);
			
			setStyle(ZvrStyles.FR_TOP_WEIGHT, 1, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_TOP_WEIGHT, 2, ZvrStates.DOWN);
			
			setStyle(ZvrStyles.BG_ALPHA, 1);
			setStyle(ZvrStyles.FR_ALPHA, 1);
			
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
		}
		
		
		
		private function drawBackground():void 
		{
			sprite.graphics.clear();
			
			var v:* = getStyle(ZvrStyles.BG_COLOR)
			
			if (v) 
			{
				sprite.graphics.beginBitmapFill(v, _matrix);
				sprite.graphics.drawRect(0, 0, componentWidth, componentHeight - 1);
				sprite.graphics.endFill();
			}
			var w:Number
			w = getStyle(ZvrStyles.FR_TOP_WEIGHT);
			sprite.graphics.lineStyle(w, getStyle(ZvrStyles.FR_TOP_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
			sprite.graphics.moveTo(0, w/2);
			sprite.graphics.lineTo(componentWidth, w/2);
			sprite.graphics.endFill();
			
			w = getStyle(ZvrStyles.FR_BOTTOM_WEIGHT);
			sprite.graphics.lineStyle(w, getStyle(ZvrStyles.FR_BOTTOM_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
			sprite.graphics.moveTo(0, componentHeight - w/2);
			sprite.graphics.lineTo(componentWidth, componentHeight - w/2);
			sprite.graphics.endFill();
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			_matrix = new Matrix();
			if (e.newStates.indexOf(ZvrStates.OVER) != -1)
				_body.addEventListener(Event.ENTER_FRAME, enterFrame);
			else if (e.newStates.indexOf(ZvrStates.NORMAL) != -1)
				_body.removeEventListener(Event.ENTER_FRAME, enterFrame);
				
		}
		
		private function enterFrame(e:Event):void 
		{
			
			_matrix.ty += 1;
			if (_matrix.ty % 4 == 0) _matrix.ty = 0;
			drawBackground();
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
	}

}