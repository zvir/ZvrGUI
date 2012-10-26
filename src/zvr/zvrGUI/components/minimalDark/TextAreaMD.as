package zvr.zvrGUI.components.minimalDark 
{
	import flash.text.TextFormat;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrLabel;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.core.ZvrScrollPolicy;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.skins.base.ZvrTextFormatStyle;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextAreaMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class TextAreaMD extends ZvrLabel 
	{
		
		private var _scroll:ZvrScroller;
		
		public function TextAreaMD() 
		{
			super(TextAreaMDSkin);
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			updateScroll();
		}
		
		public function set labelAutoSize(value:Boolean):void 
		{
			TextAreaMDSkin(_skin).autoSize = value;
		}
		
		public function get labelAutoSize():Boolean 
		{
			return TextAreaMDSkin(_skin).autoSize;
		}
		
		public function set scroll(value:ZvrScroller):void 
		{
			_scroll = value;
			
			_scroll.customScroll = true;
			_scroll.horizontalScrollPolicy = wrap ? ZvrScrollPolicy.OFF : ZvrScrollPolicy.AUTO;
			//_scroll.verticalScrollPolicy = ZvrScrollPolicy.ON;
			_scroll.verticalScroll.min = 0;
			_scroll.verticalScroll.position = 0;
			_scroll.verticalScroll.max = 0;
			_scroll.verticalScroll.range = 0;
			_scroll.verticalScroll.minRange = 1;
			_scroll.verticalScroll.snapPrority = ZvrScroll.MAX;
			_scroll.verticalScroll.step = 1;
			_scroll.verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollVPositionChanged);
			_scroll.horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollHPositionChanged);
			updateScroll();
		}
		
		override public function set text(value:String):void 
		{
			super.text = value;
			updateScroll();
		}
		
		override public function appendText(value:String):void 
		{
			super.appendText(value);
			updateScroll();
		}
		
		private function updateScroll():void
		{
			var scrollingProp:Object = skinBody.scrollingProperties;
			
			if (!_scroll) return;
			
			var m:Number = scrollingProp.textHeight /  scrollingProp.numLines;
			
			_scroll.verticalScroll.min = m;
			_scroll.verticalScroll.range = (scrollingProp.numLines - scrollingProp.maxV) * m;
			_scroll.verticalScroll.max = scrollingProp.numLines * m+m;
			_scroll.verticalScroll.step = m;
			
			
			if (!wrap)
			{
				_scroll.horizontalScroll.min = 0;
				_scroll.horizontalScroll.range = scrollingProp.rangeH + 10;
				_scroll.horizontalScroll.max = scrollingProp.maxH + scrollingProp.rangeH + 10;
				_scroll.horizontalScroll.step = 10;
			}
			
			_scroll.updateScrollsState();
			
		}
		
		public function setTextFormat(format:TextFormat, beginIndex:int=-1, endIndex:int=-1):void
		{
			skinBody.setTextFormat(format, beginIndex, endIndex);
		}
		
		private function scrollVPositionChanged(e:ZvrScrollEvent):void 
		{
			skinBody.updateVScrolling(e.scroll.position);
		}
		
		private function scrollHPositionChanged(e:ZvrScrollEvent):void 
		{
			skinBody.updateHScrolling(e.scroll.position);
		}
		
		private function get skinBody():TextAreaMDSkin
		{
			return TextAreaMDSkin(_skin);
		}
		
		public function get wrap():Boolean 
		{
			return skinBody.wrap;
		}
		
		public function set wrap(value:Boolean):void 
		{
			skinBody.wrap = value;
			if (_scroll) _scroll.horizontalScrollPolicy = value ? ZvrScrollPolicy.OFF : ZvrScrollPolicy.AUTO;
		}
		
		/*public function markSubString(beginIndex:int, endIndex:int, color:uint):void
		{
			body.markSubString(beginIndex, endIndex, color);
		}*/
		
	}

}