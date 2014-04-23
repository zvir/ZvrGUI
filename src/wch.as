package  
{
	import flash.utils.getTimer;
	import utils.type.getClass;
	import utils.type.getName;
	import zvr.zvrComps.zvrTool.zvrWatcher.Watcher;
	import zvr.zvrComps.zvrTool.zvrWatcher.ZvrWatchItem;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrTools.ZvrTime;
		

	/**
	 * ...
	 * @author	Michał Zwieruho "Zvir"
	 * @www		$(WWW)
	 * @email	$(Email)
	 */
	
		
	public function wch(sender:Object, name:String, value:* = null, del:Boolean = false):ZvrWatchItem
	{
		
		CONFIG::release
		{
			return null;
			//throw new Error("WCH");
		}
		
		if (del)
		{
			Watcher.deleteWatch(sender, name);
			return null;
		}
		
		var w:ZvrWatchItem = Watcher.updateWatch(sender, name, value);
		
		return w;
	}

}