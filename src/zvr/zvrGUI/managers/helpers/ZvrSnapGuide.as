package zvr.zvrGUI.managers.helpers 
{
	import zvr.zvrGUI.core.ZvrComponent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSnapGuide 
	{
		public var component:ZvrComponent;
		public var value:Number;
		
		public function ZvrSnapGuide(component:ZvrComponent, value:Number)
		{
			this.component = component;
			this.value = value;
		}
	}

}