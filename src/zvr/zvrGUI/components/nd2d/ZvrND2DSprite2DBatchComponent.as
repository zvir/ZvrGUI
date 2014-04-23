package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	import zvr.zvrGUI.core.custom.ZvrComponentBase;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSprite2DBatchComponent extends ZvrComponentBase implements IZvrSkinLayer, IZvrND2DComponent
	{
		
		public function ZvrND2DSprite2DBatchComponent(skinClass:Class, bodyClass:Class)
		{
			super(skinClass, bodyClass);
		}
		
		public function get node():Node2D
		{
			return Sprite2DBatch(body);
		}
		
	}

}