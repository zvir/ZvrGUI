/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.10.12
 * Time: 23:38
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.core.vo
{
	import zvr.zvrGUI.core.*;
	import flash.geom.Rectangle;

	import zvr.zvrGUI.behaviors.ZvrComponentBehaviors;

	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.base.ZvrSkinStyle;

	public interface IZvrComponentObject extends IZvrComponent
	{
		function addSkinLayer(skinLayer:IZvrSkinLayer):void

		function addShellLayer(skinLayer:IZvrSkinLayer):void

		function updateShellDepth(skinLayer:IZvrSkinLayer):void
	}
}
