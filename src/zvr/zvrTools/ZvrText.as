package zvr.zvrTools 
{
	import com.adobe.utils.NumberFormatter;
	import utils.number.format;
		

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
		
		public static function beforeLength(length:int, t:String, symbol:String = " "):String
		{
			if (symbol.length == 0) return t;
			
			while (t.length < length)
			{
				t = symbol + t;
			}
			
			return t;
			
		}
		
		public static function afterLength(length:int, t:String, symbol:String = " "):String
		{
			if (symbol.length == 0) return t;
			
			while (t.length < length)
			{
				t = t + symbol;
			}
			
			return t;
			
		}
	}

}