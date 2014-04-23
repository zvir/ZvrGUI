package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class Spacer 
	{
		private var _space:Number;
		private var _offset:Number;
		
		private var _counter:int;
		
		public function Spacer(offset:Number, space:Number) 
		{
			_offset = offset;
			_space = space;
		}
		
		public function get next():Number
		{
			return _offset + _space * _counter++;
		}
		
		public function get repeat():Number
		{
			return _offset + _space * (_counter-1);
		}
		
		public function reset():void
		{
			_counter = 0;
		}
		
		public function get(v:int):Number
		{
			return _offset + _space * v;
		}
		
	}

}