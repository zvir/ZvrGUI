package zvr.zvrGUI.core 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrContainerSizeManager 
	{
		private var _container:IZvrContainer;

		public function ZvrContainerSizeManager(container:IZvrContainer)
		{
			_container = container;
			
		}
		
		public function dispose():void 
		{
			_container = null;
		}
		
	}

}