package zvr.zvrGUI.managers
{
	import flash.display.Graphics;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrApplication;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrExplicitBounds;
	import zvr.zvrGUI.core.ZvrExplicitReport;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrDragBehaviorEvent;
	import zvr.zvrGUI.events.ZvrResizeBehaviorEvent;
	import zvr.zvrGUI.managers.helpers.ZvrSnapGuide;
	import zvr.zvrGUI.managers.helpers.ZvrSnaps;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrKeyboard.ZvrKeyboard;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSnapManager
	{
		
		// TODO Auto layounting (snaping through top bottom, parenting from aplication etc.)
		
		private var _application:ZvrApplication;
		private var _components:Vector.<ZvrComponent> = new Vector.<ZvrComponent>();
		private var _snaps:/*ZvrSnaps*/Dictionary = new Dictionary();
		
		private var _verticalGuides:Vector.<ZvrSnapGuide> = new Vector.<ZvrSnapGuide>();
		private var _horizontalGuides:Vector.<ZvrSnapGuide> = new Vector.<ZvrSnapGuide>();
		
		public var gap:Number = 15;
		public var snap:Number = 10;
		
		private var _updatateGuides:Boolean = false;
		
		public function ZvrSnapManager(application:ZvrApplication)
		{
			_application = application;
			_application.addEventListener(ZvrComponentEvent.RESIZE, componentChange);
			_application.addEventListener(ZvrComponentEvent.MOVE, componentChange);
			_application.addEventListener(Event.EXIT_FRAME, exitFrame);
		}
		
		private function exitFrame(e:Event):void
		{
			if (!_updatateGuides)
				return;
			_updatateGuides = false;
			updatateGuides();
			
			drawSnaps();
		
		}
		
		private function updatateGuides():void
		{
			
			_horizontalGuides.length = 0;
			_verticalGuides.length = 0;
			
			for (var i:int = 0; i < _components.length; i++)
			{
				var comp:ZvrComponent = _components[i];
				_horizontalGuides.push(new ZvrSnapGuide(comp, comp.bounds.x), new ZvrSnapGuide(comp, comp.bounds.right + gap));
				_verticalGuides.push(new ZvrSnapGuide(comp, comp.bounds.y), new ZvrSnapGuide(comp, comp.bounds.bottom + gap));
			}
			
			_horizontalGuides.push(new ZvrSnapGuide(_application, _application.bounds.x + gap), new ZvrSnapGuide(_application, _application.bounds.right));
			_verticalGuides.push(new ZvrSnapGuide(_application, _application.bounds.y + gap), new ZvrSnapGuide(_application, _application.bounds.bottom));
			
			///tr("updatateGuides");
		}
		
		private function resizing(e:ZvrResizeBehaviorEvent):void
		{
			if (ZvrKeyboard.CTRL.pressed) return;
			
			var comp:IZvrComponent = e.component;
			var prevent:Boolean = false;
			var i:int;

			comp.enterMassChangeMode();
			
			_snaps[comp].right = null;
			_snaps[comp].bottom = null;
			
			for (i = 0; i < _horizontalGuides.length; i++)
			{
				if (_horizontalGuides[i].component != comp)
				{
					if (Math.abs(comp.bounds.right - e.delta.x - _horizontalGuides[i].value + gap) < snap)
					{
						prevent = true;
						comp.x = comp.bounds.x;
						comp.width = _horizontalGuides[i].value - comp.bounds.x - gap;
						e.delta.x = 0;
						_snaps[comp].right = _verticalGuides[i];
					}
				}
			}
			
			for (i = 0; i < _verticalGuides.length; i++)
			{
				if (_verticalGuides[i].component != comp)
				{
					if (Math.abs(comp.bounds.bottom - e.delta.y - _verticalGuides[i].value  + gap) < snap)
					{
						prevent = true;
						comp.y = comp.bounds.y;
						comp.height = _verticalGuides[i].value - comp.bounds.y - gap;
						e.delta.y = 0;
						_snaps[comp].bottom = _verticalGuides[i];
					}
				}
			}
			comp.exitMassChangeMode();
			
			if (prevent) e.preventDefault();
			
			_updatateGuides = true;
		}
		
		private function dragging(e:ZvrDragBehaviorEvent):void
		{
			
			if (ZvrKeyboard.CTRL.pressed) return;
			
			var comp:IZvrComponent = e.component;
			
			var i:int;
			var snapGuide:ZvrSnapGuide;
			var exp:ZvrExplicitReport;
			exp = comp.explicit;
			
			comp.enterMassChangeMode();
			
			var prevent:Boolean = false;
			
			_snaps[comp].left = null;
			_snaps[comp].right = null;
			_snaps[comp].bottom = null;
			_snaps[comp].top = null;
			
			for (i = 0; i < _horizontalGuides.length; i++)
			{
				snapGuide = _horizontalGuides[i];
				
				if (snapGuide.component != comp)
				{
					if (Math.abs(comp.bounds.x + e.delta.x - snapGuide.value) < snap)
					{
						comp.x = snapGuide.value;
						prevent = true;
						e.delta.x = 0;
						_snaps[comp].left = snapGuide;
					}
					
					if (Math.abs(comp.bounds.right + e.delta.x - snapGuide.value + gap) < snap)
					{
						if (exp.width != ZvrExplicitBounds.WIDTH) comp.width = comp.bounds.width;
						comp.x = snapGuide.value - comp.bounds.width - gap;
						prevent = true;
						e.delta.x = 0;
						_snaps[comp].right = snapGuide;
						
						if (snapGuide.component == _application) break;						
					}
				
				}
			}
			
			for (i = 0; i < _verticalGuides.length; i++)
			{
				
				snapGuide = _verticalGuides[i];
				
				if (snapGuide.component != comp)
				{
					if (Math.abs(comp.bounds.y + e.delta.y - snapGuide.value) < snap)
					{	
						comp.y = snapGuide.value;
						prevent = true;
						e.delta.y = 0;
						_snaps[comp].top = snapGuide;
					}
					else if (Math.abs(comp.bounds.bottom + e.delta.y - snapGuide.value  + gap) < snap)
					{
						comp.y = snapGuide.value - comp.bounds.height - gap;
						prevent = true;
						e.delta.y = 0;		
						_snaps[comp].bottom = snapGuide;
					}
				}
			}
			
			comp.exitMassChangeMode();
			
			if (prevent) e.preventDefault();
			
			_updatateGuides = true;
		}
		
		public function enableSnaping(component:ZvrComponent):void
		{
			if (_components.indexOf(component) != -1)
				return;
			_components.push(component);
			
			var dragable:ZvrDragable = component.behaviors.getBehavior(ZvrDragable.NAME) as ZvrDragable;
			var resizable:ZvrResizable = component.behaviors.getBehavior(ZvrResizable.NAME) as ZvrResizable;
			
			dragable.addEventListener(ZvrDragBehaviorEvent.DRAGGING, dragging);
			dragable.addEventListener(ZvrDragBehaviorEvent.STOP_DRAG, draggingStop);
			resizable.addEventListener(ZvrResizeBehaviorEvent.RESIZING, resizing);
			resizable.addEventListener(ZvrResizeBehaviorEvent.STOP_RESIZE, resizeStop);
			
			component.addEventListener(ZvrComponentEvent.RESIZE, componentChange);
			component.addEventListener(ZvrComponentEvent.MOVE, componentChange);
			
			_snaps[component] = new ZvrSnaps;
			
		}
		
		private function resizeStop(e:ZvrResizeBehaviorEvent):void 
		{
			finishSnapping(e.component);
		}
		
		private function draggingStop(e:ZvrDragBehaviorEvent):void 
		{
			finishSnapping(e.component);
		}
		
		private function finishSnapping(comp:IZvrComponent):void
		{
			var exp:ZvrExplicitReport;
			exp = comp.explicit;
			
			if (_snaps[comp].right && _snaps[comp].right.component is ZvrApplication)
			{
				comp.right = gap;
			}
			
			if (_snaps[comp].left && _snaps[comp].left.component is ZvrApplication)
			{
				comp.left = gap;
			}
			
			if (_snaps[comp].bottom && _snaps[comp].bottom.component is ZvrApplication)
			{
				comp.bottom = gap;
			}
			
			if (_snaps[comp].top && _snaps[comp].top.component is ZvrApplication)
			{
				comp.top = gap;
			}
		}
		
		public function disableSnaping(component:ZvrComponent):void
		{
			var i:int = _components.indexOf(component);
			if (i == -1)
				return;
			_components.splice(i, 1);
			
			var dragable:ZvrDragable = component.behaviors.getBehavior(ZvrDragable.NAME) as ZvrDragable;
			var resizable:ZvrResizable = component.behaviors.getBehavior(ZvrResizable.NAME) as ZvrResizable;
			
			dragable.removeEventListener(ZvrDragBehaviorEvent.DRAGGING, dragging);

			resizable.removeEventListener(ZvrResizeBehaviorEvent.RESIZING, resizing);
			
			
			component.removeEventListener(ZvrComponentEvent.RESIZE, componentChange);
			component.removeEventListener(ZvrComponentEvent.MOVE, componentChange);
			
			delete _snaps[component]
		}
		
		private function componentChange(e:ZvrComponentEvent):void
		{
			_updatateGuides = true;
		}
		
		public function isSnappingEnabled(component:ZvrComponent):Boolean
		{
			return _components.indexOf(component) != -1;
		}
		
		public function get verticalGuides():Vector.<ZvrSnapGuide>
		{
			return _verticalGuides;
		}
		
		public function get horizontalGuides():Vector.<ZvrSnapGuide>
		{
			return _horizontalGuides;
		}
		
		private function drawSnaps():void
		{
			return;
			var graph:Graphics = _application.graphics;
			
			graph.clear();
			graph.lineStyle(1, ColorsMD.c5);
			
			var i:int;
			
			for (i = 0; i < _horizontalGuides.length; i++)
			{
				graph.moveTo(_horizontalGuides[i].value, 0);
				graph.lineTo(_horizontalGuides[i].value, _application.bounds.height);
			}
			
			for (i = 0; i < _verticalGuides.length; i++)
			{
				graph.moveTo(0, _verticalGuides[i].value);
				graph.lineTo(_application.bounds.width, _verticalGuides[i].value);
			}
			
		}
	
	}

}