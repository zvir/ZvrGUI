package clv.gui.g2d.behaviors 
{
	import clv.gui.common.states.ButtonState;
	import clv.gui.core.behaviors.Behavior;
	import clv.gui.core.Pointer;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ButtonBehavior extends Behavior
	{
		public static const NAME:String = "ButtonBehavior";
		
		
		private var pointerSensitive:GNode;
		private var onClick:Signal;
		
		
		
		public function ButtonBehavior() 
		{
			super("ButtonBehavior");
			_stageSensitive = true;
		}
		
		override protected function enable():void 
		{
			//if (enabled) return;
			
			super.enable();
			
			pointerSensitive = IButtonComponent(component).pointerSensitive;
			
			pointerSensitive.mouseEnabled = true;
			
			pointerSensitive.onMouseDown.add(onMouseDown);
			
			pointerSensitive.onMouseOut.add(onMouseOut);
			
			pointerSensitive.onMouseOver.add(onMouseOver);
			
			onClick = IButtonComponent(component).onClick;
			
		}
		
		override protected function disable():void 
		{
			//if (!enabled) return;
			
			super.disable();
			
			pointerSensitive.onMouseUp.remove(onMouseUpClick);
			pointerSensitive.onMouseDown.remove(onMouseDown);
			pointerSensitive.onMouseOut.remove(onMouseOut);
			pointerSensitive.onMouseOver.remove(onMouseOver);
			component.app.poniner.onUp.remove(onMouseUp);
			
			component.removeState(ButtonState.OVER);
			component.removeState(ButtonState.DOWN);
			
			pointerSensitive = null;
		}
		
		
		private function onMouseOver(e:GNodeMouseSignal):void 
		{
			//component.removeState(ButtonState.OUT);
			component.addState(ButtonState.OVER);
		}
		
		private function onMouseOut(e:GNodeMouseSignal):void 
		{
			component.removeState(ButtonState.OVER);
			//component.addState(ButtonState.OUT);
		}
		
		private function onMouseUp(p:Pointer):void 
		{
			pointerSensitive.onMouseUp.remove(onMouseUpClick);
			component.removeState(ButtonState.DOWN);
			//component.addState(ButtonState.UP);
		}
		
		private function onMouseDown(e:GNodeMouseSignal):void 
		{
			component.addState(ButtonState.DOWN);
			//component.removeState(ButtonState.UP);
			
			component.app.poniner.onUp.addOnce(onMouseUp);
			
			pointerSensitive.onMouseUp.addOnce(onMouseUpClick);
			
		}
		
		private function onMouseUpClick(e:GNodeMouseSignal):void 
		{
			onClick.dispatch();
		}
		
		
		
	}

}