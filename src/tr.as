package  
{
	import zvr.zvrComps.zvrTool.zvrTracy.Tracy;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	 
	 
	/**
	 * Trace method for ZvrTool. Works like build in trace().
	 * <p>Displays message in ZvrTracy output window</p>
	 * @param	arguments any message, value or data to be tresentend as text, agumentes are separated with comma ",". 
	 * If <b>"clearTr"</b> clears an output;
	 * */
		
	public function tr(... args):void 
	{
		Tracy.addTrace(args);
	}
	

}