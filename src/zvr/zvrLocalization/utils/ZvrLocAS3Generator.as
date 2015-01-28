package zvr.zvrLocalization.utils 
{
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocAS3Generator 
	{
		
		
		CONFIG::debug
		public static function generatePathsClasses(dir:File, pack:String, items:Object):void
		{			
			dir.deleteDirectory(true);
			dir.createDirectory();
			
			var t:Object = { };
			var a:Array = [];
			
			for (var n:String in items) 
			{
				if (t[items[n].contentType] == undefined) t[items[n].contentType] = [];
				t[items[n].contentType].push(n);
			}
			
			for (n in t)
			{
				var name:String = n.substr(0,1).toUpperCase() + n.substr(1)
				saveClass(new File(dir.nativePath + "\\" + name + ".as"), pack, name, t[n]);
			}
			
		}
		
		CONFIG::debug
		private static function saveClass(file:File, pack:String, name:String, names:Array):void
		{
			//_generate = true;
			
			names.sort();
			
			var s:String = ""
			+"package " + pack + " \n"
			+"{\n"
			+"\tpublic class " + name + " \n"
			+"\t{\n";
			
			for (var i:int = 0; i < names.length; i++) 
			{
				var v:String = names[i];
				
				var a:Array = v.split(".");
				a.shift();
				var v2:String = a.join(".");
				
				s += "\t\tpublic static const "+v2.replace(/\./g, "_") + ":String = \""+v+"\";\n";
			}
			
			s += "" 
			+"\t}\n"
			+"}";
			
			//trace(s);
			
			var fileStream:FileStream = new FileStream();
			fileStream.open(file, FileMode.WRITE);
			fileStream.writeUTFBytes(s);
			fileStream.close();
			
		}
	}

}