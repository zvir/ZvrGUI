package zvr.zvrGUI.components.g2d.behaviors 
{
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.events.MouseEvent;
	import flash.system.TouchscreenType;
	import flash.ui.Multitouch;
	/*
	import flash.events.Event;
	import flash.events.MouseEvent;*/
	import flash.utils.getTimer;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.g2d.IZvrG2DComponent;
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.core.ZvrStates;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DPointerBehavior extends ZvrBehavior
	{
		public static const NAME:String = "Pointer";
		
		private var _downTime:int;
		
		public function ZvrG2DPointerBehavior()
		{
			super(NAME);
		}
		
		override protected function enable():void 
		{
			super.enable();
			
			if (node.isOnStage())
			{
				addedToStage();
			}
			else
			{
				node.onAddedToStage.addOnce(addedToStage);
			}
			
			node.core.root.mouseEnabled = true;
			node.mouseEnabled = true;
			
		}
		
		private function addedToStage():void 
		{
			node.onRemovedFromStage.addOnce(removedFromStage);
			
			if (!Multitouch.supportsTouchEvents) node.onMouseOver.addOnce(mouseOver);
			node.onMouseDown.addOnce(mouseDown);
		}
		
		private function removedFromStage():void 
		{
			
			node.onAddedToStage.addOnce(addedToStage);
			component.removeState(ZvrStates.DOWN);
		}
		
		private function mouseOver(e:GNodeMouseSignal):void 
		{			
			node.onMouseOut.addOnce(mouseOut);
			component.addState(ZvrStates.OVER);
		}
		
		private function mouseDown(e:GNodeMouseSignal):void 
		{
			node.core.root.onMouseUp.addOnce(mouseUp);
			component.addState(ZvrStates.DOWN);
			
			if (Multitouch.supportsTouchEvents)
			{
				component.addState(ZvrStates.OVER);
			}
		}
		
		private function mouseUp(e:GNodeMouseSignal):void 
		{
			node.onMouseDown.addOnce(mouseDown);
			component.removeState(ZvrStates.DOWN);
			
			if (Multitouch.supportsTouchEvents)
			{
				component.removeState(ZvrStates.OVER);
			}
		}
		
		private function mouseOut(e:GNodeMouseSignal):void 
		{
			node.onMouseOver.addOnce(mouseOver);
			component.removeState(ZvrStates.OVER);
		}
		
		override protected function disable():void 
		{
			super.disable();
			
			node.onMouseOut.remove(mouseOut);
			node.onMouseDown.remove(mouseDown);
			node.onMouseOver.remove(mouseOver);
			
			component.removeState(ZvrStates.OVER);
			component.removeState(ZvrStates.DOWN);
			
			if (node.isOnStage()) node.core.root.onMouseUp.remove(mouseUp);
		}
		
		private function get node():GNode
		{
			return IZvrG2DComponent(component).node;
		}
		
	}

}