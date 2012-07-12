package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import zvr.zvrGUI.components.minimalDark.TextAreaMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.base.ZvrTextFormatStyle;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class TextAreaMDSkin extends LabelMDSkin 
	{
		
		private var _textMarks:Vector.<ZvrTextFormatStyle> = new Vector.<ZvrTextFormatStyle>;
		
		private var _blend:Sprite;
		
		public function TextAreaMDSkin(textArea:TextAreaMD, registration:Function) 
		{
			super(textArea, registration);
		}
		
		override protected function create():void 
		{
			super.create();
			_textField.multiline = true;
			_autoSize = false;
			_textField.wordWrap = true;
			_textField.autoSize = TextFieldAutoSize.NONE;
			_textField.mouseWheelEnabled = false;
			
			_body = new Sprite();
			Sprite(_body).addChild(_textField);
			
			_blend = new Sprite();
			Sprite(_body).addChild(_blend);
			
		}
		
		override protected function updateSize():void 
		{
			_textField.width = componentWidth;
			_textField.height = componentHeight;
			
			_blend.graphics.clear();
			_blend.graphics.beginFill(0x000000, 0);
			_blend.graphics.drawRect(0, 0, componentWidth, componentHeight);
			_blend.graphics.endFill();
		}
		
		private function get textArea():TextAreaMD
		{
			return TextAreaMD(_component);
		}
		
		public function updateVScrolling(position:int):void
		{
			//trace(position);
			position = position / (_textField.textHeight /  _textField.numLines)
			_textField.scrollV = position;
		}
		
		public function updateHScrolling(position:int):void
		{
			_textField.scrollH = position;
		}
		
		public function set wrap(value:Boolean):void 
		{
			_textField.wordWrap = value;
		}
		
		public function get wrap():Boolean 
		{
			return _textField.wordWrap;
		}
		
		public function resetMarks():void
		{
			_textMarks.length = 0;
		}
		
		public function setTextFormat(format:TextFormat, beginIndex:int=-1, endIndex:int=-1):void
		{
			//if (beginIndex >= _textField.text.length || endIndex >= _textField.text.length) return;
			_textField.setTextFormat(format, beginIndex, endIndex);
		}
		
		
		public function get scrollingProperties():Object
		{
			return {
				maxV		:_textField.maxScrollV, 
				numLines	:_textField.numLines,
				maxH		:_textField.maxScrollH,
				rangeH		:_textField.width,
				textHeight	:_textField.textHeight
			}
		}
		
	}


}


		/*
		public function markSubString(beginIndex:int, endIndex:int, color:uint):void
		{
			if (beginIndex < 0) return;
			if (endIndex > _textField.text.length) return;
			
			var textStyle:ZvrTextFormatStyle = new ZvrTextFormatStyle();
			textStyle.beginIndex = beginIndex;
			textStyle.endIndex = endIndex;
			textStyle.textFormat = _textField.getTextFormat();
			textStyle.textFormat.color = color;
			
			_textMarks.push(textStyle);
			wch(this, "textMarks", _textMarks.length);
			updateMarks(beginIndex);
		}
		
		private function updateMarks(beginIndex:int = 0):void
		{
			for (var i:int = 0; i < _textMarks.length; i++) 
			{
				var textStyle:ZvrTextFormatStyle = _textMarks[i];
				if (textStyle.beginIndex <= beginIndex)
				{
					setTextStyle(textStyle);
				}
			}
		}
		
		private function setTextStyle(textStyle:ZvrTextFormatStyle):void
		{
			_textField.setTextFormat(textStyle.textFormat, textStyle.beginIndex, textStyle.endIndex);
		}
		*/