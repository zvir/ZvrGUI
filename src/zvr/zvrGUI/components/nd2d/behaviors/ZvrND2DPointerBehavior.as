package zvr.zvrGUI.components.nd2d.behaviors 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.getTimer;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.nd2d.IZvrND2DComponent;
	import zvr.zvrGUI.core.ZvrStates;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DPointerBehavior extends ZvrBehavior
	{
		public static const NAME:String = "Pointer";
		
		private var _downTime:int;
		
		public function ZvrND2DPointerBehavior()
		{
			super(NAME);
		}
		
		override protected function enable():void 
		{
			super.enable();
			
			if (node.stage)
			{
				addedToStage(null);
			}
			else
			{
				node.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function addedToStage(e:Event):void 
		{
			node.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			node.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			
			node.addEventListener(Event.DEACTIVATE, deactivated);
			node.addEventListener(Event.ACTIVATE, activated);
		}
		
		private function removedFromStage(e:Event):void 
		{
			node.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			node.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			component.removeState(ZvrStates.DOWN);
			node.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			node.removeEventListener(Event.DEACTIVATE, deactivated);
			node.removeEventListener(Event.ACTIVATE, activated);
		}
		
		private function activated(e:Event):void 
		{
			
		}
		
		private function deactivated(e:Event):void 
		{
			component.removeState(ZvrStates.DOWN);
			component.removeState(ZvrStates.OVER);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			node.addEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			component.addState(ZvrStates.OVER);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			_downTime = getTimer();
			node.stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			component.addState(ZvrStates.DOWN);
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			node.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			if (getTimer() - _downTime < 400)
			{
				component.dispatchEvent(new MouseEvent(MouseEvent.CLICK));
			}
			
			component.removeState(ZvrStates.DOWN);
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			node.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			node.addEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			
			component.removeState(ZvrStates.OVER);
		}
		
		override protected function disable():void 
		{
			super.disable();
			
			node.removeEventListener(MouseEvent.MOUSE_OUT, mouseOut);
			node.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			if (node.stage) node.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
			
			node.removeEventListener(MouseEvent.MOUSE_OVER, mouseOver);
			
		}
		
		private function get node():Node2D
		{
			return IZvrND2DComponent(component).node;
		}
		
	}

}