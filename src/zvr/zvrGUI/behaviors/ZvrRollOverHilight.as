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
			component.focusRect = false;
			component.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			component.addEventListener(Event.REMOVED_FROM_STAGE, componentRemovedFromStage);
		}
		
		private function componentRemovedFromStage(e:Event):void 
		{
			component.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
			component.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
		}
		
		private function mouseDown(e:MouseEvent):void 
		{
			_mouseDown = true;
			component.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseUp);
		}
		
		private function stageMouseUp(e:MouseEvent):void 
		{
			component.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
		}
		
		private function mouseOver(e:MouseEvent):void 
		{
			_mouseOver = true;
			component.addEventListener(MouseEvent.ROLL_OUT, mouseOut);
			
			if (e && e.buttonDown)
			{
				component.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
				return;
			}
			
			component.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			component.addEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			component.addState(ZvrStates.HILIGHT);
			
		}
		
		private function mouseOut(e:MouseEvent):void 
		{
			_mouseOver = false;
			
			component.stage && component.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
			
			if (e && e.buttonDown)
			{
				component.stage && component.stage.addEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
				return;
			}
			
			component.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			component.addEventListener(MouseEvent.ROLL_OVER, mouseOver);
			component.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDown);
			
			component.removeState(ZvrStates.HILIGHT);	
		}
		
		private function stageMouseCheckOut(e:MouseEvent):void 
		{
			_mouseDown = false;
			
			if (!component.stage) return;
			
			component.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOut);
			
			if (!_mouseOver) 
				mouseOut(null);
		}
		
		private function stageMouseCheckOver(e:MouseEvent):void 
		{
			_mouseDown = false;
			
			if (!component.stage) return;
			
			component.stage.removeEventListener(MouseEvent.MOUSE_UP, stageMouseCheckOver);
			
			if (_mouseOver) 
				mouseOver(null);
		}
		
		override protected function disable():void
		{
			component.removeEventListener(MouseEvent.ROLL_OUT, mouseOut);
			component.removeEventListener(MouseEvent.ROLL_OVER, mouseOver);
			component.removeState(ZvrStates.HILIGHT);
		}
		
		override public function destroy():void
		{
			super.destroy();
		}
		
	}

}