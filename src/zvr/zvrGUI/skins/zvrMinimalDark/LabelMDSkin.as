package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	import zvr.zvrGUI.skins.base.ZvrFlashSkin;

	//import flash.text.TextInteractionMode;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.base.ZvrTextFormatStyle;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class LabelMDSkin extends ZvrSkin
	{
		
		
		// TODO Clean up methods
		
		protected var _textField:TextField;
		protected var _autoSize:Boolean = true;
		protected var _multiline:Boolean = false;
		private var _cutLabel:Boolean = false;
		private var _dotsWidth:Number;
		
		public function LabelMDSkin(label:ZvrComponent, registration:Function) 
		{
			super(label, registration);
			label.addEventListener(ZvrLabelEvent.TEXT_CHANGE, textChange);
		}
		
		override protected function create():void 
		{
			
			_textField = new TextField();
			_textField.embedFonts = true; 
			_textField.autoSize = TextFieldAutoSize.LEFT;
			_textField.multiline = false;
			//_textField.textInteractionMode
			//_textField.border = true;
			
			setFont();
			setColor();
			
			_textField.addEventListener(Event.CHANGE, textInput);
			_textField.selectable = false;
			_textField.antiAliasType = AntiAliasType.NORMAL;
			//_textField.filters = new Array(new DropShadowFilter(1, 45, 0x000000, 0.9, 1, 1, 5, 3));
			
			_body = new ZvrFlashSkin();
			Sprite(_body).addChild(_textField);
			
			//_body = _textField;
			
		}
		
		private function textInput(e:Event):void 
		{
			updateSize();
			updateCompSize();
		}
		
		override protected function registerStyles():void 
		{	
			registerStyle(ZvrStyles.LABEL_COLOR, setColor);
			registerStyle(ZvrStyles.LABEL_FONT, setFont);
			registerStyle(ZvrStyles.LABEL_FONT_SIZE, setFont);
			registerStyle(ZvrStyles.LABEL_ALIGN, changeAlign);
		}
		
		override protected function setStyles():void 
		{	
			setStyle(ZvrStyles.LABEL_COLOR, ColorsMD.c2);
			setStyle(ZvrStyles.LABEL_FONT, MDFonts.Stan0753);
			setStyle(ZvrStyles.LABEL_FONT_SIZE, 8);
			setStyle(ZvrStyles.LABEL_ALIGN, TextFormatAlign.LEFT);
		}
		
		private function changeAlign():void 
		{
			var tf:TextFormat = _textField.getTextFormat();
			tf.align = getStyle(ZvrStyles.LABEL_ALIGN);
			_textField.setTextFormat(tf);
		}
		
		override protected function updateSize():void 
		{
			
			if (_autoSize && !_multiline) return;
			
			if (_multiline && _textField.width != componentWidth)
			{
				_textField.width = componentWidth;
				updateComponentSize(componentWidth, _textField.height);
				drawBck()
				return;
			}
			
			if (!_autoSize)
			{
				_textField.width = componentWidth;	
				_textField.height = componentHeight;
			}
			
			if (_cutLabel) checkLabelCut();
			
			//drawBck();
		}
		
		// TODO remove after tests
		
		private function drawBck():void
		{
			return;
			var sp:Sprite = _body as Sprite;
			sp.graphics.clear();
			sp.graphics.beginFill(0x137D1C, 0.7);
			sp.graphics.lineStyle(1, 0x87ED8E, 0.8);
			sp.graphics.drawRect(0, 0, componentWidth, componentHeight);
		}
		
		private function textChange(e:ZvrLabelEvent):void 
		{
			
			switch (e.kind)
			{
				case ZvrLabelChangeKind.REPLACE : _textField.text = e.component.text; break;
				case ZvrLabelChangeKind.APPEND : _textField.appendText(e.content); break;
			}
			
			if (_autoSize) updateCompSize();
		}
		
		protected function updateCompSize():void
		{
			if (!_autoSize) return;
			
			_width = _textField.width;
			_height = _textField.height;
			
			updateComponentSize(_width, _height);
			drawBck();
		}
		
		private function get label():ZvrLabel { return _component as ZvrLabel; }
		
		public function get autoSize():Boolean 
		{
			return _autoSize;
		}
		
		public function set autoSize(value:Boolean):void 
		{
			_autoSize = value;
			
			if (_autoSize)
			{
				_textField.autoSize = TextFieldAutoSize.LEFT;
				updateCompSize();
			}
			else
			{
				_textField.autoSize = TextFieldAutoSize.NONE;
				updateSize();
			}
			
			if (_cutLabel) checkLabelCut();
			
		}
		
		public function set multiline(value:Boolean):void 
		{
			_multiline = value;
			_textField.multiline = _multiline;
			_textField.wordWrap = _multiline;
			updateSize();
			updateCompSize();
		}
		
		
		public function get multiline():Boolean 
		{
			return _multiline;
		}
		
		public function set cutLabel(value:Boolean):void
		{
			_cutLabel = value;
			if (_cutLabel) checkLabelCut();
		}
		
		public function get cutLabel():Boolean
		{
			return _cutLabel;
		}
		
		public function get textField():TextField 
		{
			return _textField;
		}
		
		private function checkLabelCut():void
		{
			if (_autoSize) return;
			if (!_cutLabel) return;
			
			_textField.text = label.text;
			
			if (_textField.textWidth < componentWidth - _dotsWidth - 5) return;
			
			var lastChar:int = _textField.getCharIndexAtPoint(componentWidth-_dotsWidth, componentHeight/2);
			
			if (lastChar != -1)
			{
				_textField.text = _textField.text.substring(0, lastChar) + "...";
			}
			
		}
		
		private function setFont():void 
		{
			var tf:TextFormat = _textField.getTextFormat();
			tf.font = getStyle(ZvrStyles.LABEL_FONT)
			tf.size = getStyle(ZvrStyles.LABEL_FONT_SIZE);
			_textField.defaultTextFormat = tf;
			_textField.setTextFormat(tf);
			getDotsWidth();
		}
		
		private function setColor():void 
		{ 
			var value:* = getStyle(ZvrStyles.LABEL_COLOR);
			var tf:TextFormat = _textField.getTextFormat();
			tf.color = value;
			_textField.defaultTextFormat = tf;
			_textField.setTextFormat(tf);
		}
		
		
		private function getDotsWidth():void
		{
			var t:String = _textField.text;
			_textField.text = "...";
			_dotsWidth = _textField.textWidth;
			_textField.text = t;
		}
		
	}

}