/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 25.10.12
 * Time: 01:58
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.core.vo
{
	public interface IZvrContainerContents
	{

		function get x():Number;

		function set x(value:Number):void;

		function get y():Number;

		function set y(value:Number):void;

		function addMask(mask:IZvrContainerMask):void

		function removeMask(mask:IZvrContainerMask):void

	}
}
