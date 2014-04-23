package zvr.zvrLocalization 
{
	import zvr.zvrLocalization.phase.ZvrLocTemplate;
	import zvr.zvrLocalization.phase.ZvrLocVariableItem;
	/**
	 * ...
	 * @author Zvir
	 */
	internal class ZvrLocTF
	{
		private var _items:Vector.<ZvrLocItem> = new Vector.<ZvrLocItem>();
		private var _func:Boolean;
		private var _setter:String;
		private var _object:Object;
		private var _localization:ZvrLocalization;
		private var _template:ZvrLocTemplate;
		
		public function ZvrLocTF(object:Object, setter:String, func:Boolean, localization:ZvrLocalization) 
		{
			_localization = localization;
			_func = func;
			_setter = setter;
			_object = object;
		}
		
		public function remove():void
		{
			for (var i:int = 0; i < _items.length; i++) 
			{
				var item:ZvrLocItem = _items[i];
				item.textFields.splice(item.textFields.indexOf(this), 1);
			}
			
			_items.length = 0;
		}
		
		public function updateTemplate(template:ZvrLocTemplate):void 
		{
			remove();
			
			_template = template;
			
			var a:Array = _localization.getItemsFromTemplate(_template);
			
			for (var i:int = 0; i < a.length; i++) 
			{
				var item:ZvrLocItem = a[i];
				_items.push(item);
				item.textFields.push(this);
			}
		}
		
		public function updateText():void 
		{
			if (_func)
			{
				_object[_setter](getText());
			}
			else
			{
				_object[_setter] = getText();
			}
			
		}
		
		public function getText():String
		{
			return _localization.getTemplateText(_template);
		}

	}

}