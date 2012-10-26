package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import zvr.zvrGUI.components.minimalDark.SliderMD;
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
	public class InputSkinMD extends ZvrSkin 
	{
		
		private var _matrix:Matrix = new Matrix();
		
		public function InputSkinMD(component:ZvrComponent, registration:Function) 
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
			registerStyle(ZvrStyles.FR_TOP_COLOR, drawBackground);
			registerStyle(ZvrStyles.FR_BOTTOM_COLOR, drawBackground);
			registerStyle(ZvrStyles.BG_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_ALPHA, drawBackground);
			registerStyle(ZvrStyles.FR_BOTTOM_WEIGHT, drawBackground);
			registerStyle(ZvrStyles.FR_TOP_WEIGHT, drawBackground);
			
			registerStyle("focusBg", drawBackground);
		}
		
		override protected function setStyles():void
		{	
			
 			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_NORMAL_PATERN), ZvrStates.NORMAL);
			setStyle(ZvrStyles.BG_COLOR, TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_OVER_PATERN), ZvrStates.HILIGHT);

			//setStyle("focusBg", null,);
			setStyle("focusBg", TextureFillsMD.getBitmapData(TextureFillsMD.BUTTON_FOCUS_PATERN), ZvrStates.FOCUSED);
			
			
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c5, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_TOP_COLOR, ColorsMD.c4, ZvrStates.HILIGHT);
			
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c3, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_BOTTOM_COLOR, ColorsMD.c2, ZvrStates.HILIGHT);
			
			setStyle(ZvrStyles.FR_BOTTOM_WEIGHT, 1, ZvrStates.NORMAL);
			setStyle(ZvrStyles.FR_TOP_WEIGHT, 2, ZvrStates.NORMAL);

			
			setStyle(ZvrStyles.BG_ALPHA, 1);
			setStyle(ZvrStyles.FR_ALPHA, 1);
			
			setStyle(ZvrStyles.COLOR, ColorsMD.c2);
			
			setStyle(ZvrStyles.COLOR_ALPHA, 1);
			setStyle(ZvrStyles.COLOR_ALPHA, 0, ZvrStates.HILIGHT);
			
		}
		
		private function drawBackground():void 
		{
			if (!sprite) return;
			
			sprite.graphics.clear();
			
			var tfw:Number = getStyle(ZvrStyles.FR_TOP_WEIGHT);
			var btf:Number = getStyle(ZvrStyles.FR_BOTTOM_WEIGHT);
			
			var v:* 
			
			v = getStyle(ZvrStyles.BG_COLOR);
			if (v) 
			{
				_matrix.ty = tfw;
				sprite.graphics.beginBitmapFill(v, _matrix);
				sprite.graphics.drawRect(0, tfw, componentWidth, componentHeight - btf - tfw);
				sprite.graphics.endFill();
			}
			
			v = getStyle("focusBg");
			if (v) 
			{
				var m:Matrix = new Matrix();
				var sy:Number = componentHeight - btf - v.height;
				sy = sy < tfw ? tfw : sy;
				m.translate(0, sy);
				m.tx = _matrix.tx + 1;
				var sh:Number = v.height > componentHeight - btf - tfw ? componentHeight - btf - tfw : v.height;
				sprite.graphics.beginBitmapFill(v, m);
				sprite.graphics.drawRect(0, sy, componentWidth,  sh);
				sprite.graphics.endFill();
			}
			
			
			sprite.graphics.lineStyle(tfw, getStyle(ZvrStyles.FR_TOP_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
			sprite.graphics.moveTo(0, tfw/2);
			sprite.graphics.lineTo(componentWidth, tfw / 2);
			
			sprite.graphics.lineStyle(btf, getStyle(ZvrStyles.FR_BOTTOM_COLOR), getStyle(ZvrStyles.FR_ALPHA), true, "normal", CapsStyle.NONE);
			sprite.graphics.moveTo(0, componentHeight - btf/2);
			sprite.graphics.lineTo(componentWidth, componentHeight - btf / 2);
			
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		private function stateChange(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew(ZvrStates.HILIGHT))
				_body.addEventListener(Event.ENTER_FRAME, enterFrame);
			else if (e.isRemoved(ZvrStates.HILIGHT))
				_body.removeEventListener(Event.ENTER_FRAME, enterFrame);
			
			if (e.newStates.indexOf(ZvrStates.DISABLED) != -1)
			{
				spriteBody.alpha = 0.5;
				drawBackground();
			}
			else if (e.removedStates.indexOf( ZvrStates.DISABLED) != -1)
			{
				spriteBody.alpha = 1;
				drawBackground();
			}
			
			//trace(button.currentStates == button.label.currentStates, button.currentStates, button.label.currentStates);
		}
		
		private function enterFrame(e:Event):void 
		{
			_matrix.tx += 0.5;
			if (_matrix.tx % 4 == 0) _matrix.tx = 0;
			drawBackground();
		}

		private function get spriteBody():Sprite
		{
			return _body as Sprite;
		}

	}

}