package zvr.zvrGUI.utils 
{
	import flash.utils.Dictionary;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class Counter 
	{
		
		
		private static const content:Dictionary = new Dictionary();
		
		public static function count(o:*, v:*):int
		{
			if (content[o] == undefined) content[o] = new Object();

			if (content[o][v] == undefined) content[o][v] = -1;
			
			content[o][v] = content[o][v] + 1;
			
			return content[o][v];
		}
		
		
	}

}