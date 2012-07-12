package zvr.zvrComps.zvrTool.zvrToggler 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class Toggler 
	{
		
		public static var toggler:ZvrToggler;
		private static const emptyTogglerItem:ZvrTogglerItem = new ZvrTogglerItem();
		
		public static function addToggler(name:String):ZvrTogglerItem
		{
			if (toggler)			
				return toggler.addToggler(name);
			else
				return emptyTogglerItem;
		}
		
	}

}