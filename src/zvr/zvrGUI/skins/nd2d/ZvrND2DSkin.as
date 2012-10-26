/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 25.10.12
 * Time: 16:48
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.skins.nd2d
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;

	import zvr.zvrGUI.skins.base.IZvrSkinLayer;

	public class ZvrND2DSkin extends Sprite2D implements IZvrSkinLayer
	{
		public function ZvrND2DSkin(textureObject:Texture2D = null)
		{
			super(textureObject);
		}
	}
}
