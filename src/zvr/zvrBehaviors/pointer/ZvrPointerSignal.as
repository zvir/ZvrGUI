package zvr.zvrBehaviors.pointer 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPointerSignal 
	{
		
		public var id:int;
		
		public var globalX:Number;
		public var globalY:Number;
		
		public var localY:Number;
		public var localX:Number;
		
		public var lastGlobalX:Number;
		public var lastGlobalY:Number;
		
		public var down:Boolean;
		
		public var wheelDelta:Number = 0;
		
		public function ZvrPointerSignal(id:int, globalX:Number,globalY:Number,localY:Number,localX:Number, wheelDelta:Number = 0) 
		{
			
			trace(" new point ");
			
			this.id = id;
			this.globalX = globalX;
			this.globalY = globalY;
			
			this.lastGlobalX = globalX;
			this.lastGlobalY = globalY;
			
			this.localY = localY;
			this.localX = localX;
			this.wheelDelta = wheelDelta;
		}
		
	}

}

