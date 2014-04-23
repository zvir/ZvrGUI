package zvr.zvrGUI.components.g2d
{
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import flash.events.Event;
	import org.osflash.signals.Signal;
	import zvr.zvrGUI.core.custom.*;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.display.Stage;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DBody extends GNode implements IZvrComponentBody, IZvrSkinLayer 
	{
		
		private var _onPointerSelect:Signal = new Signal(GNodeMouseSignal);
		
		public function ZvrG2DBody() 
		{
			super();
		}
		
		/* INTERFACE zvr.zvrGUI.core.custom.IZvrComponentBody */
		
		public function addElement(element:Object):Object 
		{
			addChild(element as GNode);
			return element;
		}
		
		public function removeElement(element:Object):Object 
		{
			removeChild(element as GNode);
			return element;
		}
		
		/* INTERFACE zvr.zvrGUI.core.custom.IZvrComponentBody */
		
		public function set x(value:Number):void 
		{
			transform.x = value;
		}
		
		public function set y(value:Number):void 
		{
			transform.y = value;
		}
		
		public function get x():Number 
		{
			return transform.x;
		}
		
		public function get y():Number 
		{
			return transform.y;
		}
		
		public function set visible(value:Boolean):void 
		{
			transform.visible = value;
		}
		
		public function get stage():Stage 
		{
			return core ? core.getContext().getNativeStage() : null;
		}
		
		public function get mouseX():Number 
		{
			return 0;
		}
		
		public function get mouseY():Number 
		{
			return 0;
		}
		
		public function get onPointerSelect():Signal 
		{
			return _onPointerSelect;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			return;
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			return;
		}
		
		public function dispatchEvent(event:Event):Boolean 
		{
			return false;
		}
		
		public function hasEventListener(type:String):Boolean 
		{
			return false;
		}
		
		public function willTrigger(type:String):Boolean 
		{
			return false;
		}
		
	}

}