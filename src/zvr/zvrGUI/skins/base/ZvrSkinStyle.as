package zvr.zvrGUI.skins.base 
{
	import flash.utils.Dictionary;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSkinStyle extends Object
	{
		public var styleName:String;
		public var getter:Function;
		public var setter:*;
		
		private var _getter:Boolean = true;
		
		private var _statesValues:Dictionary = new Dictionary();
		private var _defaultValue:*;
		
		
		public function ZvrSkinStyle(styleName:String, setter:*, getter:Function = null) 
		{
			this.styleName = styleName;
			this.setter = setter;
			this.getter = getter;
			
			if (getter == null) _getter = false;
			
		}
		
		public function updateStyle(value:*, multiChange:Boolean = false):Function
		{
			if (_getter)
			{
				setter(value);
			}
			else
			{
				if (setter is Function)
				{
					if (multiChange)
						return setter;
					else
						setter();
				}
				else if (setter is ZvrProperty) 
					ZvrProperty(setter).component[ZvrProperty(setter).property] = value;
			}
			
			return null;
			
		}
		
		public function updateSkin(state:String, multiChange:Boolean = false):Function
		{
			var f:Function = updateStyle(getValue(state), multiChange);
			
			if (f != null && multiChange)
				return f;
			else
				return null;
		}
		
		public function getSkinStyle():*
		{
			if (_getter) return getter(); else null;
		}
		
		public function getValue(state:String = ""):* 
		{
			var v:* = getSkinStyle();
			if (v) return v;
			return getStyleValue(state);
		}
		
		public function getStyleValue(state:String = ""):*
		{
			
			if (!state || state == "" || state == "deafult") return _defaultValue;
			
			var selectedState:String = "";
			var priority:int = 0;
			var componentStates:Array = state.split("|");
			
			var matchingStyles:Array = [];
			
			for (var styleState:String in _statesValues) 
			{
				var styleStates:Array = styleState.split("|");
				
				var r:int = 0;
				
				for (var i:int = 0; i < componentStates.length; i++) 
				{
					for (var j:int = 0; j < styleStates.length; j++) 
					{
						if (componentStates[i] == styleStates[j])
						{
							var ind:int = matchingStyles.indexOf(styleStates);
							if (ind == -1) 
							{
								matchingStyles.push([styleStates, 1]);
							}
							else
							{
								matchingStyles[ind][1]++;
							}
							
							r++;
						}
					}
				}
				
				if (r == styleStates.length)
				{
					if (styleStates.length >= priority)
					{
						selectedState = styleState;
						priority = styleStates.length;
					}
				}
			}
			
			if ((selectedState != "deafult" || selectedState != "") && priority > 0)
			{
				return statesValues[selectedState];
			}
			else
			{
				return _defaultValue;
			}
			return null;
		}
		
		
		
		public function toString():String
		{
			var s:String;
			
			s = styleName;
			s = s + "\ndefaultValue: " + _defaultValue;
			s = s + "\nstatesValues:"
			
			for (var name:String in _statesValues) 
			{
				s = s + "\n\t" + name + " : " + _statesValues[name]; 
			}
			
			return s;
		}
		
		public function setStateValue(state:String, value:*):void
		{
			if (state == "" || state == "deafult")
			{
				_defaultValue = value;
			}
			else
			{
				_statesValues[state] = value;
			}
			
		}
		
		public function get statesValues():Dictionary 
		{
			return _statesValues;
		}
		
		public function get defaultValue():* 
		{
			return _defaultValue;
		}
		
		public function set defaultValue(value:*):void 
		{
			_defaultValue = value;
		}
		
		public function get isGetter():Boolean 
		{
			return _getter;
		}
		
	}

}