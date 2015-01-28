package zvr.zvrLocalization 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	import zvr.zvrLocalization.utils.ZvrLocAS3Generator;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocCMFile extends ZvrLocContentManager 
	{
		
		private var _dir:File;
		
		public var generateClassesDir:File;
		public var generateClassesPack:String;
		
		public function ZvrLocCMFile(localization:ZvrLocalization) 
		{
			super(localization);
			
		}
		
		override public function contentUpdated():void 
		{
			super.contentUpdated();
			CONFIG::debug
			{
				ZvrLocAS3Generator.generatePathsClasses(generateClassesDir, generateClassesPack, _localization.items);
			}
		}
		
		override public function getNewLocContent(name:String, lang:String):ZvrLocContent 
		{
			var file:File = new File(_dir.nativePath + "\\" + name + "_" + lang.toUpperCase() + ".xml");
			var s:String = "<data lang=\"" + lang + "\" name=\"" + name + "\"></data>"
			var xml:XML = new XML(s);
			var c:ZvrLocContentFile = new ZvrLocContentFile();
			
			c.xml = xml;
			c.file = file;
			
			c.save();
			
			return c;
		}
		
		public function setContent(dir:File):void
		{
			_dir = dir;
			var list:Array = dir.getDirectoryListing();
			var fileStream:FileStream = new FileStream(); 
			
			var langsXML:XML;
			var content:Vector.<ZvrLocContent> = new Vector.<ZvrLocContent>();
			
			for (var i:int = 0; i < list.length; i++) 
			{
				var file:File = list[i];
				fileStream.open(file, FileMode.READ); 
				var xml:XML = XML(fileStream.readUTFBytes(fileStream.bytesAvailable)); 
				fileStream.close(); 
				
				if (file.name == "Languages.xml")
				{
					langsXML = xml;
					continue;
				}
				
				var c:ZvrLocContentFile = new ZvrLocContentFile();
				
				c.file = file;
				c.xml = xml;
				
				content.push(c);
			}
			
			generateContent(content, langsXML);
			
		}
		
		public function generateEMBEDxml(path:String, pack:String, name:String):void 
		{
			_dir = _dir.resolvePath(_dir.nativePath);
			_dir.createDirectory();
			
			var d:File = new File(path);
			d = d.resolvePath(d.nativePath);
			
			var r:String = d.getRelativePath(_dir, true);
			
			var s:String = ""
			+"package " + pack + " \n"
			+"{\n"
			+"\tpublic class " + name + " \n"
			+"\t{\n";
			
			var a:Array = [];
			
			for (var i:int = 0; i < _localization.content.length; i++) 
			{
				
				var n:String = ZvrLocContentFile(_localization.content[i]).file.name.replace(/ /g, "");
				
				//var e:String = "[Embed(source=\"" + r + "/" + n + "\")]";
				
				var nc:String = _localization.content[i].xml.@name + "_" + _localization.content[i].xml.@lang;
				
				//s += "		" + e + "\n";
				//s += "		private static const " + nc + ":Class;\n";
				//s += "		private static const " + nc + "XML"+":XML = new XML(new "+nc+"());\n";
				s += "		private static const " + nc + "XML"+":XML = "+_localization.content[i].xml.toXMLString().replace(/>\W+</g, "><")+";\n";
				s += "		\n";
				s += "		\n";
				
				
				a.push(nc + "XML");
			}
			
			s += "		public static const CONTENT:Vector.<XML> = new <XML>["+a.join(", ")+"];";
			s += "		\n";
			s += "		\n";
			s += "		public static const LANGS:XML = "+_localization.langsXML.toXMLString().replace(/>\W+</g, "><")+";";
			s += "		\n";
			s += "		\n";
			s += "" 
			+"\t}\n"
			+"}";
			
			//trace(s);
			
			var file:File = new File(path + name + ".as");
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(s);
			fileStream.close();
			
		}
	}

}