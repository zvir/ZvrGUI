package zvr.zvrGUI.behaviors 
{
	import flash.display.InteractiveObject;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrExplicitBounds;
	import zvr.zvrGUI.core.ZvrExplicitReport;
	import zvr.zvrGUI.events.ZvrResizeBehaviorEvent;
	import zvr.zvrGUI.utils.Counter;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	[Event(name = "resize",				type = "zvr.zvrGUI.events.ZvrResizeBehaviorEvent")]
	[Event(name = "resizing",			type = "zvr.zvrGUI.events.ZvrResizeBehaviorEvent")]
	[Event(name = "startResize",		type = "zvr.zvrGUI.events.ZvrResizeBehaviorEvent")]
	[Event(name = "stopResize",			type = "zvr.zvrGUI.events.ZvrResizeBehaviorEvent")]
	
	public class ZvrResizable extends ZvrBehavior 
	{
		
		public static const NAME:String = "Resizable";
		
		private var _point:Point = new Point();
		private var _resizeHandlers:/*InteractiveObject*/Array = new Array();
		
		public function ZvrResizable(resizeHandler:ZvrComponent) 
		{
			resizeHandler && addHandler(resizeHandler);
			super(NAME);
			_stageSensitive = true;
		}
		
		override protected function enable():void 
		{
			if (!enabled) return;
			
			if (component.autoSize == ZvrAutoSize.CONTENT)
				component.autoSize = ZvrAutoSize.MANUAL;
				
			for (var i:int = 0; i < _resizeHandlers.length; i++) 
			{
				_resizeHandlers[i].addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			
		}
		
		override protected function disable():void 
		{
			if (enabled) return;
			
			for (var i:int = 0; i < _resizeHandlers.length; i++) 
			{
				_resizeHandlers[i].removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			}
			
			if (component.onStage) {
				ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);	
				ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			}
		}
		
		override public function destroy():void 
		{
			_resizeHandlers.length = 0;
			super.destroy();
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);	
			ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			_point.x = ZvrComponent(component).mouseX;
			_point.y = ZvrComponent(component).mouseY;
			
			_dispatchEvent(ZvrResizeBehaviorEvent.START_RESIZE);
			
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);	
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			_dispatchEvent(ZvrResizeBehaviorEvent.STOP_RESIZE);
			
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			if (e.altKey)
			{
				simetricResize();
			}
			else
			{
				bottomRightResize();
			}
			
		}
		
		private function simetricResize():void
		{
			// TODO simetricResize, think on other resize modes (resizin on any edge?)
		}
		
		public function addHandler(handler:InteractiveObject):void
		{
			if (_resizeHandlers.indexOf(handler) != -1) return;
			_resizeHandlers.push(handler);
			handler.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		public function removeHandler(handler:InteractiveObject):void
		{
			var i:int = _resizeHandlers.indexOf(handler);
			if (i == -1) return;
			_resizeHandlers.splice(i, 1);
			handler.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
		}
		
		private function bottomRightResize():void
		{
			var w:Number = _point.x - ZvrComponent(component).mouseX;
			var h:Number = _point.y - ZvrComponent(component).mouseY;
			
			var th:Number = component.bounds.height;
			var tw:Number = component.bounds.width;
			
			var event:ZvrResizeBehaviorEvent = _dispatchEvent(ZvrResizeBehaviorEvent.RESIZING, new Point(w,h), true);
			
			if (event.isDefaultPrevented())
			{
				if (event.delta.x == w && event.delta.y == h)
				{
					w = component.bounds.width - tw;
					h = component.bounds.height - th;
					
					_point.x += w;
					_point.y += h;
					
					return;
				}
				else
				{
					w = event.delta.x;
					h = event.delta.y;
				}
			}
			
			if (component.explicit.x != ZvrExplicitBounds.X) component.x = component.bounds.x;
			if (component.explicit.y != ZvrExplicitBounds.Y) component.y = component.bounds.y;
			if (component.explicit.width != ZvrExplicitBounds.WIDTH) component.width = component.bounds.width;
			if (component.explicit.height != ZvrExplicitBounds.HEIGHT) component.height = component.bounds.height;

			component.enterMassChangeMode();
			
			component.width = component.bounds.width - w;
			component.height = component.bounds.height - h;
			
			component.exitMassChangeMode();
			
			w = component.bounds.width - tw;
			h = component.bounds.height - th;
			
			_point.x += w;
			_point.y += h;
			
			_dispatchEvent(ZvrResizeBehaviorEvent.RESIZE,  new Point(w,h));
			
		}
		
		private function _dispatchEvent(type:String, delta:Point = null, cancelable:Boolean = false):ZvrResizeBehaviorEvent
		{
			var e:ZvrResizeBehaviorEvent = new ZvrResizeBehaviorEvent(type, this, component, delta, false, cancelable);
			dispatchEvent(e);
			return e;
		}
		
	}

}