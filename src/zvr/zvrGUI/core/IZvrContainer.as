/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 25.10.12
 * Time: 01:26
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.core
{
	import flash.geom.Rectangle;

	import zvr.zvrGUI.core.vo.IZvrComponentObject;

	import zvr.zvrGUI.layouts.ZvrLayout;
	
	[Event(name="elementAdded",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="elementRemoved",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="cotntentSizeChanged",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="contentPositionChanged",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	
	public interface IZvrContainer extends IZvrComponentObject
	{

		function get contentAreaWidth():Number;

		function get contentAreaHeight():Number;

		function addComponent(child:IZvrComponent):IZvrComponent;

		function removeComponent(child:IZvrComponent):IZvrComponent;

		function getNumElements():int;

		function getElementAt(index:int):IZvrComponent;

		function getElementIndex(element:IZvrComponent):int;

		function setElementIndex(child:IZvrComponent, index:int):void;

		function setContentsPosition(x:Number, y:Number):void;

		function setLayout(layout:Class):void;

		function get layout():ZvrLayout;

		function get contentRect():Rectangle;

		function get childrenAreaWidth():Number;

		function get childrenAreaHeight():Number;

		function get presentElements():Vector.<IZvrComponent>;

		function get contentPadding():ZvrContentPadding

		function get childrenPadding():ZvrContentPadding

		function get maskingEnabled():Boolean

		function set maskingEnabled(value:Boolean):void

		function get contentHeightAreaIndependent():Boolean

		function get contentWidthAreaIndependent():Boolean

	}
}
