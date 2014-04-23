package zvr.zvrLocalization 
{
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocDynamicPhrase implements IZvrLocTF
	{
		
		private static const _objects:Dictionary = new Dictionary();
		
		public var item:ZvrLocItem;
		internal var func:Boolean;
		internal var setter:String;
		private var _object:Object;
		
		internal var values:Array;
		
		
		
		public function ZvrLocDynamicPhrase(object:Object, setter:String, func:Boolean, item:ZvrLocItem, values:Array) 
		{
			this.item = item;
			this.func = func;
			this.setter = setter;
			_object = object;
			this.values = values ? values : [];
			
			item.textFields.push(this);
			
			updateText();
		}
		
		public function remove():void
		{
			item.textFields.splice(item.textFields.indexOf(this), 1);
		}
		
		public static function add(object:Object, setter:String, func:Boolean, item:ZvrLocItem, ... rest):void
		{
			if (_objects[object] != undefined)
			{
				remove(object);
			}
			
			var i:ZvrLocDynamicPhrase = new ZvrLocDynamicPhrase(object, setter, func, item, rest);
			
			_objects[object] = i;
		}
		
		public static function remove(object:Object):void
		{
			ZvrLocDynamicPhrase(_objects[object]).remove();
			_objects[object] = undefined;
			delete _objects[object];
		}
		
		public static function get(object:Object):ZvrLocDynamicPhrase
		{
			return _objects[object];
		}
		
		public function updateValues(... rest):void 
		{
			values = rest;
			updateText();
		}
		
		public function updateText():void 
		{
			
			var s:String = dynamicText();
			
			if (func)
			{
				_object[setter](s);
			}
			else
			{
				_object[setter] = s;
			}
		}
		
		public function getText():String 
		{
			if (func)
			{
				return _object[setter]();
			}
			else
			{
				return _object[setter];
			}
		}
		
		
		private function dynamicText():String
		{
			var v:Array = values.slice();
			
			var r:String = v.shift();
			var s:String = preapareText(item.text)
		
			
			while (r)
			{
				s = s.replace(/{[^{]+}/, r);
				r = v.shift();
			}
			
			return s;
		}
		
		private function preapareText(s:String):String
		{
			return s.replace(String.fromCharCode(13), "\n");
		}
		
		public function get object():Object 
		{
			return _object;
		}
		
		public function set newItem(v:ZvrLocItem):void
		{
			remove();
			item = v;
			v.textFields.push(this);
		}
	}

}