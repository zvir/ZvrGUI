package zvr.zvrGUI.behaviors 
{
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrRollOverHilight extends ZvrBehavior
	{
		
		private var _mouseOver:Boolean = false;
		private var _mouseDown:Boolean = false;
		
		public static const NAME:String = "RollOver";
		
		
		public function ZvrRollOverHilight() 
		{
			super("RollOver");
			_stageSensitive = true;
		}
		
		override protected function enable():void
		{
			ZvrComponent(component).focusRect = false;
			ZvrComponent(component).addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			ZvrComponent(component).addEventListener(Event.REMOVED_FROM_STAGE, componentRemovedFromStage);
		}
		
		private function componentRemovedFromStage(e:Event):void 
		{
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
		
		private function stageMouseUp(e:MouseEvent):void 
		{
			ZvrComponent(component).addEventListener(MouseEvent.ROLL_OUT, mouseOut);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			_mouseOver = true;
			ZvrComponent(component).addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			
			if (e && e.buttonDown)
			{
				ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
				return;
			}
			
			ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			ZvrComponent(component).addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			component.addState(ZvrStates.HILIGHT);
			
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			_mouseOver = false;
			
			ZvrComponent(component).stage && ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
			
			if (e && e.buttonDown)
			{
				component.onStage && ZvrComponent(component).stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
				return;
			}
			
			ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			ZvrComponent(component).addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			ZvrComponent(component).removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			component.removeState(ZvrStates.HILIGHT);	
		}
		
		private function stageMouseCheckOut(e:MouseEvent):void 
		{
			_mouseDown = false;
			
			if (!component.onStage) return;
			
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
			
			if (!_mouseOver) 
				mouseOut(null);
		}
		
		private function stageMouseCheckOver(e:MouseEvent):void 
		{
			_mouseDown = false;
			
			if (!component.onStage) return;
			
			ZvrComponent(component).stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
			
			if (_mouseOver) 
				mouseOver(null);
		}
		
		override protected function disable():void
		{
			ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			ZvrComponent(component).removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			component.removeState(ZvrStates.HILIGHT);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
	}

}