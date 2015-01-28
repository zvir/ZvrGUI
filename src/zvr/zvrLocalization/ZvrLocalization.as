package zvr.zvrLocalization 
{
	import flash.utils.Dictionary;
	import org.osflash.signals.Signal;
	import zvr.zvrLocalization.phase.ZvrLocPhrase;
	import zvr.zvrLocalization.phase.ZvrLocTemplate;
	import zvr.zvrLocalization.phase.ZvrLocVariableItem;
	import zvr.zvrLocalization.phase.ZvrPhaseJoint;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocalization 
	{
		/*private var _dir:File;
		private var _generateClasses:Boolean;
		private var _generateClassesDir:File;
		private var _generateClassesPack:String;*/
		//private var _generate:Boolean;
		
		
		private var _items:Object;
		
		private var _langsTypes:Array;
		private var _currentLang:int;
		
		private var _content:Vector.<ZvrLocContent>;
		private var _contentTypes:Object;
		private var _textFields:Dictionary;
		
		private var _manager:ZvrLocContentManager;
		private var _langsXML:XML;
		
		private var _languageChanged:Signal = new Signal();
		
		public function ZvrLocalization(managerClass:Class) 
		{
			_textFields = new Dictionary();
			_manager = new managerClass(this);
		}
		
		internal function generateContent(content:Vector.<ZvrLocContent>, langsXML:XML):void
		{
			_items = { };
			_langsTypes = [];
			_contentTypes = [];
			_content = new Vector.<ZvrLocContent>();
			
			defineLangs(langsXML);
			
			for (var i:int = 0; i < content.length; i++) 
			{
				var c:ZvrLocContent = content[i];
				
				createItems(c);
				
				_content.push(c);
				
				if (_contentTypes[c.xml.@lang] == undefined) _contentTypes[c.xml.@lang] = { };
				_contentTypes[c.xml.@lang][c.xml.@name] = c;
				
			}
			
			verify();
			
			var toSave:Array = [];
			
			for (var name:String in _items) 
			{
				var item:ZvrLocItem = _items[name];
				
				for (var lng:String in item.content) 
				{
					var contItem:ZvrLocContentItem = item.content[lng];
					
					if (contItem.content.@v == undefined)
					{
						contItem.content.@v = "0"
						
						if (toSave.indexOf(contItem.file) == -1)
						{
							toSave.push(contItem.file);
						}
						
					}
					
				}
				
			}
			
			for (var j:int = 0; j < toSave.length; j++) 
			{
				var f:ZvrLocContent = toSave[j];
				f.save();
			}
			
			
		}
		
		private function getNewItem(node:String):ZvrLocItem 
		{
			var item:ZvrLocItem = _items[node];
			
			if (!item)
			{
				item = new ZvrLocItem();
				_items[node] = item;
				item.name = node;
			}
			
			return item;
		}
		
		private function createItems(c:ZvrLocContent):void 
		{
			var list:XMLList = c.xml..text;
			
			for each (var text:XML in list)
			{
				createItem(text, c);
			}
		}
		
		internal function createItem(xml:XML, c:ZvrLocContent):ZvrLocItem
		{
			var path:String = xml.@name;
				
			var p:XML;
			
			p = xml.parent();
			
			while (p && p != c.xml)
			{
				if (p) path = p.name() + "." + path;
				p = p.parent();
			}
			
			var s:String = xml.@name.toString();
			
			if (XMLList(XML(xml.parent()).xml.(@name == s)).length() > 1)
			{
				path += "." + xml.childIndex().toString();
			}
			
			path = c.xml.@name.toString() + "." + path;
			
			var item:ZvrLocItem = getNewItem(path);
			
			var ci:ZvrLocContentItem = new ZvrLocContentItem();
			ci.content = xml;
			ci.file = c;
			ci.item = item;
			ci.lang = c.xml.@lang;
			
			item.content[c.xml.@lang] = ci;
			
			item.currentText = _langsTypes[_currentLang];
			
			item.contentType = c.xml.@name;
			
			return item;
		}
		
		private function defineLangs(xml:XML):void 
		{
			//trace(xml);
			
			_langsXML = xml;
			
			var l:XMLList = xml..lang;
			
			//trace(l);
			
			for each (var item:XML in l) 
			{
				_langsTypes.push(item.toString());
			}
			
		}
		
		private function verify():void 
		{
			
			var missed:Array = [];
			var contentItem:ZvrLocContentItem;
			
			for each (var item:ZvrLocItem in _items) 
			{
				missed.length = 0;
				
				for (var i:int = 0; i < _langsTypes.length; i++) 
				{
					if (item.content[_langsTypes[i]] == undefined)
					{
						trace("missing field in xml", item.name);
						
						missed.push(_langsTypes[i]);
						
					}
					else
					{
						contentItem = item.content[_langsTypes[i]];
					}
				}
				
				for (i = 0; i < missed.length; i++) 
				{
					trace("repering");
					
					var c:ZvrLocContent = _contentTypes[missed[i]][contentItem.file.xml.@name];
					
					if (!c) 
					{
						c = manager.getNewLocContent(contentItem.file.xml.@name, missed[i]);
						_contentTypes[missed[i]][contentItem.file.xml.@name] = c;
					}
					
					if (c)
					{
						var node:XML = contentItem.content;
						
						var tree:Array = [];
						
						var n:XML = node;
						
						//trace(n.parent());
						
						while (n.parent() != undefined && n.parent().name() != "data")
						{
							tree.unshift(n.parent().name().toString());
							n = n.parent();
						}
						
						var v:* = c.xml;
						var x:* = c.xml;
						
						for (var j:int = 0; j < tree.length; j++) 
						{
							x = v[tree[j]];
							
							if (!x || x == undefined) 
							{
								x = new XML("<" + tree[j] + "/>");
								v.appendChild(x);
							}
							v = x;
						}
						
						v.appendChild(contentItem.content.copy());
						
						c.save();
						
					}
					
				}
				
			}
			
		}
		
		public function hasItem(node:String):Boolean
		{
			return Boolean(_items[node]);
		}
		
		public function getItemText(node:String):String 
		{
			return preapareText(getItem(node).text);
		}
		
		public function getItem(node:String):ZvrLocItem 
		{
			
			var on:String = node;
			
			try{
			
				var item:ZvrLocItem = _items[node];
				
				if (!item)
				{
					trace("creating new item!!!!!", node);
					
					var path:Array = node.split(".");
					
					var name:String = path.shift();
					
					var itemName:String = path.pop();
					
					for (var i:int = 0; i < _langsTypes.length; i++) 
					{
						
						if (_contentTypes[_langsTypes[i]] == undefined) _contentTypes[_langsTypes[i]] = { };
						
						if (_contentTypes[_langsTypes[i]][name] == undefined)
						{
							var c:ZvrLocContent = manager.getNewLocContent(name, _langsTypes[i]);
							_contentTypes[_langsTypes[i]][name] = c;
						}
						
						c = _contentTypes[_langsTypes[i]][name];
						
						var v:* = c.xml;
						var x:* = c.xml;
						
						for (var j:int = 0; j < path.length; j++) 
						{
							x = v[path[j]];
							
							if (!x || x == undefined) 
							{
								x = new XML("<" + path[j] + "/>");
								v.appendChild(x);
							}
							v = x;
						}
						
						var newXML:XML = new XML("<text name=\"" + itemName + "\" v=\"0\">" + itemName + "</text>");
						
						/*trace(v.text.(@name == itemName));
						trace(v.text.(@name == itemName) == null);
						trace(v.text.(@name == itemName) == undefined);*/
						
						if (v.text.(@name == itemName) == undefined)
						{
							v.appendChild(newXML);
							c.save();
						}
						else
						{
							newXML = v.text.(@name == itemName)[0];
						}
						
						item = createItem(newXML, c);
						
					}
					
					CONFIG::debug
					{
						/*if (_generateClasses)
						{
							generatePathsClasses(_generateClassesDir, _generateClassesPack);
						}*/
						
						manager.contentUpdated();
						
					}
				}
				
			}
			catch (err:Error)
			{
				err.message += " node: " + on;
				throw err;
			}
			
			
			
			
			return item;
		}
		
		
		public function addTextField(object:Object, setter:String, func:Boolean, ph:ZvrLocPhrase):void
		{
			//var item:ZvrLocItem = getItem(node);
			var tf:ZvrLocTF = new ZvrLocTF(object, setter, func, this);
			_textFields[object] = tf;
			tf.updateTemplate(getTemplate(ph));
			tf.updateText();
		}
		
		public function removeTextField(object:Object):void
		{
			var tf:ZvrLocTF = _textFields[object];
			if (!tf) return;
			tf.remove();
			_textFields[object] = null;
			delete _textFields[object];
		}
		
		
		public function updateTextField(object:Object, ph:ZvrLocPhrase):void
		{
			var tf:ZvrLocTF = _textFields[object];
			tf.updateTemplate(getTemplate(ph));
			tf.updateText();
		}
		
		
		public function isTextFieldAdded(object:Object):Boolean
		{
			return Boolean(_textFields[object]);
		}
		
		public function setLang(name:String):void
		{
			_currentLang = _langsTypes.indexOf(name);
			
			if (_currentLang == -1) 
			{
				_currentLang = 0;
				name = _langsTypes[0];
			}
			
			for each (var item:ZvrLocItem in _items) 
			{
				item.currentText = name;
			}
			
			for each (var tf:ZvrLocTF in _textFields) 
			{
				tf.updateText();
			}
			
			trace("CURRENT LANG:", name, _currentLang);
			
			_languageChanged.dispatch();
			
		}
		
		public function get currentLang():int 
		{
			return _currentLang;
		}
		
		public function set currentLang(value:int):void 
		{
			_currentLang = value;
			setLang(_langsTypes[value]);
		}
		
		public function get langsTypes():Array 
		{
			return _langsTypes;
		}
		
		public function get manager():ZvrLocContentManager 
		{
			return _manager;
		}
		
		internal function get items():Object 
		{
			return _items;
		}
		
		internal function get content():Vector.<ZvrLocContent> 
		{
			return _content;
		}
		
		internal function get langsXML():XML 
		{
			return _langsXML;
		}
		
		public function get languageChanged():Signal 
		{
			return _languageChanged;
		}
		
		public function get contentTypes():Object 
		{
			return _contentTypes;
		}
		
		
		/*
		 * 
		 * ITEMS FORM TEMPLATE
		 * 
		 */
		
		public function getItemsFromTemplate(t:ZvrLocTemplate, a:Array = null):Array
		{
			
			if (!a) a = [];
			
			for (var i:int = 0; i < t.template.length; i++) 
			{
				if (t.template[i] is ZvrLocVariableItem)
				{
					if (a.indexOf(ZvrLocVariableItem(t.template[i]).item) == -1) a.push(ZvrLocVariableItem(t.template[i]).item);
					getItemsFormValues(t.template[i], a);
				}
				
				if (t.template[i] is ZvrLocTemplate)
				{
					getItemsFromTemplate(t.template[i], a);
				}
				
			}
			
			return a;
			
		}
		
		private function getItemsFormValues(ref:ZvrLocVariableItem, a:Array):Array
		{
			if (!ref.values) return a;
			
			for (var i:int = 0; i < ref.values.length; i++) 
			{
				if (ref.values[i] is ZvrLocVariableItem)
				{
					if (a.indexOf(ZvrLocVariableItem(ref.values[i]).item) == -1) a.push(ZvrLocVariableItem(ref.values[i]).item);
					getItemsFormValues(ref.values[i], a);
				}
				else if (ref.values[i] is ZvrLocTemplate)
				{
					getItemsFromTemplate(ref.values[i], a);
				}
			}
			
			return a;
		}
		
		/*
		 * 
		 * TEMLATE TO STRING
		 * 
		 */
		
		public function getTemplateText(t:ZvrLocTemplate):String 
		{
			
			if (!t) return "";
			
			var s:String = "";
			
			for (var i:int = 0; i < t.template.length; i++) 
			{
				if (t.template[i] is ZvrPhaseJoint)
				{
					s += ZvrPhaseJoint(t.template[i]).separator;
				}
				
				if (t.template[i] is ZvrLocVariableItem)
				{
					s += getVariableItemText(t.template[i]);
				}
				
				if (t.template[i] is ZvrLocTemplate)
				{
					s += getTemplateText(t.template[i]);
				}
				
			}
			
			//trace(s);
			
			return s;
			
		}
		
		private function getVariableItemText(t:ZvrLocVariableItem):String 
		{
			var s:String = "";
			
			s = t.item.text;
			s = fillVariblesText(s, t.values);
			
			return s;
			
		}
		
		private function fillVariblesText(s:String, varibles:Array = null):String
		{
			if (!varibles)
			{
				return preapareText(s);
			}
			
			var v:Array = varibles.slice();
			
			var r:* = v.shift();
			s = preapareText(s);
			
			while (r != undefined)
			{
				
				if (r is ZvrLocVariableItem)
				{
					r = getVariableItemText(r);
				}
				
				if (r is ZvrLocTemplate)
				{
					r = getTemplateText(r);
				}
				
				s = s.replace(/\[[^\[]+\]/, r);
				r = v.shift();
			}
			
			return s;
		}
		
		private function preapareText(s:String):String
		{
			return s.split(String.fromCharCode(13)).join("\n");
		}
		
		/*
		 * 
		 * REFENRECE TO TEMPLATE
		 * 
		 */
		
		public function getTemplate(ph:ZvrLocPhrase):ZvrLocTemplate 
		{
			return fillTemplate(new ZvrLocTemplate(), ph);
		}
		
		private function fillTemplate(t:ZvrLocTemplate, ph:ZvrLocPhrase):ZvrLocTemplate 
		{
			for (var i:int = 0; i < ph.phrase.length; i++) 
			{
				var v:* = ph.phrase[i];
				
				switch (true) 
				{
					case v is ZvrPhaseJoint	:	t.template.push(v);															break;
					case v is ZvrLocRef		:	t.template.push(fillVariables(v));											break;
					case v is ZvrLocPhrase	:	t.template.push(fillTemplate(new ZvrLocTemplate(), v as ZvrLocPhrase));		break;
				}
			}
			
			return t;
			
		}
		
		private function fillVariables(r:ZvrLocRef):ZvrLocVariableItem
		{
			
			var a:Array = [];
			
			if (!r.values) return new ZvrLocVariableItem(getItem(r.reference));
			
			for (var i:int = 0; i < r.values.length; i++) 
			{
				
				var v:* = r.values[i];
				
				switch (true) 
				{
					case v is ZvrLocRef			:	a.push(fillVariables(v)); break;
					case v is ZvrLocPhrase		:	a.push(fillTemplate(new ZvrLocTemplate(), v)); break;
					default : a.push(v);
				}
			}
			
			return new ZvrLocVariableItem(getItem(r.reference), a);
			
		}
		
		
		/*
		 * 
		 * 
		 * UTILS 
		 * 
		 * 
		*/
		
		public function getTextsIn(s:String):Array
		{
			
			var p:Array = s.split(".")
			var n:String = p.shift();
			var c:String = p.join(".");
			
			var l:ZvrLocContent = _contentTypes[_langsTypes[_currentLang]][n];
			
			var list:XMLList = l.xml[c].text;

			var a:Array = []
			
			for each (var text:XML in list)
			{
				a.push(n + "." + c + "." + text.@name);
			}
			
			return a;
			
			/*
			for (var i:int = 0; i < ; i++) 
			{
				
			}*/
		}
		
		public function getAllItems():Array
		{
			var a:Array = [];
			
			for (var name:String in _items) 
			{
				a.push(_items[name]);
			}
			
			return a;
			
		}
		
		CONFIG::debug
		public function updateItem(item:ZvrLocItem, value:String):Boolean
		{
			var x:* = item.xml;
			x.parent().children()[x.childIndex()] = value;
			item.contentItem.save();
			return true;
		}
		
	}
}