package zvr.zvrGUI.core 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInteractiveCover extends Sprite 
	{
		
		private var _owner:ZvrComponent
		
		public function ZvrInteractiveCover() 
		{
			super();
			//enable();
			mouseEnabled = false;
		}
		
		public function enable():void
		{
			addEventListener(Event.ADDED, added);
			graphics.beginFill(0x06C1FF, 0.1);
			graphics.drawRect(0, 0, 100, 100);
			if (_owner) ownerResize(null);
		}
		
		public function disable():void
		{
			graphics.clear();
		}
		
		private function added(e:Event):void 
		{
			if (!(parent is ZvrComponent))
			{
				throw new Error("ZvrInteractiveCover can be added to ZvrComponent olny");
				return;
			}
			
			_owner = parent as ZvrComponent;
			_owner.addEventListener(ZvrComponentEvent.RESIZE, ownerResize);
			_owner.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			_owner.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			trace(e.type);
		}
		
		private function ownerResize(e:ZvrComponentEvent):void 
		{
			width = _owner.bounds.width;
			height = _owner.bounds.height;
		}
		
	}

}