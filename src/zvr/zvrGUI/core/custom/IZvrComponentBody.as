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
	import flash.events.IEventDispatcher;
	import zvr.zvrGUI.core.IZvrDisplayObject;

	public interface IZvrComponentBody extends IZvrDisplayObject
	{
		function addElement(element:Object):Object;
		function removeElement(element:Object):Object;
		
		function dispose():void;
	}
}
