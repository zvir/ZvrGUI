/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.10.12
 * Time: 23:29
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.skins.base
{
	public interface IZvrSkinLayer
	{
		function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void;

		function removeEventListener(type:String,listener:Function,useCapture:Boolean = false):void;
	}
}
