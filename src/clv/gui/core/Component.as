package clv.gui.core 
{
	import clv.gui.core.behaviors.Behaviors;
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.skins.Skin;
	import clv.gui.core.statePresents.StatePresentsManager;
	import clv.gui.core.states.StateSignal;
	import clv.gui.core.states.StatesManager;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class Component implements IComponent
	{
		
		// Layout
		public var _vD					:Dimension = new Dimension();
		public var _hD					:Dimension = new Dimension()
			
		private var _bounds				:Rectangle = new Rectangle(Number.MIN_VALUE, Number.MIN_VALUE, Number.MAX_VALUE, Number.MAX_VALUE);
		
		private var _independentBounds	:IndependentBounds = new IndependentBounds();
			
		/*private var _minWidth			:Number = 10;
		private var _maxWidth			:Number = Number.MAX_VALUE;
			
		private var _minHeight			:Number = 10;
		private var _maxHeight			:Number = Number.MAX_VALUE;*/
		
		private var _transformDirty		:Boolean = false;
		private var _independentDirty	:Boolean = true;
		
		protected var _cell				:Rectangle;
		
		// Display	
		protected var _body				:IComponentBody
			
		// Hierarchy	
		protected var _container		:Container;
		protected var _app				:Application;
			
		// States	
		protected var _states			:StatesManager;
		protected var _onStateChange 	:Signal = new Signal(StateSignal);
		
		//	visibility
		protected var _presents			:StatePresentsManager
		protected var _visible			:Boolean = true;
		
		// Behaviors	
		protected var _behaviors		:Behaviors;
		
		// Behaviors	
		private var _skin				:Skin;
		
		// signals	
		protected var _onAdded			:Signal = new Signal(ComponentSignal);
		protected var _onRemoved		:Signal = new Signal(ComponentSignal);
		protected var _onPresentsChange	:Signal = new Signal(ComponentSignal);
		protected var _onAddedToApp		:Signal = new Signal(ComponentSignal);
		protected var _onRemovedFromApp	:Signal = new Signal(ComponentSignal);
		protected var _onResized		:Signal = new Signal(ComponentSignal);
		protected var _onPreUpdate		:Signal = new Signal(ComponentSignal);
		protected var _onPostUpdate		:Signal = new Signal(ComponentSignal);
		
		protected var _componentSignal:ComponentSignal;
		
		public function Component(skin:Skin) 
		{
			_componentSignal = new ComponentSignal(this);
			_states = new StatesManager(this);
			_presents = new StatePresentsManager(this, setPresents);
			_behaviors = new Behaviors(this);
			
			defineStates();
			setStates();
			
			this.skin = skin;
		}
		
		public function prepareForUpdate():void 
		{
			preUpdate();
			_onPreUpdate.dispatch(_componentSignal);
			
			_skin.preUpdate();
			
			if (_independentDirty)
			{
				updateIndependedBounds();
			}
		}
		
		protected function preUpdate():void 
		{
			// to override
		}
		
		public function update(cell:Rectangle):void 
		{
			updateLayout(cell);
			updateSkin();
			postUpdate();
			_onPostUpdate.dispatch(_componentSignal);
		}
		
		protected function postUpdate():void 
		{
			// to override
		}
		
		public function updateLayout(cell:Rectangle):void
		{
			
			if (!_transformDirty && (!cell || (cell && _cell.equals(cell)))) return;
			
			if (cell) 
			{
				_cell = cell;
			}
			
			if (!_cell) 
			{
				_cell = new Rectangle(0, 0, independentBounds.w, independentBounds.h);
			}
			
			if (_app) _app.updates++;
			
			_hD.update(_cell.width);
			_vD.update(_cell.height);
			
			var x:Number = _cell.x + _hD.S;
			var y:Number = _cell.y + _vD.S;
			
			if (_bounds.x != x || _bounds.y != y)
			{
				_bounds.x = x;
				_bounds.y = y;
				_skin.positionDirty = true;
			}
			
			/*var w:Number = _hD.D < _minWidth ? _minWidth : _hD.D > _maxWidth ? _maxWidth : _hD.D;
			var h:Number = _vD.D < _minHeight ? _minHeight : _vD.D > _maxHeight ? _maxHeight : _vD.D;*/
			
			if (_bounds.width !=  _hD.D || _bounds.height != _vD.D)
			{
				_bounds.width = _hD.D;
				_bounds.height = _vD.D;
				_skin.sizeDirty = true;
			}
			
			if (_skin.sizeDirty)
			{
				reportResized();
			}
			
			_transformDirty = false;
		}
		
		public function updateSkin():void
		{
			_skin.update();
			
			if (_skin.positionDirty || _skin.sizeDirty) _skin.updateBounds();
			
			_skin.positionDirty 	= false;
			_skin.sizeDirty 		= false;
		}
		
		internal function reportResized():void
		{
			resized();
			_onResized.dispatch(_componentSignal);
		}
		
		protected function resized():void 
		{
			// to override;
		}
		
		private function updateIndependedBounds():void 
		{
			
			/*_independentBounds.l = _hD.s;
			_independentBounds.r = _hD.e;
			
			_independentBounds.t = _vD.s;
			_independentBounds.b = _vD.e;
			
			_independentBounds.w = _hD.dd;
			_independentBounds.h = _vD.dd;
			
			_independentBounds.x = (isNaN(_hD.s) ? 0 : _hD.s);
			_independentBounds.y = (isNaN(_vD.s) ? 0 : _vD.s);*/
			
			_independentDirty = false;
		}
		
		
		
		// states manage
		
		
		protected function defineStates():void 
		{
			// to override
		}
		
		protected function setStates():void 
		{
			// to override
		}
		
		protected function defineState(state:String):void
		{
			_states.define(state);
		}
		
		public function addState(state:String):void
		{
			_states.add(state);
		}
		
		public function removeState(state:String):void
		{
			_states.remove(state);
		}
		
		public function hasState(state:String):Boolean
		{
			return _states.hasState(state);
		}
		
		public function get states():Array
		{
			return _states.states;
		}
		
		public function get currentStates():Array
		{
			return _states.currentStates.slice(0);
		}
		
		public function isCurrentState(state:String):Boolean
		{
			return _states.isCurrentState(state);
		}
		
		public function added(container:Container):void 
		{
			_container = container;
			setApp(container.app);
			_onAdded.dispatch(_componentSignal);
		}
		
		public function removed(container:Container):void 
		{
			_onRemoved.dispatch(_componentSignal);
			_container = null;
			setApp(null);
		}
		
		internal function setApp(v:Application):void
		{
			
			if (_app == v) return;
			
			var added:Boolean
			var removed:Boolean
			
			if (!_app && v)
			{
				added = true;
			}
			
			if (_app && !v)
			{
				removed = true;
			}
			
			_app = v;
			
			if (added && _presents.present) 
			{
				addedToApp();
				_onAddedToApp.dispatch(_componentSignal);
			}
			
			if (removed && _presents.present) 
			{
				removedFromApp();
				_onRemovedFromApp.dispatch(_componentSignal);
			}
			
			
		}
		
		protected function addedToApp():void 
		{
			// to override
		}
		
		protected function removedFromApp():void 
		{
			// to override
		}
		
		// internal, presents setup

		private function setPresents(v:Boolean):void 
		{
			if (_app)
			{
				if (v)
				{
					addedToApp();
					_onAddedToApp.dispatch(_componentSignal);
				}
				else
				{
					removedFromApp();
					_onRemovedFromApp.dispatch(_componentSignal);
				}
			}
			
			_visible = v;
			
			_body.visible = v;
			
			if (_container) _container.childrenDirty = true;
		}
		
		// ley out settup
		
		public function get width():Number 
		{
			return _hD.d;
		}
		
		public function set width(value:Number):void 
		{
			_hD.d = value;
			_independentBounds.w = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get height():Number 
		{
			return  _vD.d;
		}
		
		public function set height(value:Number):void 
		{
			_vD.d = value; 
			_independentBounds.h = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fWidth():Number 
		{
			return _hD.fd;
		}
		
		public function set fWidth(value:Number):void 
		{
			_hD.fd = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fHeight():Number 
		{
			return _vD.fd;
		}
		
		public function set fHeight(value:Number):void 
		{
			_vD.fd = value;
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get x():Number 
		{
			return _hD.s;
		}
		
		public function set x(value:Number):void 
		{
			_hD.s = value;
			_independentBounds.x = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get y():Number 
		{
			return _vD.s;
		}
		
		public function set y(value:Number):void 
		{
			_vD.s = value;
			_independentBounds.y = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get top():Number 
		{
			return _vD.s;
		}
		
		public function set top(value:Number):void 
		{
			_vD.s = value;
			_independentBounds.t = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get left():Number 
		{
			return _hD.s;
		}
		
		public function set left(value:Number):void 
		{
			_hD.s = value;
			_independentBounds.l = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get right():Number 
		{
			return _hD.e;
		}
		
		public function set right(value:Number):void 
		{
			_hD.e = value;
			_independentBounds.r = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get bottom():Number 
		{
			return _vD.e;
		}
		
		public function set bottom(value:Number):void 
		{
			_vD.e = value;
			_independentBounds.b = value;
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get vCenter():Number 
		{
			return _vD.c;
		}
		
		public function set vCenter(value:Number):void 
		{
			_vD.c = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get hCenter():Number 
		{
			return _hD.c;
		}
		
		public function set hCenter(value:Number):void 
		{
			_hD.c = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fTop():Number 
		{
			return _vD.fs;
		}
		
		public function set fTop(value:Number):void 
		{
			_vD.fs = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fLeft():Number 
		{
			return _hD.fs;
		}
		
		public function set fLeft(value:Number):void 
		{
			_hD.fs = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fRight():Number 
		{
			return _hD.fe;
		}
		
		public function set fRight(value:Number):void 
		{
			_hD.fe = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get fBottom():Number 
		{
			return _vD.fe;
		}
		
		public function set fBottom(value:Number):void 
		{
			_vD.fe = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get vfCenter():Number 
		{
			return _vD.fc;
		}
		
		public function set vfCenter(value:Number):void 
		{
			_vD.fc = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get hfCenter():Number 
		{
			return _hD.fc;
		}
		
		public function set hfCenter(value:Number):void 
		{
			_hD.fc = value; 
			_transformDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get minWidth():Number 
		{
			return _hD.minD;
		}
		
		public function set minWidth(value:Number):void 
		{
			_hD.minD = value; 
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get maxWidth():Number 
		{
			return _hD.maxD;
		}
		
		public function set maxWidth(value:Number):void 
		{
			_hD.maxD = value; 
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get minHeight():Number 
		{
			return _vD.minD;
		}
		
		public function set minHeight(value:Number):void 
		{
			_vD.minD = value; 
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get maxHeight():Number 
		{
			return _vD.maxD;
		}
		
		public function set maxHeight(value:Number):void 
		{
			_vD.maxD = value; 
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
		}
		
		public function get skin():Skin 
		{
			return _skin;
		}
		
		public function set skin(value:Skin):void 
		{
			if (value == null) throw new Error("Component must have skin");
			
			if (_skin) _skin.removeFromComponent(this);
			
			_skin = value;
			
			_skin.addToComponent(this);
			
			_body = _skin.componentBody;
			
			_transformDirty = true;
			_independentDirty = true;
			if (_container) _container.childrenDirty = true;
			
			_bounds.x = Number.MIN_VALUE;
			_bounds.y = Number.MIN_VALUE;
			_bounds.width = Number.MAX_VALUE;
			_bounds.height = Number.MAX_VALUE;
			
		}
		
		public function get body():IComponentBody 
		{
			return _body;
		}
		
		public function get bounds():Rectangle 
		{
			return _bounds;
		}
		
		public function get container():Container 
		{
			return _container;
		}
		
		// Signals getters
		
		public function get onStateChange():Signal 
		{
			return _onStateChange;
		}
		
		public function get onPresentsChange():Signal 
		{
			return _onPresentsChange;
		}
		
		public function get onAddedToApp():Signal 
		{
			return _onAddedToApp;
		}
		
		public function get onRemovedFromApp():Signal 
		{
			return _onRemovedFromApp;
		}
		
		public function get visible():Boolean 
		{
			return _visible;
		}
		
		public function set visible(value:Boolean):void 
		{
			if (_presents.present)
				_body.visible = value;
			_visible = value;
		}
		
		public function get includeInLayout():Boolean 
		{
			return _presents.includeInLayout;
		}
		
		public function set includeInLayout(value:Boolean):void 
		{
			_presents.includeInLayout = value;
		}
		
		public function get app():Application 
		{
			return _app;
		}
		
		public function get present():Boolean 
		{
			return _presents.present;
		}
		
		public function get independentBounds():IndependentBounds 
		{
			
			if (_independentDirty)
			{
				updateIndependedBounds();
			}
			
			return _independentBounds;
		}
		
		public function get transformDirty():Boolean 
		{
			return _transformDirty;
		}
		
		public function get cellWidth():Number 
		{
			return _hD.L;
		}
		
		public function get cellHeight():Number 
		{
			return _vD.L;
		}
		
		public function get behaviors():Behaviors 
		{
			return _behaviors;
		}
		
		public function get combineWithDelegateStates():Boolean 
		{
			return _states.combineWithDelegateStates;
		}
		
		public function set combineWithDelegateStates(value:Boolean):void 
		{
			_states.combineWithDelegateStates = value;
		}
		
		public function get delegateStates():IComponent 
		{
			return _states.delegateState;
		}
		
		public function set delegateStates(value:IComponent):void 
		{
			_states.delegateState = value;
		}
		
		public function get onResized():Signal 
		{
			return _onResized;
		}
		
		public function get componentSignal():ComponentSignal 
		{
			return _componentSignal;
		}
		
		public function set componentSignal(value:ComponentSignal):void 
		{
			_componentSignal = value;
		}
		
		public function get onPreUpdate():Signal 
		{
			return _onPreUpdate;
		}
		
		public function get onPostUpdate():Signal 
		{
			return _onPostUpdate;
		}
		
		public function setStyle(styleName:String, value:*, state:* = null):void
		{
			_skin.setStyle(styleName, value, state);
		}
		
		public function getStyle(styleName:String):*
		{
			return _skin.getStyle(styleName);
		}
		
	}

}