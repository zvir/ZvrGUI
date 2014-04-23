package clv.gui.g2d.display 
{
	import clv.gui.core.behaviors.IPointerComponent;
	import clv.gui.core.ComponentSignal;
	import clv.gui.core.Pointer;
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class G2DPointerComponent extends GComponent
	{
		private var _pointer:Pointer;
		private var _component:IPointerComponent;
		
		public function G2DPointerComponent(p_node:GNode) 
		{
			super(p_node);
		}
		
		public function init(component:IG2DPointerComponent):void
		{
			_component = component;
			_pointer = component ? component.pointer : null;
			
			if (_pointer)
			{
				if (!_component.app)
				{
					_component.onAddedToApp.addOnce(addedToApp);
				}
				else
				{
					addedToApp(null);
				}
			}
		}
		
		private function addedToApp(e:ComponentSignal):void 
		{
			_component.onRemovedFromApp.addOnce(removedFromApp);
			
			node.onMouseDown	.add(onMouseDown);	
			node.onMouseMove	.add(onMouseMove);	
			node.onMouseOut     .add(onMouseOut);   
			node.onMouseOver    .add(onMouseOver);   
			node.onMouseUp      .add(onMouseUp); 
		}
		
		private function removedFromApp(e:ComponentSignal):void 
		{
			_component.onAddedToApp.addOnce(addedToApp);
			
			node.onMouseDown	.remove(onMouseDown);	
			node.onMouseMove	.remove(onMouseMove);	
			node.onMouseOut     .remove(onMouseOut);   
			node.onMouseOver    .remove(onMouseOver);   
			node.onMouseUp      .remove(onMouseUp); 
		}
		
		private function onMouseUp(e:GNodeMouseSignal):void 
		{
			update(e);
			_pointer.down = false;
			_pointer.onUp.dispatch(_pointer);
			
			if (getTimer() - _pointer.downTime < _pointer.pointTimeInterval)
			{
				_pointer.onPoint.dispatch(_pointer);
			}
			
		}
		
		private function onMouseOver(e:GNodeMouseSignal):void 
		{
			update(e);
			
			_pointer.onRollOver.dispatch(_pointer);
			
			if (_component.app.poniner.down)
			{
				_pointer.onDragIn.dispatch(_pointer);
				_pointer.downTime = getTimer();
			}
		}
		
		private function onMouseOut(e:GNodeMouseSignal):void 
		{
			update(e);
			
			_pointer.onRollOut.dispatch(_pointer);
			
			if (_component.app.poniner.down)
			{
				_pointer.onDragOut.dispatch(_pointer);
			}
		}
		
		private function onMouseMove(e:GNodeMouseSignal):void 
		{
			update(e);
			_pointer.onMove.dispatch(_pointer);
		}
		
		public function update(e:GNodeMouseSignal):void 
		{
			_pointer.x = e.localX;
			_pointer.y = e.localY;
		}
		
		private function onMouseDown(e:GNodeMouseSignal):void 
		{
			update(e);
			_pointer.down = true;
			_pointer.onDown.dispatch(_pointer);
			_pointer.downTime = getTimer();
		}
		
		
	}

}