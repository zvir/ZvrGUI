package clv.gui.core 
{
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class CointanerSignal 
	{
		public var cointainer:ICointainer;
		public var child:IComponent;
		
		public function CointanerSignal(cointainer:ICointainer, child:IComponent = null) 
		{
			this.cointainer = cointainer;
			this.child = child;
			
		}
		
	}

}