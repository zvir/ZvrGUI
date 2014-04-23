package zvr.zvrLocalization.phase 
{
	import zvr.zvrLocalization.ZvrLocItem;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocVariableItem 
	{
		
		public var item:ZvrLocItem;
		public var values:Array
		
		public function ZvrLocVariableItem(item:ZvrLocItem, values:Array = null) 
		{
			this.values = values;
			this.item = item;
		}
		
	}

}