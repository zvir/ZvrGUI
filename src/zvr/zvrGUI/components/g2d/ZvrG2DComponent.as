package zvr.zvrGUI.components.g2d 
{
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.core.custom.ZvrComponentBase;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DComponent extends ZvrComponentBase implements IZvrG2DComponent
	{
		
		public function ZvrG2DComponent(skinClass:Class, bodyClass:Class)
		{
			super(skinClass, bodyClass);
		}
		
		public function get node():ZvrG2DBody
		{
			return ZvrG2DBody(body);
		}
		
	}

}