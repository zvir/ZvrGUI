package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import zvr.zvrGUI.core.custom.IZvrComponentBody;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSprite2DBody extends Sprite2D implements IZvrComponentBody, IZvrSkinLayer
	{
		
		public function ZvrND2DSprite2DBody()
		{
			super(null);
		}
		
		public function addElement(element:Object):Object 
		{
			return addChild(element as Node2D);
		}
		
		public function removeElement(element:Object):Object 
		{
			removeChild(element as Node2D);
			return null;
		}
		
	}

}