package zvr.zvrTextSearchEngine 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTSEResult 
	{
		public var index:int;
		public var matches:Array = [];
		public var words:Array = [];
		
		public var power:int;
		
		public function ZvrTSEResult() 
		{
			
		}
		
		public function computePower():void 
		{
			power = matches.length + words.length;
		}
		
	}

}