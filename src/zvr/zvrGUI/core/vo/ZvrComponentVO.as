package zvr.zvrGUI.core.vo
{
	import zvr.zvrGUI.core.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	import zvr.zvrGUI.behaviors.ZvrComponentBehaviors;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrStyleChangeEvent;
	import zvr.zvrGUI.managers.ZvrStatePresentsManager;
	import zvr.zvrGUI.managers.ZvrStatesManager;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.base.ZvrSkinStyle;

	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */

	[Event(name="move", type="zvr.zvrGUI.events.ZvrComponentEvent")]
	[Event(name="resize", type="zvr.zvrGUI.events.ZvrComponentEvent")]
	[Event(name="componentAdded", type="zvr.zvrGUI.events.ZvrComponentEvent")]
	[Event(name="componentRemoved", type="zvr.zvrGUI.events.ZvrComponentEvent")]
	[Event(name="presentsChange", type="zvr.zvrGUI.events.ZvrComponentEvent")]
	[Event(name="styleChange", type="zvr.zvrGUI.events.ZvrStyleChangeEvent")]
	[Event(name="stateChange", type="zvr.zvrGUI.events.ZvrStateChangeEvent")]

	public class ZvrComponentVO
	{

		//protected var _debug:ZvrDebugComponent;

		protected var _rect:Rectangle;
		protected var _bounds:Rectangle;
		protected var _skin:ZvrSkin;
		protected var _behaviors:ZvrComponentBehaviors;
		protected var _states:ZvrStatesManager;
		protected var _presents:ZvrStatePresentsManager;

		protected var _autoSize:String = ZvrAutoSize.MANUAL;

		protected var _left:Number;
		protected var _right:Number;
		protected var _top:Number;
		protected var _bottom:Number;

		protected var _percentWidth:Number;
		protected var _percentHeight:Number;

		protected var _verticalCenter:Number;
		protected var _horizontalCenter:Number;

		protected var _maxWidth:Number = 10000;
		protected var _minWidth:Number = 10;

		protected var _maxHeight:Number = 10000;
		protected var _minHeight:Number = 10;

		private var _skinUpdateSize:Function;

		private var _owner:IZvrContainer;

		private var _explicit:ZvrExplicitBounds = new ZvrExplicitBounds();
		private var _skinCreate:Function;

		private var _visible:Boolean = true;

		private var _massChangeMode:Boolean = false;
		private var _massChangeBounds:Rectangle = null;

		protected var _body:IZvrComponentObject;
		protected var _skinClass:Class;
	
		public function ZvrComponentVO(skinClass:Class, body:IZvrComponentObject)
		{

			_body = body;

			//_debug = new ZvrDebugComponent(this, setUpDebug);
			//super.addChild(_debug);

			_rect = new Rectangle(0, 0, 10, 10);
			_bounds = new Rectangle();
			_behaviors = new ZvrComponentBehaviors(_body);
			_states = new ZvrStatesManager(_body);
			_presents = new ZvrStatePresentsManager(_body, setVisible);

			defineStates();

			_body.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_skinClass = skinClass;
			
		}

		public function init():void
		{
			_skin = new _skinClass(_body, skinRegistration); // todo think of dinamicly replecing skins
			_skinCreate();

			if (_skin.body)
				_body.addSkinLayer(_skin.body);
			if (_skin.shell)
				_body.addShellLayer(_skin.shell);

			if (!_skin is ZvrSkin)
				throw new Error("Error, class for sikin is not ZvrSkin");
		}

		private function addedToStage(e:Event):void
		{
			_body.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			_body.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			updateSkin();
		}

		private function removedFromStage(e:Event):void
		{
			_body.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			_body.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}

		private function skinRegistration(skinUpdateSize:Function, componentRegistration:Function, skinCreate:Function):void
		{
			_skinUpdateSize = skinUpdateSize;
			_skinCreate = skinCreate;
			componentRegistration(setSize, setPosition, getWidth, getHeight);
		}

		// get width for skin

		private function getHeight():Number
		{
			return validateHeight(_bounds.height);
		}

		// get width for skin

		private function getWidth():Number
		{
			return validateWidth(_bounds.width);
		}

		// PRIVATE

		private function _dispatchEvent(type:String, delta:Point = null):void
		{
			_body.dispatchEvent(new ZvrComponentEvent(type, _body, delta));
		}

		private function get xPosition():Number
		{
			if (_explicit.x == ZvrExplicitBounds.NONE && _explicit.right == ZvrExplicitBounds.RIGHT && _owner)
			{
				return _owner.contentAreaWidth - validateWidth(_rect.width) - _right;
			}

			if (_explicit.x == ZvrExplicitBounds.HORIZONTAL_CENTER && _owner)
			{
				return isNaN(_horizontalCenter) ? 0 : (_owner.contentAreaWidth * 0.5 - _bounds.width * 0.5) + _horizontalCenter;
			}

			switch (_explicit.x)
			{
				case ZvrExplicitBounds.X:
					return isNaN(_rect.x) ? 0 : _rect.x;
					break;
				case ZvrExplicitBounds.LEFT:
					return isNaN(_left) ? 0 : _left;
					break;
				default:
					return 0;
					break;
			}
		}

		public function get yPosition():Number
		{

			if (_explicit.y == ZvrExplicitBounds.NONE && _explicit.bottom == ZvrExplicitBounds.BOTTOM && _owner)
			{
				return _owner.contentAreaHeight - validateHeight(_rect.height) - _bottom;
			}

			if (_explicit.y == ZvrExplicitBounds.VERTICAL_CENTER && _owner)
			{
				return isNaN(_verticalCenter) ? 0 : (_owner.contentAreaHeight * 0.5 - _bounds.height * 0.5) + _verticalCenter;
			}

			switch (_explicit.y)
			{
				case ZvrExplicitBounds.Y:
					return isNaN(_rect.y) ? 0 : _rect.y;
					break;
				case ZvrExplicitBounds.TOP:
					return isNaN(_top) ? 0 : _top;
					break;
				default:
					return 0;
					break;
			}
		}

		private function get widthDimention():Number
		{
			var w:Number = 0;

			if (_explicit.x == ZvrExplicitBounds.NONE && _explicit.right == ZvrExplicitBounds.RIGHT && _owner)
			{
				w = _rect.width;
			}
			else if (_explicit.width == ZvrExplicitBounds.NONE && _explicit.x == ZvrExplicitBounds.LEFT && _explicit.right == ZvrExplicitBounds.RIGHT && _owner)
			{
				w = _owner.contentAreaWidth - _right - _left;
			}
			else if (_explicit.width == ZvrExplicitBounds.NONE && _explicit.x == ZvrExplicitBounds.X && _explicit.right == ZvrExplicitBounds.RIGHT && _owner)
			{
				w = _owner.contentAreaWidth - (isNaN(_rect.x) ? 0 : _rect.x) - _right;
			}
			else if (_explicit.width == ZvrExplicitBounds.WIDTH)
			{
				w = validateWidth(_rect.width);
			}
			else if (_explicit.width == ZvrExplicitBounds.PERCTENT_WIDTH && _owner)
			{
				w = _owner.contentAreaWidth * _percentWidth / 100;
			}
			else
			{
				w = validateWidth(_rect.width);
			}
			return isNaN(w) ? 0 : w;
		}

		private function get heightDimention():Number
		{

			var h:Number = 0;

			if (_explicit.y == ZvrExplicitBounds.NONE && _explicit.bottom == ZvrExplicitBounds.BOTTOM && _owner)
			{
				h = _rect.height;
			}
			else if (_explicit.height == ZvrExplicitBounds.NONE && _explicit.y == ZvrExplicitBounds.TOP && _explicit.bottom == ZvrExplicitBounds.BOTTOM && _owner)
			{
				h = _owner.contentAreaHeight - _top - _bottom;
			}
			else if (_explicit.height == ZvrExplicitBounds.NONE && _explicit.y == ZvrExplicitBounds.Y && _explicit.bottom == ZvrExplicitBounds.BOTTOM && _owner)
			{
				if (_owner.contentHeightAreaIndependent)
				{
					h = _owner.contentAreaHeight - (isNaN(_rect.y) ? 0 : _rect.y) - _bottom;
				}
				else
				{
					h = validateHeight(_rect.height) + (isNaN(_bottom) ? 0 : _bottom) + (isNaN(_top) ? 0 : _top);
				}
			}
			else if (_explicit.height == ZvrExplicitBounds.HEIGHT)
			{
				h = _rect.height;
			}
			else if (_explicit.height == ZvrExplicitBounds.PERCTENT_HEIGHT && _owner)
			{
				h = _owner.contentAreaHeight * _percentHeight / 100;
			}
			else
			{
				h = _rect.height;
			}

			return isNaN(h) ? 0 : h;

		}

		private function ownerResize(e:ZvrComponentEvent):void
		{
			var b:Point = new Point(_bounds.width, _bounds.height);
			var p:Point = _bounds.topLeft.clone();

			validateBounds();

			/*	if (b.x != _bounds.width || b.y != _bounds.height)
			 {
			 _dispatchEvent(ZvrComponentEvent.RESIZE);
			 }

			 if (!p.equals(_bounds.topLeft))
			 {
			 _dispatchEvent(ZvrComponentEvent.MOVE);
			 }*/
		}

		private function ownerPresentsChange(e:ZvrComponentEvent):void
		{
			validateBounds();
		}

		public function validateBounds(dispatchEvents:Boolean = true, exitMassChange:Boolean = false):void
		{

			var b:Rectangle = new Rectangle();

			b.x = xPosition;
			b.y = yPosition;

			b.height = validateHeight(heightDimention);
			b.width = validateWidth(widthDimention);

			var positionChanged:Boolean = false;
			var sizeChanged:Boolean = false;

			if (!b.equals(_bounds))
			{
				positionChanged = (!b.topLeft.equals(_bounds.topLeft))
				sizeChanged = (b.width != _bounds.width || b.height != _bounds.height);
				var oldBounds:Rectangle = _bounds.clone();
				_bounds = b;
			}

			if (_massChangeMode)
				return;

			if (exitMassChange)
			{
				positionChanged = !_bounds.topLeft.equals(_massChangeBounds.topLeft);
				sizeChanged = (_massChangeBounds.width != _bounds.width || _massChangeBounds.height != _bounds.height);
				oldBounds = _massChangeBounds.clone();
			}

			if (sizeChanged)
			{
				_skinUpdateSize();
				var d:Point = new Point(oldBounds.width - bounds.width, oldBounds.height - bounds.height);
				if (dispatchEvents)
					_dispatchEvent(ZvrComponentEvent.RESIZE, d);
			}

			if (positionChanged)
			{
				updatePosition();
				if (dispatchEvents)
					_dispatchEvent(ZvrComponentEvent.MOVE);
			}

		}

		/**
		 * Perform vaidation on dimentcion campare to maxWidth and minWidth
		 * @param	w - width dimention to compare;
		 * @return validated dimension
		 */

		protected function validateWidth(w:Number):Number
		{
			if (w < _minWidth)
				return _minWidth;
			if (w > _maxWidth)
				return _maxWidth;
			return w;
		}

		/**
		 * Perform vaidation on dimentcion campare to maxHeight and minHeight
		 * @param	w - height dimention to compare;
		 * @return validated dimension
		 */

		protected function validateHeight(h:Number):Number
		{
			if (h < _minHeight)
				return _minHeight;
			if (h > _maxHeight)
				return _maxHeight;
			return h;
		}

		/**
		 * updated position (x and y) of component based on _bounds, also updates _rect.
		 */

		protected function updatePosition():void
		{
			setSuperPosition(_bounds.x, _bounds.y);
			_rect.x = _bounds.x;
			_rect.y = _bounds.y;
		}

		/**
		 * Update position of component. Getter and setter of x, y, width and height in DisplayObject are overrided by ZvrComponent. x and y propety of DisplayObject are updated wirh this method.
		 * @param	x - x position
		 * @param	y - y position
		 */

		protected function setSuperPosition(x:Number, y:Number):void
		{
			_body.x = x;
			_body.y = y;
		}

		// PROTECTED
		// set size by skin or layout

		/**
		 *
		 * @param	x
		 * @param	y
		 */

		protected function setPosition(x:Number, y:Number):void
		{
			_rect.x = x;
			_rect.y = y;
			validateBounds(false);
		}

		// set size by skin, layout or autoSize

		protected function setSize(w:Number, h:Number):void
		{

			w = validateWidth(w);
			h = validateHeight(h);

			if (w == _rect.width && h == _rect.height && _explicit.width == ZvrExplicitBounds.WIDTH && _explicit.height == ZvrExplicitBounds.HEIGHT)
				return;

			_rect.width = w;
			_rect.height = h;

			validateBounds(false);

			_dispatchEvent(ZvrComponentEvent.RESIZE);

			//_skinUpdateSize();
		}

		protected function defineStates():void
		{
			// to be overrided;
		}

		protected function get cointainer():DisplayObjectContainer
		{
			// to be overrided
			return null;
		}

		// PUBLIC

		public function addTo(to:DisplayObjectContainer):void
		{
			//to.addChild(this);
			_dispatchEvent(ZvrComponentEvent.ADDED);
		}

		public function addToContainer(container:IZvrContainer):void
		{

			if (_owner)
			{
				_owner.removeComponent(_body);
			}

			_owner = container;
			validateBounds();
			_owner.addEventListener(ZvrComponentEvent.RESIZE, ownerResize);
			_owner.addEventListener(ZvrComponentEvent.PRESENTS_CHANGE, ownerPresentsChange);
			_dispatchEvent(ZvrComponentEvent.ADDED);
		}

		public function removeFromContainer(container:IZvrContainer):void
		{
			if (_owner != container)
				throw new Error("Container isn't components owner");

			if (_owner.getElementIndex(_body) != -1)
			{
				container.removeComponent(_body);
				return;
			}

			_owner.removeEventListener(ZvrComponentEvent.RESIZE, ownerResize);
			_owner.removeEventListener(ZvrComponentEvent.PRESENTS_CHANGE, ownerPresentsChange);
			_dispatchEvent(ZvrComponentEvent.REMOVED);
			_owner = null;
		}

		public function updateSkin():void
		{
			_skinUpdateSize();
		}

		public function resetComponent():void
		{
			_explicit.x = ZvrExplicitBounds.NONE;
			_explicit.y = ZvrExplicitBounds.NONE;
			_explicit.width = ZvrExplicitBounds.NONE;
			_explicit.height = ZvrExplicitBounds.NONE;
			_explicit.bottom = ZvrExplicitBounds.NONE;
			_explicit.right = ZvrExplicitBounds.NONE;

			_rect.x = 0;
			_rect.y = 0;
			_rect.width = validateWidth(0);
			_rect.height = validateHeight(0);

			_bottom = 0;
			_right = 0;

			validateBounds();

		}

		// PUBLIC GETERS AND SETTERS

		public function get x():Number
		{
			return _rect.x;
		}

		public function set x(value:Number):void
		{
			if (isNaN(value))
			{
				_explicit.x = ZvrExplicitBounds.NONE;
				_rect.x = 0;
				return;
			}

			if (_rect.x == value && _explicit.x == ZvrExplicitBounds.X)
				return;

			_rect.x = value;
			_explicit.x = ZvrExplicitBounds.X;

			validateBounds();
		}

		public function get y():Number
		{
			return _rect.y;
		}

		public function set y(value:Number):void
		{
			if (isNaN(value))
			{
				_explicit.y = ZvrExplicitBounds.NONE;
				_rect.y = 0;
				return;
			}

			if (_rect.y == value && _explicit.y == ZvrExplicitBounds.Y)
				return;

			_rect.y = value;
			_explicit.y = ZvrExplicitBounds.Y;

			validateBounds();
		}

		public function get height():Number
		{
			return isNaN(_rect.height) ? 0 : _rect.height;
		}

		public function set height(value:Number):void
		{
			if (isNaN(value))
			{
				_explicit.height = ZvrExplicitBounds.NONE;
				_rect.height = validateHeight(0);
				return;
			}

			_rect.height = validateHeight(value);
			_explicit.height = ZvrExplicitBounds.HEIGHT;

			validateBounds();
		}

		public function get width():Number
		{
			return isNaN(_rect.width) ? 0 : _rect.width;
		}

		public function set width(value:Number):void
		{
			if (isNaN(value))
			{
				_explicit.width = ZvrExplicitBounds.NONE;
				_rect.width = validateWidth(0);
				return;
			}

			_rect.width = validateWidth(value);
			_explicit.width = ZvrExplicitBounds.WIDTH;

			validateBounds();
		}

		public function get left():Number
		{
			return _left;
		}

		public function set left(value:Number):void
		{

			if (isNaN(value))
			{
				_explicit.x = ZvrExplicitBounds.NONE;
				_left = 0;
				return;
			}

			_explicit.x = ZvrExplicitBounds.LEFT;
			_left = value;

			validateBounds();
		}

		public function get right():Number
		{
			return _right;
		}

		/**
		 * Distance form right edge of component to ovner right edge.
		 * This parameter hase lowest priority, to make it work x/left or width
		 * should be sie to NaN, in other case it will be not taken to accaunt
		 * durring bounds validation
		 */

		public function set right(value:Number):void
		{
			if (isNaN(value))
			{
				_explicit.right = ZvrExplicitBounds.NONE;
				_right = 0;
				return;
			}

			_explicit.right = ZvrExplicitBounds.RIGHT;
			_right = value;

			validateBounds();
		}

		public function get top():Number
		{
			return isNaN(_top) ? 0 : _top;
		}

		public function set top(value:Number):void
		{
			_explicit.y = ZvrExplicitBounds.TOP;
			_top = value;

			validateBounds();
		}

		public function get bottom():Number
		{
			return isNaN(_bottom) ? 0 : _bottom;
		}

		public function set bottom(value:Number):void
		{

			if (isNaN(value))
			{
				_explicit.bottom = ZvrExplicitBounds.NONE;
				_bottom = 0;
				return;
			}

			_explicit.bottom = ZvrExplicitBounds.BOTTOM;
			_bottom = value;

			validateBounds();
		}

		public function get verticalCenter():Number
		{
			return _verticalCenter;
		}

		public function set verticalCenter(value:Number):void
		{
			_explicit.y = ZvrExplicitBounds.VERTICAL_CENTER;
			_verticalCenter = value;
			validateBounds();
		}

		public function get horizontalCenter():Number
		{
			return _horizontalCenter;
		}

		public function set horizontalCenter(value:Number):void
		{
			_explicit.x = ZvrExplicitBounds.HORIZONTAL_CENTER;
			_horizontalCenter = value;
			validateBounds();
		}

		public function get percentWidth():Number
		{
			return _percentWidth;
		}

		public function set percentWidth(value:Number):void
		{
			_explicit.width = ZvrExplicitBounds.PERCTENT_WIDTH;
			_percentWidth = value;
			validateBounds();
		}

		public function get percentHeight():Number
		{
			return _percentHeight;
		}

		public function set percentHeight(value:Number):void
		{
			_explicit.height = ZvrExplicitBounds.PERCTENT_HEIGHT;
			_percentHeight = value;
			validateBounds();
		}

		public function get maxWidth():Number
		{
			return _maxWidth;
		}

		public function set maxWidth(value:Number):void
		{
			if (value < _minWidth)
				value = _minWidth;
			_maxWidth = value;

			validateBounds();
		}

		public function get minWidth():Number
		{
			return _minWidth;
		}

		public function set minWidth(value:Number):void
		{
			if (value < 0)
				value = 0;
			if (value > _maxWidth)
				value = _maxWidth;
			_minWidth = value;

			validateBounds();
		}

		public function get maxHeight():Number
		{
			return _maxHeight;
		}

		public function set maxHeight(value:Number):void
		{
			if (value < _minHeight)
				value = _minHeight;
			_maxHeight = value;

			validateBounds();
		}

		public function get minHeight():Number
		{
			return _minHeight;
		}

		public function set minHeight(value:Number):void
		{
			if (value < 0)
				value = 0;
			if (value > _maxHeight)
				value = _maxHeight;
			_minHeight = value;

			validateBounds();
		}

		public function get skin():ZvrSkin
		{
			return _skin;
		}

		public function get bounds():Rectangle
		{
			if (!_presents.present)
				return new Rectangle();
			return _bounds;
		}

		/*public function get fullBounds():Rectangle
		 {
		 return new Rectangle(_bounds.x - (isNaN(_left) ? 0 : _left), _bounds.y - (isNaN(_top) ? 0 : _top), _bounds.width + (isNaN(_right) ? 0 : _right) + (isNaN(_left) ? 0 : _left), _bounds.height + (isNaN(_bottom) ? 0 : _bottom) + (isNaN(_top) ? 0 : _top));
		 }*/

		public function get independentBounds():Rectangle
		{
			var b:Rectangle = new Rectangle();
			if (!_presents.present)
				return b;

			b.width = validateWidth(_rect.width);
			b.width += (isNaN(_right) ? 0 : _right) + (isNaN(_left) ? 0 : _left);

			b.height = validateHeight(_rect.height);
			b.height += (isNaN(_bottom) ? 0 : _bottom) + (isNaN(_top) ? 0 : _top);

			if (_explicit.x == ZvrExplicitBounds.NONE && _explicit.right == ZvrExplicitBounds.RIGHT)
				b.x = (isNaN(_left) ? 0 : _left);
			else if (_explicit.x == ZvrExplicitBounds.HORIZONTAL_CENTER)
				b.x = 0;
			else
				b.x = _bounds.x - (isNaN(_left) ? 0 : _left);

			if (_explicit.y == ZvrExplicitBounds.NONE && _explicit.bottom == ZvrExplicitBounds.BOTTOM)
				b.y = (isNaN(_top) ? 0 : _top);
			else if (_explicit.y == ZvrExplicitBounds.VERTICAL_CENTER)
				b.y = 0;
			else
				b.y = _bounds.y - (isNaN(_top) ? 0 : _top);

			return b;

		}

		public function get independentWidth():Boolean
		{
			return (_explicit.width == ZvrExplicitBounds.WIDTH || _explicit.width == ZvrExplicitBounds.NONE || getWidth() == _minWidth);
		}

		public function get independentHeight():Boolean
		{
			return (_explicit.height == ZvrExplicitBounds.HEIGHT || _explicit.height == ZvrExplicitBounds.NONE || getHeight() == _minHeight);
		}

		public function get autoSize():String
		{
			return _autoSize;
		}

		/**
		 * Auto size mode of container. Static values are keept in ZvrAutoSize class to help.
		 * @param	mode of autoSize
		 * <ul>
		 * <li><i>manual</i> - no auto size</li>
		 * <li><i>content</i> - auto size to content width and height</li>
		 * <li><i>contentWidth</i> - auto size to content width</li>
		 * <li><i>contentHeight</i> - auto size to content height</li>
		 * </ul>
		 */

		public function set autoSize(value:String):void
		{
			_autoSize = value;
		}

		public function get behaviors():ZvrComponentBehaviors
		{
			return _behaviors;
		}

		public function setStyle(styleName:String, value:*, state:* = null):void
		{
			if (_skin.setStyle(styleName, value, state))
				_body.dispatchEvent(new ZvrStyleChangeEvent(ZvrStyleChangeEvent.CHANGE, styleName, value));
		}

		public function getStyle(styleName:String):*
		{
			return _skin.getStyle(styleName);
		}

		public function get owner():IZvrContainer
		{
			return _owner;
		}

		public function addState(state:String):void
		{
			_states.add(state);
		}

		public function removeState(state:String):void
		{
			_states.remove(state);
		}

		public function get currentStates():Array
		{
			return _states.currentStates.slice(0);
		}

		public function hasState(state:String):Boolean
		{
			return _states.hasState(state);
		}

		public function get states():Array
		{
			return _states.states;
		}

		public function checkState(state:String):Boolean
		{
			return _states.isCurrentState(state);
		}

		public function manageStates(add:Object, remove:Object):void
		{
			_states.manageStates(add, remove);
		}

		/*public function manageStates(add:String, remove:String):void
		 {
		 _states.swich(add, remove);
		 }*/

		public function set includeIn(value:*):void
		{
			_presents.includeIn = value;
		}

		public function set excludeIn(value:*):void
		{
			_presents.exlcudeIn = value;
		}

		public function get includeInLayout():Object
		{
			return _presents.includeInLayout;
		}

		public function set includeInLayout(value:Object):void
		{
			_presents.includeInLayout = value;
		}

		public function get present():Boolean
		{
			return _presents.present;
		}

		public function set delegateStates(component:IZvrComponent):void
		{
			_states.delegateState = component;
		}

		public function get delegateStates():IZvrComponent
		{
			return _states.delegateState;
		}

		public function get combineWithDelegateStates():Boolean
		{
			return _states.combineWithDelegateStates;
		}

		public function set combineWithDelegateStates(value:Boolean):void
		{
			_states.combineWithDelegateStates = value;
		}

		public function getStylesRegistration(styleName:String):ZvrSkinStyle
		{
			return _skin.getStylesRegistration(styleName);
		}

		public function get visible():Boolean
		{
			return _visible;
		}

		public function set visible(value:Boolean):void
		{
			if (_presents.present)
			//super.visible = value;
				_visible = value;
		}

		public function get explicit():ZvrExplicitReport
		{
			return _explicit.explicitRaport;
		}

		private function setVisible(value:Boolean):void
		{
			//_body.visible = value;
		}

		public function set layoutPositionX(x:Number):void
		{
			_body.x = x;
		}

		public function set layoutPositionY(y:Number):void
		{
			_body.y = y;
		}

		public function get layoutPositionX():Number
		{
			return _body.x;
		}

		public function get layoutPositionY():Number
		{
			return _body.y;
		}

		/**
		 * Any action has it's reaction. In ZvrComponets there is no delay in response of any action on components
		 * or change its properties.
		 * Thats why sometimes those changens can cose fall of preformace. If there is must of doing many changes
		 * at once in component, when component changes couple of its properties for example <i>x, y, width and bottom</i>
		 * we sould do it between enter and exit mass change mode. When component is in mass change mode non of the
		 * move or resize events are dispached, so non of the autoSize nor louyting in owner container occure.
		 * If component wouldn't be in mass change mode auto sizing and layouting would be done after each change seperatly.
		 *
		 * @example Example of using massChangeMode for components.
		 * <pre>
		 *
		 * var component:ZvrComponent = new ZvrComponent(ZvrSkin);
		 * component.enterMassChangeMode();
		 * component.x = 10;
		 * component.y = 10;
		 * component.right = 10;
		 * component.bottom = 10;
		 * component.exitMassChangeMode();
		 *
		 * </pre>
		 *
		 */

		public function enterMassChangeMode():void
		{
			if (_massChangeMode) return;
			_massChangeMode = true;
			_massChangeBounds = _bounds.clone();
		}

		/**
		 * Exit mass change mode.
		 * @see #enterMassChangeMode() enterMassChangeMode()
		 */

		public function exitMassChangeMode():void
		{
			if (!_massChangeBounds) return;
			_massChangeMode = false;
			validateBounds(true, true);
		}

		/// debug

		protected function setUpDebug():void
		{
			//setChildIndex(_debug, numChildren - 1);
		}

		public function get debugEnable():Boolean
		{
			return false//_debug.enabled;
		}

		public function set debugEnable(value:Boolean):void
		{
			//_debug.enabled = value;
		}

		protected function get massChangeMode():Boolean
		{
			return _massChangeMode;
		}

		public function getStoreSetup():ZvrComponetStoredSetup
		{
			var setup:ZvrComponetStoredSetup = new ZvrComponetStoredSetup();

			setup.autoSize = _autoSize;

			setup.x = _rect.x;
			setup.y = _rect.y;
			setup.width = _rect.width;
			setup.height = _rect.height;

			setup.left = _left;
			setup.right = _right;
			setup.top = _top;
			setup.bottom = _bottom;

			setup.percentWidth = _percentWidth;
			setup.percentHeight = _percentHeight;

			setup.verticalCenter = _verticalCenter;
			setup.horizontalCenter = _horizontalCenter;

			setup.maxWidth = _maxWidth;
			setup.minWidth = _minWidth;

			setup.maxHeight = _maxHeight;
			setup.minHeight = _minHeight;

			setup.explicit = _explicit.clone();
			setup.visible = _visible;

			return setup;
		}

		public function setStoreSetup(setup:ZvrComponetStoredSetup):void
		{
			_autoSize = setup.autoSize;

			_rect.x = setup.x;
			_rect.y = setup.y;
			_rect.width = setup.width;
			_rect.height = setup.height;

			_left = setup.left;
			_right = setup.right;
			_top = setup.top;
			_bottom = setup.bottom;

			_percentWidth = setup.percentWidth;
			_percentHeight = setup.percentHeight;

			_verticalCenter = setup.verticalCenter;
			_horizontalCenter = setup.horizontalCenter;

			_maxWidth = setup.maxWidth;
			_minWidth = setup.minWidth;

			_maxHeight = setup.maxHeight;
			_minHeight = setup.minHeight;

			_explicit = setup.explicit.clone();
			_visible = setup.visible;

			validateBounds();

		}

		public function getPosition():Point
		{
			return new Point(_body.x, _body.y);
		}


		public function get onStage():Boolean
		{
			return _body.onStage;
		}
	}
}

