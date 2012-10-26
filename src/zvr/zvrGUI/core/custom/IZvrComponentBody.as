/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 25.10.12
 * Time: 23:47
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.core.custom
{
	import flash.display.Stage;

	public interface IZvrComponentBody
	{

		function addElement(element:Object):Object;
		function removeElement(element:Object):Object;

		function set x(value:Number):void;
		function set y(value:Number):void;

		function get x():Number;
		function get y():Number;
		
		function set visible(v:Boolean):void
		
		function get stage():Stage;
		
	}
}
