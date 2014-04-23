package clv.gui.core.statePresents 
{
	import clv.gui.clv;
	import clv.gui.core.ComponentSignal;
	import clv.gui.core.Container;
	import clv.gui.core.IComponent;
	import clv.gui.core.states.StateSignal;
	
	use namespace clv;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class StatePresentsManager 
	{
		private const TRUE:String = "true";
		private const FALSE:String = "false";
		
		private var _includeIn:Array = new Array();
		private var _excludeIn:Array = new Array();
		private var _includeInLayout:Object;
		private var _present:Boolean = true;
		
		private var _component:IComponent;
		
		private var _visibleSetter:Function;
		
		public function StatePresentsManager(component:IComponent, visibleSetter:Function)
		{
			_visibleSetter = visibleSetter;
			_component = component;
		}
		
		public function dispose():void 
		{
			if (_component)
			{	
				if (_component.container)
				{
					_component.container.onStateChange.remove(containerStateChange);
				}
			}
			
			_includeIn = null;
			_excludeIn = null;
			_includeInLayout = null;
			_component = null;
			_visibleSetter = null;
		}
		
		clv function componentAdded(to:Container):void 
		{
			if (!to) return;
			to.onStateChange.add(containerStateChange);
			update();
		}
		
		clv function componentRemoved(from:Container):void 
		{
			from.onStateChange.remove(containerStateChange);
		}
		
		private function containerStateChange(e:StateSignal):void 
		{
			update();
		}
		
		private function update():void
		{
			var p:Boolean = _present;
			
			if (!_component.container) return;
			
			if (_includeInLayout) return;
			
			if (_includeIn.length > 0)
			{
				_present = false;
				if (chceck(_includeIn, _component.container.currentStates))
				{
					_present = true;
				}
			}
			else
			{
				_present = true; // deafult value is true
			}
			
			if (_excludeIn.length > 0)
				if (chceck(_excludeIn, _component.container.currentStates)) _present = false;
			
			
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
			
			update();
			
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
			_component.onPresentsChange.dispatch(_component.componentSignal);
		}
		
		private function set visible(value:Boolean):void
		{
			_visibleSetter(value);
		}
		
	}

}