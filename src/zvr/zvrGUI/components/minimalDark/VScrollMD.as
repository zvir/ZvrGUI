package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrDragBehaviorEvent;
	import zvr.zvrGUI.events.ZvrScrollEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.VScrollMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class VScrollMD extends ZvrScroll
	{
		private var _areaDragBehavior:ZvrDragable;
		private var _areaBottomDragBehavior:ZvrDragable;
		private var _areaTopDragBehavior:ZvrDragable;
		
		public var _lessButton:ScrollerButtonMD;
		public var _moreButton:ScrollerButtonMD;
		
		public var _areaScaleTop:ScrollerButtonMD;
		public var _areaScaleBottom:ScrollerButtonMD;
		public var _areaButton:ScrollerButtonMD;
		
		public var _areaBar:ZvrGroup;
		
		public var _backgroundButton:ScrollerButtonMD;
		
		public function VScrollMD() 
		{
			super(VScrollMDSkin);
			
			minWidth = 3;
			
			_backgroundButton = new ScrollerButtonMD();
			
			_lessButton = new ScrollerButtonMD();
			_moreButton = new ScrollerButtonMD();
			
			_areaScaleTop	 = new ScrollerButtonMD();
			_areaScaleBottom  = new ScrollerButtonMD();
			_areaButton = new ScrollerButtonMD();
			
			_areaBar = new ZvrGroup();
			_areaBar.autoSize = ZvrAutoSize.CONTENT;
			
			_areaBar.addChild(_areaButton);
			_areaBar.addChild(_areaScaleTop);
			_areaBar.addChild(_areaScaleBottom);
			
			_areaButton.top = 4;
			_areaButton.bottom = 4;
			
			_areaDragBehavior = new ZvrDragable();
			_areaBar.behaviors.addBehavior(_areaDragBehavior);
			_areaDragBehavior.horizontal = false;
			_areaDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaDraging);
			_areaDragBehavior.addHandler(_areaButton.skin.body as Sprite);
			
			_areaBottomDragBehavior = new ZvrDragable();
			_areaScaleBottom.behaviors.addBehavior(_areaBottomDragBehavior);
			_areaBottomDragBehavior.horizontal = false;
			_areaBottomDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaScaleBottomDraging);
			
			_areaTopDragBehavior = new ZvrDragable();
			_areaScaleTop.behaviors.addBehavior(_areaTopDragBehavior);
			_areaTopDragBehavior.horizontal = false;
			_areaTopDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaScaleTopDraging);
			
			addChild(_backgroundButton);
			addChild(_lessButton);
			addChild(_moreButton);
			addChild(_areaBar);
			
			addEventListener(ZvrScrollEvent.RANGE_CHANGED, areaChanged);
			addEventListener(ZvrScrollEvent.POSITION_CHANGED, positionChanged);
			addEventListener(ZvrScrollEvent.POSITION_CHANGED, updateLessMore);
			addEventListener(ZvrScrollEvent.MAX_CHANGED, limitChanged);
			addEventListener(ZvrScrollEvent.MIN_CHANGED, limitChanged);
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChangeEvent);
			
			_moreButton.addEventListener(MouseEvent.CLICK, moreClick);
			_lessButton.addEventListener(MouseEvent.CLICK, lessClick);
			_backgroundButton.addEventListener(MouseEvent.MOUSE_DOWN, backgroundClick);
			
			_backgroundButton.top = 3;
			_backgroundButton.bottom = 3;
			_backgroundButton.setStyle(ZvrStyles.BG_ALPHA, 0.3, ZvrStates.OVER);
			_backgroundButton.setStyle(ZvrStyles.BG_ALPHA, 0.1);
			
			_moreButton.bottom = 0;
			width = 3;
			
		}
		
		private function areaScaleTopDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeBegin = (_areaBar.y + e.delta.y) / scrollArea;
		}
		
		private function areaScaleBottomDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeEnd = (_areaBar.bounds.bottom + e.delta.y) / scrollArea;
		}
		
		private function stateChangeEvent(e:ZvrStateChangeEvent):void 
		{
			if (e.newStates.indexOf(ZvrStates.DISABLED) != -1)
			{
				_areaButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
				_lessButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
				_moreButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
			}
			if (e.newStates.indexOf(ZvrStates.ENALBLED) != -1)
			{
				_areaButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
				_lessButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
				_moreButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
			}
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			updateArea();
		}
		
		private function updateArea():void 
		{
			_areaScaleBottom.y = scrollArea * percentageRange - _areaScaleBottom.bounds.height;
			
			if (_areaDragBehavior.dragging)
			{
				areaDraging();
				return;
			}
			else
			{
				_areaBar.y = _lessButton.bounds.height + workArea * percentagePosition;
			}
			
			_areaBar.maxHeight = scrollArea;
			
			if (percentageRange >= 1 && !checkState(ZvrStates.DISABLED) ) 
			{
				manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED); 
			}
			else if (percentageRange < 1 && !checkState(ZvrStates.ENALBLED) ) 
			{
				manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED); 
			}
			updateLessMore(null);
		}
		
		private function areaDraging(e:ZvrDragBehaviorEvent = null):void 
		{
			var d:Number = 0;
			if (e)
			{
				e.preventDefault();
				d = e.delta.y;
			}
			
			percentagePosition = (_areaBar.y + d - _lessButton.bounds.height) / workArea;
		}
		
		private function limitChanged(e:ZvrScrollEvent):void 
		{
			updateArea();
			positionChanged(null);
		}
		
		private function moreClick(e:MouseEvent):void 
		{
			position += range;
		}
		
		private function lessClick(e:MouseEvent):void 
		{
			position -= range;
		}
		
		private function backgroundClick(e:MouseEvent):void 
		{
			percentagePosition = (_backgroundButton.mouseY - _areaBar.bounds.height / 2) / (_backgroundButton.bounds.height - _areaBar.bounds.height);
			_areaDragBehavior.startDrag(_areaButton);
		}
		
		private function positionChanged(e:ZvrScrollEvent):void 
		{
			_areaBar.y = _lessButton.bounds.height + workArea * percentagePosition;
		}
		
		private function updateLessMore(e:ZvrScrollEvent):void 
		{
			if (checkState(ZvrStates.DISABLED)) return;
			
			if (rangeBegin == min)
			{
				_lessButton.checkState(ZvrStates.DISABLED) && _lessButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED)
			}
			else
			{
				_lessButton.checkState(ZvrStates.ENALBLED) && _lessButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
			}
			
			if (Math.round(rangeEnd*100000)/100000 == max)
			{
				_moreButton.checkState(ZvrStates.DISABLED) && _moreButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED)
			}
			else
			{
				_moreButton.checkState(ZvrStates.ENALBLED) && _moreButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
			}
		}
		
		private function areaChanged(e:ZvrScrollEvent):void 
		{
			updateArea();
		}
		
		private function s(n:Number, p:* = 2):String
		{
			return Number(n).toFixed(p);
		}
		
		private function get scrollArea():Number
		{
			return height - _moreButton.bounds.height - _lessButton.bounds.height;
		}
		
		private function get workArea():Number
		{
			return height - _moreButton.bounds.height - _lessButton.bounds.height - _areaBar.bounds.height;
		}
		
	}

}