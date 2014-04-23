package zvr.zvrLocalization 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocContentItem 
	{
		
		public var item:ZvrLocItem;
		public var content:XML;
		public var lang:String;
		public var file:ZvrLocContent;
		
		public function ZvrLocContentItem() 
		{
			
		}
		
		public function save():void
		{
			file.save();
			item.updateTFs();
		}
		
	}

}