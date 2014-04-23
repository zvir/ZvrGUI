package zvr.zvrComps.zvrTool.zvrToggler 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import utils.string.remove;
	import utils.string.remove;
	import utils.string.remove;
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.core.ZvrContainer;

	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTogglerItem 
	{
		public var toggler:ZvrToggler;
		
		private var _name:String;
		private var _toggle:Boolean = false;
		private var _value:Boolean = false;
		private var _function:Function;
		private var _params:Array = [];
		private var _button:ToggleButtonMD;
		
		private var _object:Object
		private var _propery:String;
		private var _valueTrue:* = true;
		private var _valueFalse:* = false;

		public function ZvrTogglerItem() 
		{
			
		}
		
		public function remove():void
		{
			
			if (!toggler) return;
			
			toggler.remove(_name);
			
			ZvrContainer(_button.owner).removeChild(_button);
			
			_function = null;
			_object = null;
			_params = null;
			
			toggler = null;
			
		}
		
		public function get name():String 
		{
			return _name;
		}
		
		public function set name(value:String):void 
		{
			_name = value;
		}
		
		public function get toggle():Boolean 
		{
			return _toggle;
		}
		
		public function set toggle(value:Boolean):void 
		{
			_toggle = value;
			
			if (!_button) return;
			
			_button.behaviors.getBehavior(ZvrSelectable.NAME).enabled = _toggle;
			
			if (_toggle)
			{
				_button.selected = _value;
			}
			else
			{
				_button.selected = false;
			}
		}
		
		public function get params():Array 
		{
			return _params;
		}
		
		public function set params(value:Array):void 
		{
			_params = value;
		}
		
		public function get value():Boolean 
		{
			return _value;
		}
		
		public function set value(value:Boolean):void 
		{
			_value = value;
			if (_toggle && _button) _button.selected = _value;
		}
		
		public function get button():ToggleButtonMD 
		{
			return _button;
		}
		
		public function set button(value:ToggleButtonMD):void 
		{
			_button = value;
			_button.label.text = name;
			
			if (Multitouch.supportsTouchEvents)
			{
				_button.addEventListener(TouchEvent.TOUCH_TAP, click);
			}
			else
			{
				_button.addEventListener(MouseEvent.CLICK, click);
			}
			
			
			_button.behaviors.getBehavior(ZvrSelectable.NAME).enabled = false;
		}
		
		private function click(e:Event):void 
		{	
			if (_toggle)
			{
				_value =  _button.selected;
				
				if (_function != null) 
				{
					_function.call(null, _value);
				}
				else if (_object && _propery)
				{
					_object[_propery] = _value ? _valueTrue : _valueFalse;
				}
			}
			else
			{
				if (_function != null)  
				{
					_function.apply(null, _params);
				}
			}
		}
		
		public function setValue(value:Boolean):ZvrTogglerItem 
		{
			this.value = value;
			return this;
		}
		
		public function setToggle(value:Boolean):ZvrTogglerItem 
		{
			toggle = value;
			return this;
		}
		
		public function setParams(... args):ZvrTogglerItem 
		{
			_params = args;
			return this;
		}
		
		public function setFunction(value:Function):ZvrTogglerItem 
		{
			_function = value;
			return this;
		}
		
		public function setObject(value:Object):ZvrTogglerItem
		{
			_object = value;
			return this;
		}
		
		public function setProperty(property:String):ZvrTogglerItem
		{
			_propery = property;
			return this;
		}
		
		public function setTrueFalseParams(t:*, f:*):ZvrTogglerItem
		{
			_valueFalse = t;
			_valueFalse = f;
			return this;
		}
		
		
		public function setupObject(object:Object, property:String, t:*, f:*):ZvrTogglerItem
		{
			_object = object;
			_valueFalse = t;
			_valueFalse = f;
			_propery = property;
			setToggle(true);
			return this;
		}
		
	}

}