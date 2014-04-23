package zvr.zvrGUI.components.g2d 
{
	import flash.events.Event;
	import flash.display.Stage;
	import zvr.zvrG2D.FNTNode;
	import zvr.zvrG2D.G2DFont;
	import zvr.zvrGUI.core.custom.IZvrComponentBody;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DFNTBody extends FNTNode implements IZvrComponentBody, IZvrSkinLayer
	{
		
		
		public function ZvrG2DFNTBody() 
		{
			super(null);
		}
		
		public function addElement(element:Object):Object 
		{
			return null;
		}
		
		public function removeElement(element:Object):Object 
		{
			return null;
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
			return isOnStage() ? core.getContext().getNativeStage() : null;
		}
		
		public function get mouseX():Number 
		{
			return 0;
		}
		
		public function get mouseY():Number 
		{
			return 0;
		}
		
		public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false):void 
		{
			
		}
		
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false):void 
		{
			
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