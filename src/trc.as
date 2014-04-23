package  
{
	import flash.utils.getTimer;
	import utils.type.getClass;
	import utils.type.getName;
	import zvr.zvrComps.zvrTool.zvrTracer.Tracer;
	import zvr.zvrComps.zvrTool.zvrTracer.ZvrTraceMessage;
	import zvr.zvrGUI.core.ZvrItemRenderer;
	import zvr.zvrTools.ZvrTime;
		

	/**
	 * ...
	 * @author	Michał Zwieruho "Zvir"
	 * @www		$(WWW)
	 * @email	$(Email)
	 * 
	 * Method for adding entries in ZvrTracer window.
	 * @param	sender 
	 * Object which is reporting.
	 * @param	message
	 * Message, main subject of report.
	 * @param	key
	 * Key is used for updating the entry.
	 * When for secont time there is trc calles with the same "key", it's updates
	 * the message and args of first entry with this key. Main use of this feature
	 * is reporting objeets whitch states is changing quckly with a lot of updates
	 * e.g loaders
	 * @param	...args additional arguments to be shown in report.
	 * @return retuns created instance of ZvrTracyMessage, or the one with given "key".
	 * @example 
	 * <codeblock>
	 * trc(this, "Loading", "", "progress, Number(e.bytesLoaded/e.bytesTotal).toFixed(2));
	 * </codeblock>
	 */
	
	
		
	public function trc(sender:Object, message:String, key:String = "", ...args):ZvrTraceMessage
	{		
		
		if (sender is ZvrItemRenderer) return null;
		
		var id			:int 		= Tracer.notifyCounter;
		var k			:String 	= key;
		var senderType	:String		= getName(getClass(sender));
		var senderName	:String 	= sender.hasOwnProperty("name") ? sender.name : "";
		var time		:int 		= getTimer();
		var timeDelta	:int		= time - Tracer.notifyLastTime;
		var msg			:String 	= message;
		var values		:Array		= args;
		
		
		
		var m:ZvrTraceMessage = Tracer.trc(id, k, senderType, senderName, time, timeDelta, msg, values);

		//trace(m);
		
		return m;
	}

}