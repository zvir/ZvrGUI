package zvr.zvrBehaviors.pointer 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPointerSignal 
	{
		
		static public const MOVE:String = "move";
		static public const BEGIN:String = "begin";
		static public const END:String = "end";
		
		public var type:String;
		
		public var id:int;
		
		public var globalX:Number;
		public var globalY:Number;
		
		public var localY:Number;
		public var localX:Number;
		
		public function ZvrPointerSignal(type:String, id:int, globalX:Number,globalY:Number,localY:Number,localX:Number) 
		{
			this.type = type;
			this.id = id;
			this.globalX = globalX;
			this.globalY = globalY;
			this.localY = localY;
			this.localX = localX;
		}
		
	}

}

