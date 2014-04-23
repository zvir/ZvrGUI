package zvr.zvrND2D 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class DynamicFileTextureEvent extends Event 
	{
		
		static public const READY:String = "ready";
		static public const LOADING:String = "loading";
		static public const PROGRESS:String = "progress";
		
		public var totalBytes:int;
		public var loadedBytes:int;
		public var dynamicTexture:DynamicFileTexture;
		
		
		public function DynamicFileTextureEvent(type:String, dynamicTexture:DynamicFileTexture, loadedBytes:int, totalBytes:int, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			
			this.totalBytes = totalBytes;
			this.loadedBytes = loadedBytes;
			this.dynamicTexture = dynamicTexture;
		} 
		
		public override function clone():Event 
		{ 
			return new DynamicFileTextureEvent(type, dynamicTexture, loadedBytes, totalBytes, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("DynamicFileTextureEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
		public function get progress():Number 
		{
			return loadedBytes/totalBytes;
		}
		
	}
	
}