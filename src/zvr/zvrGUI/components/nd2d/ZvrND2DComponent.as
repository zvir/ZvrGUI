package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import zvr.zvrGUI.core.custom.ZvrComponentBase;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DComponent extends ZvrComponentBase
	{
		
		public function ZvrND2DComponent(skinClass:Class, bodyClass:Class)
		{
			super(skinClass, bodyClass);
		}
		
		public function get node():Node2D
		{
			return Node2D(body);
		}
		
	}

}