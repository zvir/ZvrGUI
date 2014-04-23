package  
{
	import zvr.zvrLocalization.ZvrLocRef;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
		
	public function _ref(reference:String, ...rest):ZvrLocRef 
	{
		return new ZvrLocRef(reference, rest);
	}
	

}