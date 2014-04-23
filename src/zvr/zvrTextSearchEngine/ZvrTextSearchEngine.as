package zvr.zvrTextSearchEngine 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTextSearchEngine 
	{
		
		public static function search(string:String, content:Array):Vector.<ZvrTSEResult>
		{
			var results:Vector.<ZvrTSEResult> = new Vector.<ZvrTSEResult>();
			
			string = string.toLowerCase();
			string = string.replace(/[^\w\d\s]/g, " ");
			string = string.replace(/\s+/g, " ");
			
			var searches:Array = string.split(" ");
			
			for (var j:int = 0; j < content.length; j++) 
			{
				
				var result:ZvrTSEResult = new ZvrTSEResult();
				
				result.index = j;
				
				for (var i:int = 0; i < searches.length; i++) 
				{
					var r:RegExp = new RegExp(searches[i], "g");
					
					var s:String = content[j];
					s = s.toLowerCase();
					
					var a:Array = s.match(r);
					
					for (var k:int = 0; k < a.length; k++) 
					{
						
						var f:String = a[k];
						
						var l:int = s.search(f);
						
						//trace(f, l, f.length);
						
						result.matches.push([l, f.length]);
						
						if (result.words.indexOf(f) == -1) result.words.push(f);
						
					}
					
				}
				
				if (result.matches.length > 0) 
				{
					results.push(result);
					result.computePower();
				}
				
			}
			
			results.sort(sort);
			
			
			return results;
			
		}
		
		static private function sort(r1:ZvrTSEResult, r2:ZvrTSEResult):int
		{
			if (r1.power > r2.power) return -1;
			return 1;
		}
		
	}

}