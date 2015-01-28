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
		
		public static function getOrdinalSuffix(value:int):String
		{
			
			if (value >= 10 && value <= 20)
			return 'th';

			switch (value % 10)
			{
				case 0:
				case 4:
				case 5:
				case 6:
				case 7:
				case 8:
				case 9:
					return 'th';
				case 3:
					return 'rd';
				case 2:
					return 'nd';
				case 1:
					return 'st';
				default:
					return '';
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