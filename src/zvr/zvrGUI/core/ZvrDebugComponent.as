package zvr.zvrGUI.core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import utils.display.bringToFront;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.skins.base.ZvrTextureFills;
	import zvr.zvrKeyboard.ZvrKeyboard;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDebugComponent extends Sprite
	{
		
		
		private const _alpha		:Number = 0.3;
		private const _rect			:uint = 0x00ff00;
		private const _bounds		:uint = 0xff0000;
		private const _independent	:uint = 0x0000ff;
		private const _top			:uint = 0xFF00F9;
		private const _left			:uint = 0xff0000;
		private const _right		:uint = 0x00E6FF;
		private const _bottom		:uint = 0x00E6FF;
		private const _content		:uint = 0x00E6FF;
		private const _mask			:uint = 0x00E6FF;
		
		private var _enabled:Boolean = true;
		private var _component:ZvrComponent;
		private var _componentChanged:Boolean = false;
		private var _setUpDebug:Function;
		private var _componetnMouseEnabled:Boolean;
		
		private var _hideElements:Array = new Array();
		private var _componetnMask:Sprite;
		
		public function ZvrDebugComponent(component:ZvrComponent, setUpDebug:Function) 
		{
			_setUpDebug = setUpDebug;
			_component = component;
			mouseEnabled = false;
			_component.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			ZvrKeyboard.CTRL.addPressedCallback(activateMouseEvent);
		}
		
		private function updateMouseMask(e:ZvrComponentEvent):void 
		{
			_component.graphics.clear();
			if (!_enabled) return;
			_component.graphics.beginFill(0x0ff00f, 0.05);
			_component.graphics.drawRect(0, 0, _component.bounds.width, _component.bounds.height);
			_component.graphics.endFill();
		}
		
		private function activateMouseEvent():void 
		{
			//_setUpDebug();
			_componetnMouseEnabled = _component.mouseEnabled;
			_component.mouseEnabled = true;
			_component.addEventListener(ZvrComponentEvent.RESIZE, updateMouseMask);
			updateMouseMask(null);
			
			ZvrKeyboard.CTRL.removePressedCallback(activateMouseEvent);
			ZvrKeyboard.CTRL.addReleasedCallback(deactivateMouseEvent);
		}
		
		private function deactivateMouseEvent():void 
		{
			_component.removeEventListener(ZvrComponentEvent.RESIZE, updateMouseMask);
			ZvrKeyboard.CTRL.addPressedCallback(activateMouseEvent);
			ZvrKeyboard.CTRL.removeReleasedCallback(deactivateMouseEvent);
			_component.graphics.clear();
			_component.mouseEnabled = _componetnMouseEnabled;
		}
		
		private function rollOver(e:MouseEvent):void 
		{
			_component.addEventListener(MouseEvent.ROLL_OUT, rollOut);
			_component.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			
			if (ZvrKeyboard.CTRL.pressed) activate();
			
			ZvrKeyboard.CTRL.addPressedCallback(activate);
			ZvrKeyboard.CTRL.addReleasedCallback(deactivate);
		}
		
		private function rollOut(e:MouseEvent):void 
		{
			_component.removeEventListener(MouseEvent.ROLL_OUT, rollOut);
			_component.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			
			ZvrKeyboard.CTRL.removePressedCallback(activate);
			ZvrKeyboard.CTRL.removeReleasedCallback(deactivate);
			if (ZvrKeyboard.CTRL.pressed) deactivate();
		}
		
		private function activate():void 
		{
			_component.addEventListener(ZvrComponentEvent.RESIZE, componentChange);
			_component.addEventListener(ZvrComponentEvent.MOVE, componentChange);
			
			if (_component is ZvrContainer)
			{
				var c:ZvrContainer = _component as ZvrContainer;
				c.addEventListener(ZvrContainerEvent.ELEMENT_ADDED, componentChange);
				c.addEventListener(ZvrContainerEvent.ELEMENT_REMOVED, componentChange);
				c.addEventListener(ZvrContainerEvent.CONTENT_POSITION_CHANGE, componentChange);
				c.addEventListener(ZvrContainerEvent.CONTENT_SIZE_CHANGE, componentChange);
			}
			componentChange(null);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			for (var i:int = 0; i < _hideElements.length; i++) 
			{
				_hideElements[i].visible = false;
			}
			
		}
			
		private function deactivate():void 
		{
			_component.removeEventListener(ZvrComponentEvent.RESIZE, componentChange);
			_component.removeEventListener(ZvrComponentEvent.MOVE, componentChange);
			
			if (_component is ZvrContainer)
			{
				var c:ZvrContainer = _component as ZvrContainer;
				c.removeEventListener(ZvrContainerEvent.ELEMENT_ADDED, componentChange);
				c.removeEventListener(ZvrContainerEvent.ELEMENT_REMOVED, componentChange);
				c.removeEventListener(ZvrContainerEvent.CONTENT_POSITION_CHANGE, componentChange);
				c.removeEventListener(ZvrContainerEvent.CONTENT_SIZE_CHANGE, componentChange);
			}
			componentChange(null);
			graphics.clear();
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			
			for (var i:int = 0; i < _hideElements.length; i++) 
			{
				_hideElements[i].visible = true;
			}
			
		}
		
		private function componentChange(e:*):void 
		{
			_componentChanged = true;
		}
		
		private function enterFrame(e:Event):void 
		{
			
			if (!_componentChanged) return;
			if (!_enabled) return;
			trace(_enabled);
			_componentChanged = false;
			//_setUpDebug();
			graphics.clear();
			
			draBtwRect(new Rectangle(0, 0, _component.width, _component.height), ZvrTextureFills.BLUE);
			draBtwRect(new Rectangle(0, 0, _component.bounds.width, _component.bounds.height), ZvrTextureFills.RED);
			
			if (!isNaN(_component.right)) 	drawRect(new Rectangle(_component.width, 0, _component.right, _component.bounds.height), _right, _alpha);
			if (!isNaN(_component.left)) 	drawRect(new Rectangle(-_component.left, 0, _component.left, _component.bounds.height), _bottom, _alpha);
			if (!isNaN(_component.top)) 	drawRect(new Rectangle(0, -_component.top, _component.bounds.width, _component.top), _top, _alpha);
			if (!isNaN(_component.bottom)) 	drawRect(new Rectangle(0, _component.bounds.height, _component.bounds.width, _component.bottom), _bottom, _alpha);
			
			
			//drawRect(new Rectangle(0, 0, _component.independentBounds.width, _component.independentBounds.height), _independent, _alpha); 
			
		}
		
		private function drawRect(rect:Rectangle, color:uint, alpha:Number):void
		{
			
			graphics.beginFill(color, alpha);
			graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			graphics.endFill();
			
		}
		
		private function draBtwRect(rect:Rectangle, texture:String):void
		{
			
			graphics.beginBitmapFill(ZvrTextureFills.getBitmapData(texture));
			graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
			graphics.endFill();
			
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void 
		{
			_enabled = value;
			
			if (true)
			{
				deactivate();
				_component.addEventListener(MouseEvent.ROLL_OVER, rollOver);
			}
			else
			{
				rollOut(null);
				deactivate();
				_component.removeEventListener(MouseEvent.ROLL_OVER, rollOver);
			}
			
		}
		
		public function get hideElements():Array 
		{
			return _hideElements;
		}
		
		public function set componetnMask(value:Sprite):void 
		{
			_componetnMask = value;
		}
		
	}

}