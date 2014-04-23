package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrCondition
	{
		
		
		public static const less:int = -1;
		public static const more:int = 1;
		
		protected var condition:int;
		
		protected var f:Object;
		protected var t:Object;
		
		protected var p:Object;
		protected var input:Object;
		
		public function ZvrCondition(input:Object)
		{
			this.input = input
		}
		
		public static function IF(v:int):ZvrCondition
		{
			return new ZvrCondition(v);
		}
		
		public function LESS_THEN(v:Object):ZvrCondition
		{
			condition = -1;
			p = v;
			return this;
		}
		
		public function GRATER_THEN(v:Object):ZvrCondition
		{
			condition = 1;
			p = v;
			return this;
		}
		
		public function THEN(v:Object):ZvrCondition
		{
			t = v;
			return this;
		}
		
		public function ELSE(v:Object):ZvrCondition
		{
			f = v;
			return this;
		}
		
		public function compute(v:Object):Object
		{
			if (condition < 0)
			{
				if (v < p) return getTrue(); else return getFalse();
			}
			else
			{
				if (v > p) return getTrue(); else return getFalse();
			}

		}
		
		private function getFalse():Object 
		{
			if (f) return f;
			return false;
		}
		
		private function getTrue():Object 
		{
			if (t) return t;
			return true;
		}
	}

}