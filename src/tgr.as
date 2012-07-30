package  
{
	import zvr.zvrComps.zvrTool.zvrToggler.Toggler;
	import zvr.zvrComps.zvrTool.zvrToggler.ZvrTogglerItem;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	 
	
	public function tgr(name:String):ZvrTogglerItem 
	{
		CONFIG::release
		{
			throw new Error("WCH");
		}
		
		return Toggler.addToggler(name);
	}
	

}