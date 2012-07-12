package zvr.zvrComps.zvrTool.zvrTracy 
{
	import flash.utils.getTimer;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class Tracy 
	{
		public static var tracy:ZvrTracy;
		private static var _counter:uint = 0;
		
		public static function addTrace(args:Array):void
		{
			
			for (var i:int = 0; i < args.length; i++) 
			{
				if (args[i] == null) args[i] = "null";
				if (args[i] == undefined) args[i] = "undefined";
			}
			
			var s:String = args.join(" ");
			
			if (tracy && s == "clearTr")
			{
				tracy.clear();
				return;
			}
			
			tracy && tracy.addTrace(_counter, s);
			_counter++;
		}
	}
}