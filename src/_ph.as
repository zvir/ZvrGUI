package  
{
	import zvr.zvrLocalization.phase.ZvrLocPhrase;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
		
	public function _ph(... args):ZvrLocPhrase 
	{
		return new ZvrLocPhrase(args);
	}
	

}