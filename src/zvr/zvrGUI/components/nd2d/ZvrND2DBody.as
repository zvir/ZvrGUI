package zvr.zvrGUI.components.nd2d
{
	import zvr.zvrGUI.core.custom.*;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.display.Stage;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DBody extends Node2D implements IZvrComponentBody, IZvrSkinLayer 
	{
		
		public function ZvrND2DBody() 
		{
			super();
		}
		
		/* INTERFACE zvr.zvrGUI.core.custom.IZvrComponentBody */
		
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