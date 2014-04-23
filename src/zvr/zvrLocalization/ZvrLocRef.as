package zvr.zvrLocalization 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocRef 
	{
		public var values:Array;
		public var reference:String;
		
		public function ZvrLocRef(reference:String = null, values:Array = null) 
		{
			this.values = values;
			this.reference = reference;
		}
		
		/*public function get values():Array 
		{
			return _values;
		}
		
		public function set values(value:Array):void 
		{
			_values = value;
		}
		
		public function get reference():String 
		{
			return _reference;
		}
		
		public function set reference(value:String):void 
		{
			
			if (!value || value == "")
			{
				throw new Error("Empty reference");
			}
			
			_reference = value;
		}*/
		
	}

}