/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.10.12
 * Time: 23:42
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.skins.base
{
	public interface IZvrSkin
	{

		function get body():IZvrSkinLayer;

		function get shell():IZvrSkinLayer;

		function get width():Number;

		function get height():Number;

		function get availbleBehaviors():Array;

		function setStyle(styleName:String, value:*, state:* = null):Boolean;

		function forceUpdateSize():void;

		function getStyle(styleName:String):*;

		function styleToString(styleName:String):String;

		function getStylesRegistration(styleName:String):ZvrSkinStyle;
	}
}
