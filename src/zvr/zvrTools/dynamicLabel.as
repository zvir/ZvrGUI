package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public function dynamicLabel(s:String, ... rest):String
	{
		var r:String = rest.shift();
		
		while (r)
		{
			s = s.replace(/{[^{]+}/, r);
			r = rest.shift();
		}
		
		return s;
	}

}