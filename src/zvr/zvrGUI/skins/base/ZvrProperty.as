package zvr.zvrGUI.skins.base 
{
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrComponent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrProperty 
	{
		
		public var component:IZvrComponent;
		public var property:String;
		
		public function ZvrProperty(component:IZvrComponent, property:String)
		{
			this.component = component;
			this.property = property;
		}
		
	}

}