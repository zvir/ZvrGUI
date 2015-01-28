package zvr.zvrGUI.behaviors 
{
		import de.nulldesign.nd2d.display.Node2D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrKeyboard.ZvrKey;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrKeyBehavior extends ZvrBehavior 
	{
		public static const NAME:String = "key";
		
		private var _key:ZvrKey;
		
		public function ZvrKeyBehavior() 
		{
			super(NAME);
		}
		
		override protected function enable():void 
		{
			super.enable();
			
			if (_key)
			{
				_key.addPressedCallback(keyDown);
				_key.addReleasedCallback(keyReleased);
			}
		}
		
		override protected function disable():void 
		{
			super.disable();
			
			if (_key)
			{
				_key.removePressedCallback(keyDown);
				_key.removeReleasedCallback(keyReleased);
			}
		}
		
		public function get key():ZvrKey 
		{
			return _key;
		}
		
		public function set key(value:ZvrKey):void 
		{
			if (_key)
			{
				_key.removeReleasedCallback(keyDown);
				_key.removePressedCallback(keyReleased);
			}
			
			_key = value;
			
			if (_key && enabled)
			{
				_key.addPressedCallback(keyDown);
				_key.addReleasedCallback(keyReleased);
			}
			
		}
		
		private function keyDown():void 
		{
			if (!component.visible) return;
			//if (!component.checkState(ZvrStates.ENALBLED)) return;
			
			component.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			
			component.addState(ZvrStates.DOWN);
			component.addState(ZvrStates.OVER);
		}
		
		private function keyReleased():void 
		{
			if (!component.visible) return;
			//if (!component.checkState(ZvrStates.ENALBLED)) return;
			
			component.removeState(ZvrStates.DOWN);
			component.removeState(ZvrStates.OVER);
		}
		
	}

}