package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.CapsStyle;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TextEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrInput;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class InputMDSkin extends LabelMDSkin
	{

		public function InputMDSkin(input:ZvrLabel, registration:Function) 
		{
			super(input, registration);
		}
		
		override protected function registerStyles():void 
		{
			super.registerStyles();
			
			registerStyle(ZvrStyles.FR_COLOR, drawFrame);
		}
		
		override protected function setStyles():void 
		{
			super.setStyles();
			
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c1, ZvrStates.FOCUSED);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c1, ZvrStates.FOCUSED);
			setStyle(ZvrStyles.FR_COLOR, ColorsMD.c2, ZvrStates.NORMAL);
			
		}
		
		override protected function create():void 
		{
			super.create();
			
			_textField.type = TextFieldType.INPUT;
			_textField.selectable = true;
			
			var t:TextFormat = _textField.getTextFormat();
			t.leftMargin = 3;
			_textField.defaultTextFormat = t;
			_textField.setTextFormat(t);
			
		}
		
		protected function drawFrame():void
		{
			getStyle(ZvrStyles.FR_COLOR);
			
			var g:Graphics = Sprite(_body).graphics;
			g.clear();
			
			//g.moveTo(0, 0);
			g.lineStyle(1, getStyle(ZvrStyles.FR_COLOR), 1, true, "normal", CapsStyle.SQUARE );
			
			
			g.moveTo(0, componentHeight);
			g.lineTo(componentWidth, componentHeight);
			g.lineTo(componentWidth, componentHeight*0.5);
			
			//g.lineTo(0, 0);
			
		}
		
		override protected function updateSize():void 
		{
			super.updateSize();
			
			drawFrame();
		}
	}

}