/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.11.12
 * Time: 17:33
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.behaviors
{
	import flash.geom.Rectangle;

	public interface IZvrDragable
	{
		function get vertical():Boolean;

		function set vertical(value:Boolean):void;

		function get horizontal():Boolean;

		function set horizontal(value:Boolean):void;

		function get limit():Rectangle;

		function set limit(value:Rectangle):void;

		function get dragging():Boolean;
	}
}
