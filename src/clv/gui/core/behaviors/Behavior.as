package clv.gui.core.behaviors 
{
	import clv.gui.core.ComponentSignal;
	import clv.gui.core.IComponent;
	import clv.gui.core.skins.Skin;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Behavior 
	{
		private var _enabled:Boolean = false;
		private var _name:String = "ZvrBehaviorName";	
		private var _component:IComponent;
		
		protected var _stageSensitive:Boolean = false;
		
		public function Behavior(name:String) 
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
		
		/*public function isCompatible(skin:Skin):Boolean
		{
			if (!skin.availbleBehaviors) return true;
			
			for (var i:int = 0; i < skin.availbleBehaviors.length; i++) 
			{
				if (this is skin.availbleBehaviors[i]) return true;
			}
			return false;
		}*/
		
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
		
		public function get component():IComponent
		{
			return _component;
		}
		
		public function set component(value:IComponent):void
		{
			_component = value;

			if (_stageSensitive) 
			{
				if (_component.app)
				{
					addedToApp(null);
				}
				else
				{
					stageSensetive();
				}
			}
		}
		
		public function stageSensetive():void
		{
			_component.onAddedToApp.addOnce(addedToApp);
		}
		
		private function addedToApp(e:ComponentSignal):void 
		{
			_component.onRemovedFromApp.addOnce(addedToApp);
			if (enabled) enable();
		}
		
		private function removedFromApp(e:ComponentSignal):void 
		{
			_component.onAddedToApp.addOnce(addedToApp);
			disable();
		}
	}

}