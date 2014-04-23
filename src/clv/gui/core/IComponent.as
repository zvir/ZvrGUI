package clv.gui.core 
{
	import clv.gui.clv;
	import clv.gui.core.behaviors.Behaviors;
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.skins.Skin;
	import com.genome2d.signals.GMouseSignal;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public interface IComponent 
	{
		function isCurrentState(state:String):Boolean;
		
		function hasState(state:String):Boolean;
		
		function update(cell:Rectangle):void 
		
		function added(container:Container):void;
		
		function removed(container:Container):void;
		
		function addState(state:String):void;
		
		function removeState(state:String):void;
		
		function getStyle(styleName:String):*;
		
		function setStyle(styleName:String, value:*, state:* = null):void;
		
		function prepareForUpdate():void;
		
		function get onPostUpdate():Signal;
		
		function get componentSignal():ComponentSignal;
		
		function get includeInLayout():Boolean;
		function set includeInLayout(v:Boolean):void;
		
		function get delegateStates():IComponent;
		function set delegateStates(value:IComponent):void;
		
		function get combineWithDelegateStates():Boolean;
		function set combineWithDelegateStates(v:Boolean):void;
		
		function get behaviors():Behaviors;
		
		function set minHeight(value:Number):void;
		function set maxHeight(value:Number):void;
		function set minWidth(value:Number):void;
		function set maxWidth(value:Number):void;
		
		function set width(value:Number):void;
		
		function set height(value:Number):void;
		
		
		function get width():Number;
		function get height():Number;
		
		
		function get fBottom():Number;
		
		function set fRight(value:Number):void;
		
		function set fLeft(value:Number):void;
		
		function set fTop(value:Number):void;
		
		function get cellWidth():Number;
		
		function get cellHeight():Number;
		
		function get transformDirty():Boolean;
		
		function get x():Number;
		function set x(value:Number):void 
		
		function get y():Number;
		function set y(value:Number):void 
		
		function get bottom():Number;
		function set bottom(value:Number):void 
		
		function get right():Number;
		function set right(value:Number):void 
		
		function get left():Number;
		function set left(value:Number):void;
		
		function get top():Number;
		function set top(value:Number):void;
		
		function get vCenter():Number;
		function set vCenter(value:Number):void;
		
		function get hCenter():Number;
		function set hCenter(value:Number):void;
		
		function get independentBounds():IndependentBounds;
		
		function get present():Boolean;
		
		function get app():Application;
		
		function get skin():Skin;
		
		function get currentStates():Array;
		
		function get container():Container;
		
		function get body():IComponentBody;
		
		function get bounds():Rectangle;
		
		function get states():Array;
		
		function get onStateChange():Signal;
		
		function get onPresentsChange():Signal;
		
		function get onRemovedFromApp():Signal;
		
		function get onAddedToApp():Signal;
		
		
		
	}
	
}