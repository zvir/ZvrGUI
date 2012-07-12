package zvr.zvrGUI.core 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.relays.ZvrContainerRelay;
	import zvr.zvrGUI.core.relays.ZvrPanelRelay;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrLayout;
	import zvr.zvrGUI.skins.base.ZvrScrollerSkin;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.utils.Counter;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrScroller extends ZvrPanelRelay implements IZvrInteractive
	{
		protected var _verticalScroll:ZvrScroll;
		protected var _horizontalScroll:ZvrScroll;
		
		private var _horizontalScrollPolicy:String = ZvrScrollPolicy.AUTO;
		private var _verticalScrollPolicy:String = ZvrScrollPolicy.AUTO;
		
		//public var wheelScrollDelta:Number = 10;
		
		private var _customScroll:Boolean = false;
		
		
		public function ZvrScroller(verticalScroll:ZvrScroll, horizontalScroll:ZvrScroll, skin:Class = null, panelSkin:Class = null) 
		{
			
			if (!skin) skin = ZvrScrollerSkin;
			
			super(skin);
			
			_verticalScroll = verticalScroll;
			_horizontalScroll = horizontalScroll;
			
			if (!panelSkin) panelSkin = ZvrSkin;
			
			_contents = new ZvrDisabledContainer(panelSkin);
			
			/*_contents.contentPadding.top = 10;
			_contents.contentPadding.left = 10;
			_contents.contentPadding.right = 10;
			_contents.contentPadding.bottom = 10;*/
			
			_container.addChild(_verticalScroll);
			_container.addChild(_horizontalScroll);
			_container.addChild(_contents);
			
			_verticalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollRangeChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.MAX_CHANGED, scrollRangeChanged);
			_verticalScroll.addEventListener(ZvrScrollEvent.MIN_CHANGED, scrollRangeChanged);
			
			_horizontalScroll.addEventListener(ZvrScrollEvent.RANGE_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.MAX_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.MIN_CHANGED, scrollRangeChanged);
			_horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			
			_contents.addEventListener(ZvrContainerEvent.CONTENT_POSITION_CHANGE, contentSizeChange);
			_contents.addEventListener(ZvrContainerEvent.CONTENT_SIZE_CHANGE, contentSizeChange);
			
			addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
			
			//_contents.addEventListener(ZvrComponentEvent.RESIZE, resized)
			
		}
		
		
		private function mouseWheel(e:MouseEvent):void 
		{
			var delta:int = e.delta < 0 ? -1 : 1;
			
			if ((e.shiftKey|| !_verticalScroll.enabled) && !e.ctrlKey)
			{
				if (_horizontalScroll.enabled) _horizontalScroll.position -= delta * _horizontalScroll.step; 
			}
			else if (!e.ctrlKey)
			{
				if (_verticalScroll.enabled) _verticalScroll.position -= delta * _verticalScroll.step; 
			}
				
			if (_horizontalScrollPolicy != ZvrScrollPolicy.OFF && _horizontalScroll.dynamicRange)
			{
				if (e.ctrlKey && !e.shiftKey)
				{
					var d:Number = _horizontalScroll.range / _horizontalScroll.step * delta
					_horizontalScroll.range += d;					
					_horizontalScroll.position -= d * mouseX / bounds.width;
				}
			}
			
			if (_verticalScrollPolicy != ZvrScrollPolicy.OFF  && _verticalScroll.dynamicRange)
			{
				if (e.ctrlKey && e.shiftKey)
				{
					d = _verticalScroll.range / _verticalScroll.step * delta;
					_verticalScroll.range += d;
					_verticalScroll.position -= d * mouseY / bounds.height;
				}
			}
		}
		
		private function scrollStep(delta:int):void
		{
			
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{	
			if (!_customScroll)
			{
				updateScrollsPosition();
				updateAreaAndMax();
				scrollPositionChanged(null);
			}
			updateScrollsState();
		}
		
		private function scrollRangeChanged(e:ZvrScrollEvent):void 
		{
			updateScrollsState();
			scrollPositionChanged(null);
		}
		
		override public function set autoSize(value:String):void 
		{
			if (value == ZvrAutoSize.CONTENT)
			{
				horizontalScrollPolicy = ZvrScrollPolicy.OFF;
				verticalScrollPolicy = ZvrScrollPolicy.OFF;
			}
			_contents.autoSize = value;
		}
		
		private function contentSizeChange(e:ZvrContainerEvent):void 
		{
			if (_customScroll) return;
			updateAreaAndMax();
			updateScrollsState();
		}
		
		private function contentPositionChange(e:ZvrContainerEvent):void 
		{	
			if (_customScroll) return;
			updateScrollsPosition();
			updateScrollsState();
		}
		
		private function updateScrollsPosition():void 
		{
			setVerticalPosition(-_contents.contentRect.y);
			setHorizontalPosition(-_contents.contentRect.x);
		}
		
		private function updateAreaAndMax():void 
		{	
			_verticalScroll.range = _contents.contentAreaHeight;
			_horizontalScroll.range = _contents.contentAreaWidth;
			_verticalScroll.max = _contents.contentRect.height;
			_horizontalScroll.max = _contents.contentRect.width;
		}
		
		private function scrollPositionChanged(e:ZvrScrollEvent):void 
		{
			if (_customScroll) return;
			_contents.removeEventListener(ZvrContainerEvent.CONTENT_POSITION_CHANGE, contentPositionChange);
			_contents.setContentsPosition(-_horizontalScroll.rangeBegin, -_verticalScroll.rangeBegin);
			_contents.addEventListener(ZvrContainerEvent.CONTENT_POSITION_CHANGE, contentPositionChange);
		}
		
		private function setVerticalPosition(value:Number):void
		{	
			_verticalScroll.removeEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			_verticalScroll.rangeBegin = value;
			_verticalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
		}
		
		private function setHorizontalPosition(value:Number):void
		{	
			_horizontalScroll.removeEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
			_horizontalScroll.rangeBegin = value;
			_horizontalScroll.addEventListener(ZvrScrollEvent.POSITION_CHANGED, scrollPositionChanged);
		}
		
		private function updateScrollPolicy(scroll:ZvrScroll, policy:String):void
		{
			switch (policy) 
			{
				case ZvrScrollPolicy.ON: scroll.enabled = true;	break;
				case ZvrScrollPolicy.OFF: scroll.enabled = false; break;
			}
		}
		
		public function updateScrollsState():void
		{
			
			if (_horizontalScrollPolicy == ZvrScrollPolicy.AUTO)
			{
				_horizontalScroll.enabled = _horizontalScroll.percentageRange < 1;
			}
			
			if (_verticalScrollPolicy == ZvrScrollPolicy.AUTO)
			{
				_verticalScroll.enabled = _verticalScroll.percentageRange < 1;
			}
			
		}
		
		/* INTERFACE zvr.zvrGUI.core.IZvrInteractive */
		
		public function set enabled(value:Boolean):void 
		{
			ZvrDisabledContainer(_contents).enabled = value;
		}
		
		public function get enabled():Boolean 
		{
			return ZvrDisabledContainer(_contents).enabled;
		}
		
		public function get horizontalScrollPolicy():String 
		{
			return _horizontalScrollPolicy;
		}
		
		public function set horizontalScrollPolicy(value:String):void 
		{
			_horizontalScrollPolicy = value;
			updateScrollPolicy(_horizontalScroll, _horizontalScrollPolicy);
		}
		
		public function get verticalScrollPolicy():String 
		{
			return _verticalScrollPolicy;
		}
		
		public function set verticalScrollPolicy(value:String):void 
		{
			_verticalScrollPolicy = value;
			updateScrollPolicy(_verticalScroll, _verticalScrollPolicy);
		}
		
		public function get customScroll():Boolean 
		{
			return _customScroll;
		}
		
		public function set customScroll(value:Boolean):void 
		{
			if (_customScroll == value) return;
			
			_customScroll = value;
			
			if (_customScroll) 
				prepareForCustomScroll();
			else
				preapareForStandartScroll()
		}
		
		protected function prepareForCustomScroll():void
		{
			_contents.autoSize = ZvrAutoSize.MANUAL;
			setContentsPosition(0, 0);
			_contents.percentWidth = 100;
			_contents.percentHeight = 100;
		}
		
		protected function preapareForStandartScroll():void
		{
			_contents.autoSize = ZvrAutoSize.CONTENT;
			resized(null);
		}
		
		public function get verticalScroll():ZvrScroll 
		{
			return _verticalScroll;
		}
		
		public function get horizontalScroll():ZvrScroll 
		{
			return _horizontalScroll;
		}
		
	}
	
}