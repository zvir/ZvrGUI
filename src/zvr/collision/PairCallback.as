package zvr.collision 
{
	import de.polygonal.motor2.collision.nbody.IPairCallback;
	/**
	 * ...
	 * @author Zvir
	 */
	public class PairCallback implements IPairCallback
	{
		
		public function PairCallback() 
		{
			
		}
		
		public function pairAdded(proxyShape1:QuadTreeObj, proxyShape2:QuadTreeObj):void 
		{
			trace("pairAdded");
		}
		
		public function pairRemoved(proxyShape1:QuadTreeObj, proxyShape2:QuadTreeObj):void 
		{
			trace("pairRemoved");
		}
		
	}

}