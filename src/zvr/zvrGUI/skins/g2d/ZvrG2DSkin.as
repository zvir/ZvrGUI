/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 25.10.12
 * Time: 16:48
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.skins.g2d
{
	import com.genome2d.core.GNode;
	import com.genome2d.textures.GTexture;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;

	import zvr.zvrGUI.skins.base.IZvrSkinLayer;

	public class ZvrG2DSkin extends GNode implements IZvrSkinLayer
	{
		public function ZvrG2DSkin()
		{
			super();
		}
		
		/* INTERFACE zvr.zvrGUI.skins.base.IZvrSkinLayer */
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			
		}
	}
}
