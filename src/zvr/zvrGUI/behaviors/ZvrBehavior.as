package zvr.zvrGUI.behaviors 
{
	import flash.events.Event;
	import flash.events.EventDispatcher;

	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBehavior extends EventDispatcher
	{
		
		private var _enabled:Boolean = false;
		private var _name:String = "ZvrBehaviorName";	
		private var _component:IZvrComponent;
		
		protected var _stageSensitive:Boolean = false;
		
		public function ZvrBehavior(name:String) 
		{
			_name = name;
		}
		
		protected function enable():void
		{
			// to be overrided
		}
		
		protected function disable():void
		{
			// to be overrided
		}
		
		
		
		public function destroy():void
		{
			disable();
			// to overrided with super;
		}
		
		public function isCompatible(skin:ZvrSkin):Boolean
		{
			if (!skin.availbleBehaviors) return true;
			
			for (var i:int = 0; i < skin.availbleBehaviors.length; i++) 
			{
				if (this is skin.availbleBehaviors[i]) return true;
			}
			return false;
		}
		
		public function set enabled(value:Boolean):void 
		{
			if (_enabled == value) return;
			_enabled = value;
			if (enabled) enable() else disable();
		}
		
		public function get enabled():Boolean 
		{
			return _enabled;
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function get component():ZvrComponent
		{
			return ZvrComponent(_component);
		}
		
		public function set component(value:ZvrComponent):void
		{
			_component = value;

			if (_stageSensitive) 
			{
				if (_component.onStage)
				{
					addedToStage(null);
				}
				else
				{
					stageSensetive();
				}
			}
		}
		
		public function stageSensetive():void
		{
			component.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			component.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			component.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			if (enabled) enable();
		}
		
		private function removedFromStage(e:Event):void 
		{
			component.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			component.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			disable();
		}
		
		
	}

}