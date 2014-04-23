package zvr.zvrLANConnection 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLANMessage implements IZvrLANMessage
	{
		
		private var _id:Number;
		
		public function ZvrLANMessage() 
		{
			
		}
		
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