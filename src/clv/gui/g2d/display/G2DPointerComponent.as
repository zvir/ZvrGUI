package clv.gui.g2d.display 
{
	import clv.gui.core.behaviors.IPointerComponent;
	import clv.gui.core.ComponentSignal;
	import clv.gui.core.Pointer;
	import com.genome2d.components.GComponent;
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import flash.utils.getTimer;
	import zvr.zvrTools.ZvrPntMath;
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
		
		public static function addTo(component:IG2DPointerComponent):G2DPointerComponent
		{
			var p:G2DPointerComponent = GNode(component.body.displayBody).addComponent(G2DPointerComponent) as G2DPointerComponent;
			p.init(component);
			return p;
		}
		
		public function init(component:IG2DPointerComponent):void
		{
			_component = component;
			
			GNode(component.body.displayBody).mouseEnabled = true;
			
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
			
			_component.app.pointer.onWheel.add(onWheel);
			_component.app.pointer.onMove.add(onGlobalMove);
		}
		
		private function removedFromApp(e:ComponentSignal):void 
		{
			_component.onAddedToApp.addOnce(addedToApp);
			
			node.onMouseDown	.remove(onMouseDown);	
			node.onMouseMove	.remove(onMouseMove);	
			node.onMouseOut     .remove(onMouseOut);   
			node.onMouseOver    .remove(onMouseOver);   
			node.onMouseUp      .remove(onMouseUp); 
			
			_component.app.pointer.onWheel.remove(onWheel);
			_component.app.pointer.onMove.remove(onGlobalMove);
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
			
			if (_pointer.drag)
			{
				_pointer.drag = false;
				_pointer.onDragEnd.dispatch(_pointer);
				_component.app.pointer.onUp.remove(appUp);
			}
		}
		
		private function onMouseOver(e:GNodeMouseSignal):void 
		{
			update(e);
			
			_pointer.over = true;
			
			_pointer.onRollOver.dispatch(_pointer);
			
			if (_component.app.pointer.down)
			{
				_pointer.onDragIn.dispatch(_pointer);
				_pointer.downTime = getTimer();
			}
		}
		
		private function onMouseOut(e:GNodeMouseSignal):void 
		{
			update(e);
			
			_pointer.over = false;
			
			_pointer.onRollOut.dispatch(_pointer);
			
			if (_component.app.pointer.down)
			{
				_pointer.onDragOut.dispatch(_pointer);
			}
			
			_pointer.down = false;
		}
		
		private function onMouseMove(e:GNodeMouseSignal):void 
		{
			
			_pointer.lastX = _pointer.x;
			_pointer.lastY = _pointer.y;
			
			update(e);
			
			_pointer.onMove.dispatch(_pointer);
			
			if (_pointer.down && !_pointer.drag)
			{
				var d:Number = Math.sqrt((_component.app.pointer.x -_pointer.downX) * (_component.app.pointer.x -_pointer.downX) + (_component.app.pointer.y -_pointer.downY) * (_component.app.pointer.y -_pointer.downY));
				
				if (d > _pointer.dragTrigerDistance && _pointer.dragTrigerDistance != 0)
				{
					_pointer.drag = true;
					_pointer.onDragBegin.dispatch(_pointer);
					_component.app.pointer.onUp.add(appUp);
				}
			}
			
		}
		
		private function appUp(p:Pointer):void 
		{
			if (_pointer.drag)
			{
				_pointer.drag = false;
				_pointer.onDragEnd.dispatch(_pointer);
			}
			_component.app.pointer.onUp.remove(appUp);
		}
		
		public function update(e:GNodeMouseSignal):void 
		{
			_pointer.lastX = _pointer.x
			_pointer.lastY = _pointer.y
			
			_pointer.x = e.localX;
			_pointer.y = e.localY;
		}
		
		public function updateGlobal(p:Pointer):void 
		{
			_pointer.lastGlobalX = _pointer.globalX;
			_pointer.lastGlobalY = _pointer.globalY;
			
			_pointer.globalX = p.x;
			_pointer.globalY = p.y;
		}
		
		private function onMouseDown(e:GNodeMouseSignal):void 
		{
			update(e);
			
			_pointer.downX = _component.app.pointer.x;
			_pointer.downY = _component.app.pointer.y;
			
			_pointer.down = true;
			_pointer.onDown.dispatch(_pointer);
			_pointer.downTime = getTimer();
			
			if (_pointer.dragTrigerDistance == 0 && !_pointer.drag)
			{
				_pointer.drag = true;
				_pointer.onDragBegin.dispatch(_pointer);
				_component.app.pointer.onUp.add(appUp);
			}
		}
		
		private function onWheel(p:Pointer):void 
		{
			if (!_pointer.over) return;
			_pointer.wheel = p.wheel;
			_pointer.onWheel.dispatch(_pointer);
		}
		
		private function onGlobalMove(p:Pointer):void 
		{
			updateGlobal(p);
			
			if (_pointer.drag)
			{
				_pointer.onDrag.dispatch(_pointer);
			}
			
		}
		
		public function get pointer():Pointer 
		{
			return _pointer;
		}
		
		
	}

}