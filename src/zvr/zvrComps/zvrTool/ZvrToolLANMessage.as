package zvr.zvrComps.zvrTool 
{
	import zvr.zvrLANConnection.IZvrLANMessage;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToolLANMessage implements IZvrLANMessage
	{
		private var _id:Number;
		
		public var trContent:String;
		
		public function ZvrToolLANMessage() 
		{
			
		}
		
		/* INTERFACE zvr.zvrLANConnection.IZvrLANMessage */
		
		public function get id():Number 
		{
			return _id;
		}
		
		public function set id(value:Number):void 
		{
			_id = value;
		}
		
	}

}