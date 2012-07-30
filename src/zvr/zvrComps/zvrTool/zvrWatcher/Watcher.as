package zvr.zvrComps.zvrTool.zvrWatcher 
{
	import adobe.utils.CustomActions;
	import flash.utils.Dictionary;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class Watcher 
	{
		
		private static var _watcher:ZvrWatcher;
		public static var watches:Dictionary = new Dictionary();
		
		public static function updateWatch(sender:Object, name:String, value:* = null):ZvrWatchItem
		{
			var objSender:Object;
			var w:ZvrWatchItem;
			
			var newWatch:Boolean = new Boolean();
			
			
			
			if (!watches[sender])
			{
				watches[sender] = new Object();
			}
			
			
			if (watches[sender][name] == undefined)
			{
				w =  new ZvrWatchItem();
				watches[sender][name] = w;
				w.sender = sender;
				w.name = name;
				w.value = value;
				if (watcher) watcher.addWatch(watches[sender][name]);
				return w;
			}
			
			w = watches[sender][name];
			w.value = value;
			if (watcher) watcher.updateWatch(w);
			
			return w;
		}
		
		public static function deleteWatch(sender:Object, name:String):void
		{
			if (!watches[sender]) return;
			if (watches[sender][name] == undefined) return;
			
			if (watcher) 
			{
				watcher.deleteWatch(watches[sender][name]);
			}
			
			delete watches[sender][name]
		}
		
		static public function get watcher():ZvrWatcher 
		{
			return _watcher;
		}
		
		static public function set watcher(value:ZvrWatcher):void 
		{
			_watcher = value;
			
			for each (var item:Object in watches) 
			{
				for each (var watch:ZvrWatchItem in item) 
				{
					watcher.addFirstWatch(watch);
				}
			}
			
		}
		
	}

}