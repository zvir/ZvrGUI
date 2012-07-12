package zvr.zvrGUI.core 
{
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrComponetStoredSetup 
	{
		
		public var x				:Number;
		public var y				:Number;
		public var width			:Number;
		public var height			:Number;
		
		
		public var autoSize			:String;
		
		public var left				:Number;
		public var right			:Number;
		public var top				:Number;
		public var bottom			:Number;
		
		public var percentWidth		:Number;
		public var percentHeight	:Number;
		
		public var verticalCenter	:Number;
		public var horizontalCenter	:Number;
		
		public var maxWidth			:Number;
		public var minWidth			:Number;
			
		public var maxHeight		:Number;
		public var minHeight		:Number;
			
		public var explicit			:ZvrExplicitBounds;
		public var visible			:Boolean;
		
		public function ZvrComponetStoredSetup() 
		{
			
		}
		
	}

}