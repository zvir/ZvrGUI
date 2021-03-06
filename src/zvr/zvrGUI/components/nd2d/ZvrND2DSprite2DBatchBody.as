package zvr.zvrGUI.components.nd2d
{
	import zvr.zvrGUI.core.custom.*;
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2DBatch;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSprite2DBatchBody extends Sprite2DBatch implements IZvrComponentBody 
	{
		
		public function ZvrND2DSprite2DBatchBody() 
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