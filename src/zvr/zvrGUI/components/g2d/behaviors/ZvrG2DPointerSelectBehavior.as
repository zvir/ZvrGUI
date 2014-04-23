package zvr.zvrGUI.components.g2d.behaviors 
{
	import com.genome2d.node.GNode;
	import com.genome2d.signals.GNodeMouseSignal;
	import flash.geom.Point;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import zvr.zvrGUI.behaviors.ZvrBehavior;
	import zvr.zvrGUI.components.g2d.IZvrG2DComponent;
	import zvr.zvrGUI.components.g2d.ZvrG2DBody;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DPointerSelectBehavior extends ZvrBehavior
	{
		
		public static const NAME:String = "PointerSelect";
		static public const POINTER_SELECT:String = "pointerSelect";
		
		public var timeOut:int = 300;
		public var positionThreshold:Number = 20;
		
		private var _lastPosition:Point = new Point();
		private var _lastTime:int;
		
		public function ZvrG2DPointerSelectBehavior() 
		{
			super(NAME);
		}
		override protected function enable():void 
		{
			super.enable();
			
		//	node.onMouseDown.addOnce(mouseDown);
			node.onMouseUp.add(mouseUp);
			node.onMouseDown.add(mouseDown);
		}
		
		override protected function disable():void 
		{
			super.disable();
			node.onMouseUp.remove(mouseUp);
			node.onMouseDown.remove(mouseDown);
		}
		
		private function mouseDown(e:GNodeMouseSignal):void 
		{
			trace("mouseDown");
			_lastTime = getTimer();
			
			_lastPosition.x = node.core.getContext().getNativeStage().mouseX;
			_lastPosition.y = node.core.getContext().getNativeStage().mouseY;
			
		}
		
		private function mouseUp(e:GNodeMouseSignal):void 
		{
			
			if (e.target != e.dispatcher) return;
			
			var p:Point = new Point(node.core.getContext().getNativeStage().mouseX, node.core.getContext().getNativeStage().mouseY);
			
			if (Point.distance(p, _lastPosition) < positionThreshold && getTimer() - _lastTime < timeOut)
			{
				trace(">");
				node.onPointerSelect.dispatch(new GNodeMouseSignal(POINTER_SELECT, e.target, e.dispatcher, e.localX, e.localY));
			}
			
			
		}
		
		private function get node():ZvrG2DBody
		{
			return IZvrG2DComponent(component).node;
		}
	}

}