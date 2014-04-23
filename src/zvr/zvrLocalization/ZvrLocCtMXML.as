package zvr.zvrLocalization 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocCtMXML extends ZvrLocContentManager 
	{
		
		public function ZvrLocCtMXML(localization:ZvrLocalization) 
		{
			super(localization);
		}
		
		override public function getNewLocContent(name:String, lang:String):ZvrLocContent 
		{
			var s:String = "<data lang=\"" + lang + "\" name=\"" + name + "\"></data>"
			var xml:XML = new XML(s);
			var c:ZvrLocContent = new ZvrLocContent();
			
			c.xml = xml;
			c.save();
			
			return c;
		}
		
		public function setContent(langXML:XML, languages:Vector.<XML>):void
		{
			var content:Vector.<ZvrLocContent> = new Vector.<ZvrLocContent>();
			
			for (var i:int = 0; i < languages.length; i++) 
			{
				var c:ZvrLocContent = new ZvrLocContent();
				
				c.xml = languages[i];
				content.push(c);
			}
			
			generateContent(content, langXML);
			
		}
		
	}

}