package clv.gui.core 
{
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class IndependentBounds 
	{
		
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		
		public var l:Number = 0.0;
		public var r:Number = 0.0;
		
		public var t:Number = 0.0;
		public var b:Number = 0.0;
		
		public var w:Number = 0.0;
		public var h:Number = 0.0;
		
		public function IndependentBounds() 
		{
			
		}
		
		public function get W():Number
		{
			return l + r + w;
		}
		
		public function get H():Number
		{
			return t + b + h;
		}
		
		public function get R():Number
		{
			return l + r + w + x;
		}
		
		public function get B():Number
		{
			return t + b + h + y;
		}
		
		public function get T():Number
		{
			return y - t;
		}
		
		public function get L():Number
		{
			return x - l;
		}
		
	}

}