package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrSlider;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrDragBehaviorEvent;
	import zvr.zvrGUI.events.ZvrSliderEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.InputSkinMD;

	/**
	 * ...
	 * @author Zvir
	 */
	public class SliderMD extends ZvrSlider
	{
		
		private var _areaDragBehavior:ZvrDragable;
		private var _areaRightDragBehavior:ZvrDragable;
		private var _areaLeftDragBehavior:ZvrDragable;
		
		public var _areaScaleLeft:ScrollerButtonMD;
		public var _areaScaleRight:ScrollerButtonMD;
		public var _areaButton:ScrollerButtonMD;
		
		public var _areaBar:ZvrGroup;
		
		
		public function SliderMD() 
		{
			
			super(InputSkinMD);
			
			minHeight = 10;
			minWidth = 20;
			
			_areaScaleLeft	 = new ScrollerButtonMD();
			_areaScaleRight  = new ScrollerButtonMD();
			_areaButton = new ScrollerButtonMD();
			
			_areaScaleRight.right = 0;
			
			_areaBar = new ZvrGroup();
			_areaBar.autoSize = ZvrAutoSize.MANUAL;
			
			_areaBar.top = 1;
			_areaBar.bottom = 1;
			
			_areaBar.minWidth = 10;
			
			_areaScaleLeft.percentHeight = 100;
			_areaScaleRight.percentHeight = 100;
			_areaButton.percentHeight = 100;
			
			_areaBar.addChild(_areaButton);
			_areaBar.addChild(_areaScaleLeft);
			_areaBar.addChild(_areaScaleRight);
			
			_areaButton.width = NaN;
			//_areaButton.height = NaN;
			_areaButton.right = 4;
			_areaButton.left = 4;
			//_areaButton.top = 0;
			//_areaButton.bottom = 0;
			
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
			
			addChild(_areaBar);
			
			
			addEventListener(ZvrSliderEvent.RANGE_CHANGED, areaChanged);
			addEventListener(ZvrSliderEvent.POSITION_CHANGED, positionChanged);
			addEventListener(ZvrSliderEvent.MAX_CHANGED, limitChanged);
			addEventListener(ZvrSliderEvent.MIN_CHANGED, limitChanged);
			addEventListener(ZvrSliderEvent.DYNAMIC_RANGE_CHANGED, dynamicRangeChange);
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			addEventListener(ZvrStateChangeEvent.CHANGE, stateChangeEvent);
			
			dynamicRangeChange(null);
			
			Sprite(skin.body).addEventListener(MouseEvent.MOUSE_DOWN, backgroundClick);
			
			_behaviors.addBehavior(new ZvrRollOverHilight());
			
			_states.add(ZvrStates.NORMAL);
			
		}
		
		private function dynamicRangeChange(e:ZvrSliderEvent):void 
		{
			
			_areaScaleLeft.includeInLayout = dynamicRange;
			_areaScaleRight.includeInLayout = dynamicRange;
			
			if (dynamicRange)
			{
				_areaButton.width = NaN;
				_areaButton.right = 4;
				_areaButton.left = 4;
				_areaBar.minWidth = 18;
			}
			else
			{
				_areaButton.width = NaN;
				_areaButton.right = 0;
				_areaButton.left = 0;
				_areaBar.minWidth = 10;
			}
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.NORMAL);
			_states.define(ZvrStates.HILIGHT);
		}
		
		private function areaScaleLeftDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeBegin = (_areaBar.x + e.delta.x) / (bounds.width - _areaBar.minWidth);
		}
		
		private function areaScaleRightDraging(e:ZvrDragBehaviorEvent):void 
		{
			e.preventDefault();
			percentageRangeEnd = (_areaBar.bounds.right + e.delta.x - _areaBar.minWidth) / (bounds.width - _areaBar.minWidth);
		}
		
		private function stateChangeEvent(e:ZvrStateChangeEvent):void 
		{
			if (e.isNew(ZvrStates.DISABLED))
			{
				_areaButton.manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED);
			}
			if (e.isNew(ZvrStates.ENALBLED)) 
			{
				_areaButton.manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED);
			}
		}
		
		private function resized(e:ZvrComponentEvent):void 
		{
			updateArea();
		}
		
		private function updateArea():void 
		{			
			_areaBar.width = (scrollArea - _areaBar.minWidth) * percentageRange + _areaBar.minWidth;
			_areaBar.x = (scrollArea - _areaBar.minWidth) * percentageRangeBegin;
			
			_areaBar.maxWidth = scrollArea;
			
			if (percentageRange > 1  ) 
			{
				checkState(ZvrStates.ENALBLED) && manageStates(ZvrStates.DISABLED, ZvrStates.ENALBLED); 
			}
			else 
			{
				checkState(ZvrStates.DISABLED) && manageStates(ZvrStates.ENALBLED, ZvrStates.DISABLED); 
			}
		}
		
		private function areaDraging(e:ZvrDragBehaviorEvent = null):void 
		{
			var d:Number = 0;
			if (e)
			{
				e.preventDefault();
				d = e.delta.x;
			}
			percentagePosition = (_areaBar.x + e.delta.x) / (bounds.width - _areaBar.minWidth);
			
		}
		
		private function limitChanged(e:ZvrSliderEvent):void 
		{
			updateArea();
			positionChanged(null);
		}
		
		private function backgroundClick(e:MouseEvent):void 
		{
			percentagePosition = (mouseX - _areaBar.bounds.width / 2) / (bounds.width - _areaBar.bounds.width);
			_areaDragBehavior.startDrag(_areaButton);
		}
		
		private function positionChanged(e:ZvrSliderEvent):void 
		{
			_areaBar.x = workArea * percentagePosition;
		}
		
		private function areaChanged(e:ZvrSliderEvent):void 
		{
			updateArea();
		}
		
		private function get scrollArea():Number
		{
			return bounds.width;
		}
		
		private function get workArea():Number
		{
			return bounds.width - _areaBar.bounds.width;
		}
		
	}

}