package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
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
	import zvr.zvrGUI.skins.zvrMinimalDark.HScrollMDSkin;
	import zvr.zvrGUI.skins.ZvrStyles;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class HScrollMD extends ZvrScroll
	{
		private var _areaDragBehavior:ZvrDragable;
		private var _areaRightDragBehavior:ZvrDragable;
		private var _areaLeftDragBehavior:ZvrDragable;
		
		public var _lessButton:ScrollerButtonMD;
		public var _moreButton:ScrollerButtonMD;
		
		public var _areaScaleLeft:ScrollerButtonMD;
		public var _areaScaleRight:ScrollerButtonMD;
		public var _areaButton:ScrollerButtonMD;
		
		public var _areaBar:ZvrGroup;
		
		public var _backgroundButton:ScrollerButtonMD;
		
		public function HScrollMD() 
		{
			super(HScrollMDSkin);
			
			minHeight = 3;
			
			_backgroundButton = new ScrollerButtonMD();
			
			_lessButton = new ScrollerButtonMD();
			_moreButton = new ScrollerButtonMD();
			
			_areaScaleLeft	 = new ScrollerButtonMD();
			_areaScaleRight  = new ScrollerButtonMD();
			_areaButton = new ScrollerButtonMD();
			
			_areaBar = new ZvrGroup();
			_areaBar.autoSize = ZvrAutoSize.CONTENT;
			
			_areaBar.addChild(_areaButton);
			_areaBar.addChild(_areaScaleLeft);
			_areaBar.addChild(_areaScaleRight);
			
			_areaButton.right = 4;
			_areaButton.left = 4;
			
			_areaDragBehavior = new ZvrDragable();
			_areaBar.behaviors.addBehavior(_areaDragBehavior);
			_areaDragBehavior.vertical = false;
			_areaDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaDraging);
			_areaDragBehavior.addHandler(_areaButton.skin.body as Sprite);
			
			_areaRightDragBehavior = new ZvrDragable();
			_areaScaleRight.behaviors.addBehavior(_areaRightDragBehavior);
			_areaRightDragBehavior.vertical = false;
			_areaRightDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaScaleRightDraging);
			
			_areaLeftDragBehavior = new ZvrDragable();
			_areaScaleLeft.behaviors.addBehavior(_areaLeftDragBehavior);
			_areaLeftDragBehavior.vertical = false;
			_areaLeftDragBehavior.addEventListener(ZvrDragBehaviorEvent.DRAGING, areaScaleLeftDraging);
			
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
			_moreButton.right = 0;
			height = 3;
			
			_backgroundButton.left = 3;
			_backgroundButton.right = 3;
			_backgroundButton.setStyle(ZvrStyles.BG_ALPHA, 0.3, ZvrStates.OVER);
			_backgroundButton.setStyle(ZvrStyles.BG_ALPHA, 0.1);
			
		}
		
		private function areaScaleLeftDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeBegin = (_areaBar.x + e.delta.x) / scrollArea;
		}
		
		private function areaScaleRightDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeEnd = (_areaBar.bounds.right + e.delta.x) / scrollArea;
		}
		
		private function stateChangeEvent(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew(ZvrStates.DISABLED))
			{
				_areaButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
				_lessButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
				_moreButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
			}
			if (e.isNew(ZvrStates.ENALBLED)) 
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
			_areaScaleRight.x = scrollArea * percentageRange - _areaScaleRight.bounds.width;
			
			if (_areaDragBehavior.dragging)
			{
				areaDraging();
				return;
			}
			else
			{
				_areaBar.x = _lessButton.bounds.width + workArea * percentagePosition;
			}	
			
			_areaBar.maxWidth = scrollArea;
			
			if (percentageRange > 1  ) 
			{
				checkState(ZvrStates.ENALBLED) && manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED); 
			}
			else 
			{
				checkState(ZvrStates.DISABLED) && manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED); 
			}
			updateLessMore(null);
		}
		
		private function areaDraging(e:ZvrDragBehaviorEvent = null):void 
		{
			var d:Number = 0;
			if (e)
			{
				e.preventDefault();
				d = e.delta.x;
			}
			percentagePosition = (_areaBar.x + d - _lessButton.bounds.width) / workArea;
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
			percentagePosition = (_backgroundButton.mouseX - _areaBar.bounds.width / 2) / (_backgroundButton.bounds.width - _areaBar.bounds.width);
			_areaDragBehavior.startDrag(_areaButton);
		}
		
		private function positionChanged(e:ZvrScrollEvent):void 
		{
			_areaBar.x = _lessButton.bounds.width + workArea * percentagePosition;
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
			
			if (percentagePosition >= 1)
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
			return width - _moreButton.bounds.width - _lessButton.bounds.width;
		}
		
		private function get workArea():Number
		{
			return width - _moreButton.bounds.width - _lessButton.bounds.width - _areaBar.bounds.width;
		}
		
	}

}