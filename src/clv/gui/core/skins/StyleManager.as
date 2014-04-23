package clv.gui.core.skins 
{
	import clv.gui.core.IComponent;
	import clv.gui.core.states.StateSignal;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author ...
	 */
	public class StyleManager 
	{
		private var _component:IComponent;
		
		private var _initialized:Boolean = false;
		private var _styles:Dictionary = new Dictionary();
		private var _skin:SkinBase;
		
		public function StyleManager(skin:SkinBase)
		{
			_skin = skin;
		}
		
		public function init(component:IComponent):void
		{
			
			if (_component)
			{
				_component.onStateChange.remove(componentStateChange);
			}
			
			_component = component;
			
			if (_component)
			{
				_component.onStateChange.add(componentStateChange);
				
				var s:String = componentState;
				var setters:Dictionary = new Dictionary();
				
				for (var name:String in _styles) 
				{
					var skinStyle:Style = getSkinStyle(name);
					var f:Function = skinStyle.updateSkin(s, true);
					if (f != null) setters[f] = f;
				}
				
				for each (var item:Function in setters) 
				{
					item();
				}
				
			}
			
			_initialized = true;
			
			
			
		}
		
		public function getStylesRegistration(styleName:String):Style
		{
			return _styles[styleName];
		}
		
		public function setStyle(styleName:String, value:*, state:* = null):Boolean
		{
			if (!_styles[styleName])
			{
				if (Object(_component).hasOwnProperty(styleName))
				{
					registerStyle(styleName, new Property(_component, styleName));
					if (state) _styles[styleName].deafultValue = _component[styleName];
					return setStyle(styleName, value, state);
				}
				return false;
			}
			
			if (state != null)
			{
				if (state is String) {
					getSkinStyle(styleName).setStateValue([state], value);
					if (_initialized) if (_component.isCurrentState(state)) getSkinStyle(styleName).updateSkin(state);
					return true;
				} 
				if (state is Array)
				{
					var a:Array = state;
					getSkinStyle(styleName).setStateValue(a, value);
					a.sort();
					var s:String = a.join("|");
					if (_initialized) getSkinStyle(styleName).updateSkin(state);
					return true;
				}
			} 
			
			getSkinStyle(styleName).defaultValue = value;
			
			if (_initialized) getSkinStyle(styleName).updateSkin(state);
			
			return true;
		}
		
		public function getStyle(styleName:String):*
		{
			if (!_styles[styleName]) return null;
			return getSkinStyle(styleName).getValue(componentState);
		}
		
		private function componentStateChange(e:StateSignal):void 
		{
			var s:String = componentState;
			var setters:Dictionary = new Dictionary();
			
			for (var name:String in _styles) 
			{
				var skinStyle:Style = getSkinStyle(name);
				if (!skinStyle.machesStates(e.added) && !skinStyle.machesStates(e.removed)) continue;
				var f:Function = skinStyle.updateSkin(s, true);
				if (f != null) setters[f] = f;
			}
			
			for each (var item:Function in setters) 
			{
				item();
			}
		}
		
		public function registerStyle(styleName:String, setter:*, getter:Function = null):void
		{
			if (setter is Function)
				_styles[styleName] = new Style(styleName, setter, getter);
			else if (setter is Property)
				_styles[styleName] = new Style(styleName, setter);
			else
				_styles[styleName] = setter;
		}
		
		private function getSkinStyle(name:String):Style
		{
			return Style(_styles[name]);
		}
		
		public function styleToString(styleName:String):String
		{
			return _styles[styleName].toString();
		}
		
		public function dispose():void 
		{
			for (var name:String in _styles) 
			{
				var skinStyle:Style = _styles[name];
				skinStyle.dispose();
				_styles[name] = null;
				delete _styles[name];
			}
			
			if (_component)
				_component.onStateChange.remove(componentStateChange);
			
			_styles = null;
			_skin = null;
			_component = null;
		}
		
		private function get componentState():String
		{
			var a:Array = _component.currentStates.splice(0).sort();
			return a.join("|");
		}
	}

}