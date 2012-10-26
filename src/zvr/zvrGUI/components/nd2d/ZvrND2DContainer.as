package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DContainer extends ZvrContainerBase
	{
		
		public function ZvrND2DContainer(skinClass:Class, bodyClass:Class)
		{
			super(skinClass, bodyClass);
		}
		
		public function get node():Node2D
		{
			return Node2D(body);
		}
		
	}

}