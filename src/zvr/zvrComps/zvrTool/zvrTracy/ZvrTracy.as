package zvr.zvrComps.zvrTool.zvrTracy 
{
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.system.System;
	import flash.text.TextFormat;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.TextAreaMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.ZvrTools.ZvrTime;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTracy extends WindowMD 
	{
		
		private var _textArea:TextAreaMD = new TextAreaMD();
		private var _text:String;
		private var _texts:Array = new Array();
		private var _statusText:String;
		
		private var _options:ZvrGroup;
		
		private var _clearButton:ButtonMD = new ButtonMD();
		private var _copyToClipBoard:ButtonMD = new ButtonMD();
		private var _enableButton:ToggleButtonMD = new ToggleButtonMD();
		
		public var _patterns:Array = [
			new ZvrTracyPattern(0xff0000, /(?<=\s|^)(\S*error\S*)(?=\s|$)/gi), // error
			new ZvrTracyPattern(ColorsMD.c3, /^[0-9]+/g), // line index
			new ZvrTracyPattern(0xF9EC00, /(?!(.+\t))(?<=\W)(\d+((\.|,)\d+)?)(?=\W|$)/g), // number
			new ZvrTracyPattern(0x49FF1C, /\[.+\]/g), // [class, to string]
			new ZvrTracyPattern(ColorsMD.c4, /-{5,}/g), // dividrer : --------------
			new ZvrTracyPattern(0x40F1FF, /(?<=\s)[\w\d]+(?=:)/g), // valueName : "valueName:"
			new ZvrTracyPattern(0xff0000, /[:,.(){}"';]/g) // ,.(){}"';
			
			];
		
		private var _textFormat:TextFormat = new TextFormat();
		
		
		public function ZvrTracy() 
		{
			title.text = "ZvrTracy v1.0";
			
			_options = new ZvrGroup();
			_options.percentWidth = 100;
			_options.setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(_options.layout).gap = 1;
			_options.height = 17;
			
			_clearButton.contentPadding.padding = 0;
			_copyToClipBoard.contentPadding.padding = 0;
			_enableButton.contentPadding.padding = 0;
			
			_clearButton.label.text = "clear";
			_copyToClipBoard.label.text = "copy";
			_enableButton.disabledLabelText = "enable";
			_enableButton.enabledLabelText = "disable";
			_enableButton.selected = true;
			
			
			
			_clearButton.addEventListener(MouseEvent.CLICK, clearClick);
			_copyToClipBoard.addEventListener(MouseEvent.CLICK, copyToClipBoardClick);
			
			_options.addChild(_clearButton);
			_options.addChild(_copyToClipBoard);
			_options.addChild(_enableButton);
			addChild(_options);
			
			addChild(_textArea);
			_textArea.scroll = panel.scroller;
			_textArea.top = 17;
			_textArea.bottom = 0;
			_textArea.percentWidth = 100;
			_textArea.wrap = false;
			
			_textArea.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Mono0765);
			
			panel.scroller.verticalScroll.boundsSnap = true;
			panel.scroller.verticalScroll.snapPrority = ZvrScroll.MAX;
			_textArea.text = "Hello in ZvrTracy Component\n";
			status.text = "ready";
			
			addEventListener(Event.EXIT_FRAME, exitFrame);
			
		}
		
		public function forceUpdate():void
		{
			exitFrame(null);
		}
		
		private function exitFrame(e:Event):void 
		{
			if (!visible) return;
			
			if (!_enableButton.selected)
			{
				_texts.length = 0;
				return;
			}

			if (_texts.length == 0) return;
			
			var text:String = _texts.join("\n");
			
			_textArea.appendText(text);
			status.text = _statusText;
			
			var beginIndex:int = _textArea.text.length - text.length;
			
			for (var i:int = 0; i < _texts.length; i++) 
			{
				var t:String = _texts[i];
				
				for (var j:int = 0; j < _patterns.length; j++) 
				{
					mark(t, _patterns[j].color, _patterns[j].pattern, beginIndex);
				}
				
				beginIndex += t.length+1;
			}
			
			_text = null;
			_texts.length = 0;
			_textArea.appendText("\n");
		}
		
		private function mark(text:String, color:uint, pattern:RegExp, beginIndex:int):void
		{
			var matches:Object = pattern.exec(text);
			
			while (matches != null)
			{
				_textFormat.color = color;
				_textArea.setTextFormat(_textFormat, beginIndex + matches.index, matches.index + matches[0].length + beginIndex);
				matches = pattern.exec(text);
			}
			
		}
		
		public function addTrace(counter:uint, s:String):void 
		{
			_text = (_text ? _text : "") + "\n" + counter + "\t" + s;
			_texts.push(counter + "\t" + s);
			_statusText = s;
			
			trace(counter, s);
		}
		
		public function clear():void 
		{
			_texts.length = 0;
			_textArea.text = "Cleard\n";
		}
		
		private function clearClick(e:MouseEvent):void 
		{
			clear();
		}
		
		private function copyToClipBoardClick(e:MouseEvent):void 
		{
			System.setClipboard(_textArea.text);
			tr("Tracer content copied to clipboard");
		}
		
		
	}

}
