package zvr.zvrLocalization 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocContentManager 
	{
		protected var _localization:ZvrLocalization;
		
		public function ZvrLocContentManager(localization:ZvrLocalization) 
		{
			_localization = localization;
		}
		
		public function getNewLocContent(name:String, lang:String):ZvrLocContent 
		{
			return null;
		}
		
		public function contentUpdated():void 
		{
			
		}
		
		protected function generateContent(content:Vector.<ZvrLocContent>, langsXML:XML):void
		{
			_localization.generateContent(content, langsXML);
		}
		
	}

}