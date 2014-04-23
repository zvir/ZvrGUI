package zvr.zvrLocalization 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocItem 
	{
		
		public var content:Object = {};
		public var name:String;
		public var textFields:Vector.<ZvrLocTF> = new Vector.<ZvrLocTF>();
		public var currentText:String;
		public var contentType:String;
		
		
		public function ZvrLocItem() 
		{
			
		}
		
		public function updateTFs():void 
		{
			for (var i:int = 0; i < textFields.length; i++) 
			{
				textFields[i].updateText();
			}
		}
		
		public function get text():String
		{
			return content[currentText].content.toString();
		}
		
		public function get xml():XML
		{
			return content[currentText].content;
		}
		
		public function set xml(v:*):void
		{
			content[currentText].content = v;
		}
		
		public function get contentItem():ZvrLocContentItem
		{
			return content[currentText];
		}
	}

}