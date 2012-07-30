package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Michał Zwieruho
	 * @email michal@zvir.pl
	 * @www http://www.zvir.pl
	 */
	public class ZvrNetReasult
	{
		static public function serverInfoToObject(source:Object):Array
		{
			var reasult:Array = new Array();
			
			for (var i:int = 0; i < source.initialData.length; i++) 
			{
				reasult[i] = new Object();
				for (var j:int = 0; j <source.initialData[i].length ; j++) 
				{
					reasult[i][source.columnNames[j]] = source.initialData[i][j];
				}
			}
			return reasult;
		}
	}
}