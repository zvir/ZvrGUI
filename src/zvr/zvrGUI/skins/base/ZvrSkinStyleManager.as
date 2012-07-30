package zvr.zvrGUI.skins.base 
{
	import flash.utils.Dictionary;
	import zvr.zvrGUI.components.minimalDark.WindowTitleMD;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSkinStyleManager 
	{
		private var _initialized:Boolean = false;
		private var _styles:Dictionary = new Dictionary();
		private var _skin:ZvrSkin;
		private var _component:ZvrComponent;
		
		public function ZvrSkinStyleManager(skin:ZvrSkin, component:ZvrComponent) 
		{
			_component = component;
			_skin = skin;
			_component.addEventListener(ZvrStateChangeEvent.CHANGE, componentStateChange);
		}
		
		public function init():void
		{
			_initialized = true;
		}
		
		public function getStylesRegistration(styleName:String):ZvrSkinStyle
		{
			return _styles[styleName];
		}
		
		public function setStyle(styleName:String, value:*, state:* = null):Boolean
		{
			if (!_styles[styleName])
			{
				if (_component.hasOwnProperty(styleName)) 
				{
					registerStyle(styleName, new ZvrProperty(_component, styleName));
					if (state) _styles[styleName].deafultValue = _component[styleName];
					return setStyle(styleName, value, state);
				}
				return false;
			}
			
			if (state != null)
			{
				if (state is String) {
					getSkinStyle(styleName).setStateValue([state], value);
					if (_initialized) if (_component.checkState(state)) getSkinStyle(styleName).updateSkin(state);
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
		
		private function componentStateChange(e:ZvrStateChangeEvent):void 
		{
			var s:String = componentState;
			var setters:Dictionary = new Dictionary();
			
			for (var name:String in _styles) 
			{
				var skinStyle:ZvrSkinStyle = getSkinStyle(name);
				if (!skinStyle.machesStates(e.newStates) && !skinStyle.machesStates(e.removedStates)) continue;
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
				_styles[styleName] = new ZvrSkinStyle(styleName, setter, getter);
			else if (setter is ZvrProperty)
				_styles[styleName] = new ZvrSkinStyle(styleName, setter);
			else
				_styles[styleName] = setter;
		}
		
		private function getSkinStyle(name:String):ZvrSkinStyle
		{
			return ZvrSkinStyle(_styles[name]);
		}
		
		public function styleToString(styleName:String):String
		{
			return _styles[styleName].toString();
		}
		
		private function get componentState():String
		{
			var a:Array = _component.currentStates.splice(0).sort();
			return a.join("|");
		}
		
	}

}