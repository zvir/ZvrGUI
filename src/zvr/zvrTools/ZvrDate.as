package zvr.zvrTools
{
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrDate
	{
		
		public static function getMySQLDate(date:Date):String
		{
			var s:String = date.fullYear + '-';
			
			if (date.month < 10)
			{
				s += '0' + (date.month + 1) + '-';
			}
			else
			{
				s += (date.month + 1) + '-';
			}
			
			if (date.date < 10)
			{
				s += '0' + date.date;
			}
			else
			{
				s += date.date;
			}
			
			return s;
		}
	
	}

}