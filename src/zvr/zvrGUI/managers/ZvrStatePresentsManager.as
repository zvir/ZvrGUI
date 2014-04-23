package zvr.zvrGUI.managers 
{
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrStatePresentsManager 
	{
		private const TRUE:String = "true";
		private const FALSE:String = "false";
		
		private var _includeIn:Array = new Array();
		private var _excludeIn:Array = new Array();
		
		private var _includeInLayout:Object;
		
		private var _present:Boolean = true;
		
		private var _component:IZvrComponent;
		
		private var _visibleSetter:Function;
		
		public function ZvrStatePresentsManager(component:IZvrComponent, visibleSetter:Function)
		{
			_visibleSetter = visibleSetter;
			_component = component;
			_component.addEventListener(ZvrComponentEvent.ADDED, componentAdded, false, 0, true);
		}
		
		public function dispose():void 
		{
			if (_component)
			{
				_component.removeEventListener(ZvrComponentEvent.ADDED, componentAdded);
				_component.removeEventListener(ZvrComponentEvent.REMOVED, componentRemoved);
				
				if (_component.owner)
				{
					_component.owner.removeEventListener(ZvrStateChangeEvent.CHANGE, ownerStateChange);
				}
			}
			
			_includeIn = null;
			_excludeIn = null;
			_includeInLayout = null;
			_component = null;
			_visibleSetter = null;
		}
		
		private function componentAdded(e:ZvrComponentEvent):void 
		{
			if (!_component.owner) return;
			_component.owner.addEventListener(ZvrStateChangeEvent.CHANGE, ownerStateChange);
			_component.addEventListener(ZvrComponentEvent.REMOVED, componentRemoved, false, 0, true);
			_component.removeEventListener(ZvrComponentEvent.ADDED, componentAdded);

			update();
		}
		
		private function componentRemoved(e:ZvrComponentEvent):void 
		{
			_component.owner.removeEventListener(ZvrStateChangeEvent.CHANGE, ownerStateChange);
			_component.addEventListener(ZvrComponentEvent.ADDED, componentAdded, false, 0, true);
		}
		
		private function ownerStateChange(e:ZvrStateChangeEvent):void 
		{
			update();
		}
		
		private function update():void
		{
			var p:Boolean = _present;
			
			if (!_component.owner) return;
			
			if (_includeInLayout) return;
			
			if (_includeIn.length > 0)
			{
				_present = false;
				if (chceck(_includeIn, _component.owner.currentStates))
				{
					_present = true;
				}
			}
			else
			{
				_present = true; // deafult value is true
			}
			
			if (_excludeIn.length > 0)
				if (chceck(_excludeIn, _component.owner.currentStates)) _present = false;
			
			
			if (p != _present) 
			{
				if (!_present)
				{
					visible = false;
				}
				else
				{
					visible = true;
				}
				dispachEvent();
			}
		}
		
		private function chceck(type:Array, state:Array):Boolean
		{
			for (var i:int = 0; i < type.length; i++) 
			{
				for (var j:int = 0; j < state.length; j++) 
				{
					if (type[i] == state[j]) return true;
				}
			} 
			return false;
		}
		
		private function remove(type:Array, state:Array):void
		{
			
			var t:Array = new Array();
			
			for (var i:int = 0; i < type.length; i++) 
			{
				for (var j:int = 0; j < state.length; j++) 
				{
					if (type[i] != state[j]) t.push(state[j]);
				}
			} 
			type = t;
		}
		
		public function set includeIn(value:*):void
		{
			if (value is String) value = [value];
			if (chceck(_excludeIn, value)) remove(_excludeIn, value);
			_includeIn = value;
			update();
		}
		
		public function set exlcudeIn(value:*):void
		{
			if (value is String) value = [value];
			if (chceck(_includeIn, value)) remove(_includeIn, value);
			_excludeIn = value;
			update();
		}
		
		public function get includeInLayout():Object 
		{
			return _includeInLayout == TRUE ? true : false;
		}
		
		public function set includeInLayout(value:Object):void 
		{
			if (value == null) value = null;
			else if (value == true) value = TRUE;
			else if (value == false) value = FALSE;
			
			if (_includeInLayout == value) return;
			_includeInLayout = value;
			
			if (_includeInLayout == TRUE) visible = true;
			if (_includeInLayout == FALSE) visible = false;
			
			
			dispachEvent();
		}
		
		public function get present():Boolean 
		{
			if (_includeInLayout != null)
			{
				if (_includeInLayout == TRUE) return true;
				if (_includeInLayout == FALSE) return false;
			}
			
			return _present;
		}
		
		private function dispachEvent():void
		{
			_component.dispatchEvent(new ZvrComponentEvent(ZvrComponentEvent.PRESENTS_CHANGE, _component));
		}
		
		private function set visible(value:Boolean):void
		{
			_visibleSetter(value);
		}
		
	}

}