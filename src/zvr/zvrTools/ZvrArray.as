package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Michał Zwieruho
	 * @email michal@zvir.pl
	 * @www http://www.zvir.pl
	 */
	public final class ZvrArray
	{
		public static function findIndexInArray(value:Object, arr:Array):Number
		{
			for (var i:uint=0; i < arr.length; i++) {
				if (arr[i]==value) {
					return i;
				}
			}
			return NaN;
		}
	}
}