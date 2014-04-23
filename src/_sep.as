package  
{
	import zvr.zvrLocalization.phase.ZvrPhaseJoint;

		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
		
	public function _sep(separator:String):ZvrPhaseJoint 
	{
		return new ZvrPhaseJoint(separator);
	}
	

}