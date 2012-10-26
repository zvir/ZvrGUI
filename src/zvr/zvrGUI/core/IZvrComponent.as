/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.10.12
 * Time: 21:19
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.core
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.custom.IZvrComponentBody;

	import zvr.zvrGUI.behaviors.ZvrComponentBehaviors;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.base.ZvrSkinStyle;

	public interface IZvrComponent
	{

		function get x():Number;
		function set x(value:Number):void;

		function get y():Number;
		function set y(value:Number):void;

		function get top():Number;
		function set top(value:Number):void
		
		function set right(value:Number):void
		function get right():Number
		
		function get bottom():Number
		function set bottom(value:Number):void
		
		function set left(value:Number):void
		function get left():Number
		
		function set percentHeight(value:Number):void
		function get percentHeight():Number
		
		function set percentWidth(value:Number):void
		function get percentWidth():Number
		
		function get width():Number;
		function set width(value:Number):void;

		function get height():Number;
		function set height(value:Number):void;

		function get maxWidth():Number;
		function set maxWidth(value:Number):void;

		function get minWidth():Number;
		function set minWidth(value:Number):void;

		function get maxHeight():Number;
		function set maxHeight(value:Number):void;

		function get minHeight():Number;
		function set minHeight(value:Number):void;

		function get skin():ZvrSkin;

		function get bounds():Rectangle;

		function get independentBounds():Rectangle;

		function get independentWidth():Boolean;

		function get independentHeight():Boolean;

		function get autoSize():String;

		/**
		 * Auto size mode of ckeeptiner. Static values are kept in ZvrAutoSizelass to help.
		 * @param	- mode of autoSize
		 * <ul>
		 * <li><i>manual</i> - no auto size</li>
		 * <li><i>content</i> - auto size to content width and height</li>
		 * <li><i>contentWidth</i> - auto size to content width</li>
		 * <li><i>contentHeight</i> - auto size to content height</li>
		 * </ul>
		 */

		function set autoSize(value:String):void;

		function get behaviors():ZvrComponentBehaviors;

		function setStyle(styleName:String, value:*, state:* = null):void;

		function getStyle(styleName:String):*;

		function get owner():IZvrContainer;

		function addState(state:String):void;

		function removeState(state:String):void;

		function get currentStates():Array;

		function hasState(state:String):Boolean;

		function get states():Array;

		function checkState(state:String):Boolean;

		function manageStates(add:Object, remove:Object):void;

		function set includeIn(value:*):void;

		function set excludeIn(value:*):void;

		function get includeInLayout():Object;

		function set includeInLayout(value:Object):void;

		function get present():Boolean;

		function get delegateStates():IZvrComponent;

		function set delegateStates(component:IZvrComponent):void;

		function get combineWithDelegateStates():Boolean;

		function set combineWithDelegateStates(value:Boolean):void;

		function getStylesRegistration(styleName:String):ZvrSkinStyle;

		function get visible():Boolean;

		//function hasOwnProperty(propertyName:String):Boolean;

		function addEventListener(type:String,listener:Function,useCapture:Boolean = false,priority:int = 0,useWeakReference:Boolean = false):void;

		function removeEventListener(type:String,listener:Function,useCapture:Boolean = false):void;

		function dispatchEvent(event:Event):Boolean;

		function validateBounds(dispatchEvents:Boolean = true, exitMassChange:Boolean = false):void

		function addToContainer(container:IZvrContainer):void

		function removeFromContainer(container:IZvrContainer):void

		function get onStage():Boolean;

		function get explicit():ZvrExplicitReport;

		function enterMassChangeMode():void;

		function exitMassChangeMode():void;
		
		function get body():IZvrComponentBody;
		
	}
}
