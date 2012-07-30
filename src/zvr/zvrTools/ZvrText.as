package zvr.zvrTools 
{
		

	/**
	 * ...
	 * @author	Michał Zwieruho "Zvir"
	 * @www		$(WWW)
	 * @email	$(Email)
	 */
	
	public class ZvrText
	{
		
		public static function getOrdinalSuffix(nr:int):String
		{
			var t:String = String(nr).substr( -1, 1);
			
			if (nr > 20)
			{
				switch (t) {
					case "1": return "st";
					case "2": return "nd";
					case "3": return "rd";
					default:  return "th";
				}
			}
			else
			{
				switch (nr) {
					case 1: return "st";
					case 2: return "nd";
					case 3: return "rd";
					default:  return "th";
				}
			}
			
			return "";
			
		}
		
	}

}