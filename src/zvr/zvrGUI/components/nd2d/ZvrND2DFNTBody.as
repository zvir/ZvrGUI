package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrGUI.core.custom.IZvrComponentBody;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrND2D.FNTSprite;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DFNTBody extends FNTSprite implements IZvrComponentBody, IZvrSkinLayer
	{
		
		public function ZvrND2DFNTBody() 
		{
			super(null);
		}
		
		public function addElement(element:Object):Object 
		{
			return null;
		}
		
		public function removeElement(element:Object):Object 
		{
			return null;
		}
		
	}

}