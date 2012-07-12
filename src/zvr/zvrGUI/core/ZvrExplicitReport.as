package zvr.zvrGUI.core 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrExplicitReport 
	{
		public var x:String = ZvrExplicitBounds.NONE;
		public var y:String = ZvrExplicitBounds.NONE;
		public var width:String = ZvrExplicitBounds.WIDTH;
		public var height:String = ZvrExplicitBounds.HEIGHT;
		
		public function toString():String
		{
			return "x:" + x + " y:" + y + " width:" + width + " height:" + height;
		}
		
	}

}
	
	
	
	
	
	