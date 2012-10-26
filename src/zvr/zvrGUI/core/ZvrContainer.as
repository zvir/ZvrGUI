package zvr.zvrGUI.core
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.utils.getQualifiedClassName;
	import utils.type.getClass;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowTitleMD;
	import zvr.zvrGUI.core.relays.ZvrContainerRelay;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.layouts.ZvrLayout;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;

	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	[Event(name="elementAdded",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="elementRemoved",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="cotntentSizeChanged",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	[Event(name="contentPositionChanged",type="zvr.zvrGUI.events.ZvrContainerEvent")]
	
	
	public class ZvrContainer extends ZvrContainerRelay implements IZvrContainer
	{
		
		protected var _contentWidth:Number = 0;
		protected var _contentHeight:Number = 0;
		protected var _elements:Vector.<IZvrComponent> = new Vector.<IZvrComponent>;
		private var _presentElements:Vector.<IZvrComponent> = new Vector.<IZvrComponent>;
		private var _test:Sprite = new Sprite();
		private var _layout:ZvrLayout;
		private var _updateLayout:Function;
		private var _contents:Sprite = new Sprite();
		protected var _mask:Sprite = new Sprite();	
		private var _contentPadding:ZvrContentPadding;
		private var _sizeManager:ZvrContainerSizeManager;
		private var _maskingEnabled:Boolean = true;
		
		private var _contentHeightAreaIndependent:Boolean;
		private var _contentWidthAreaIndependent:Boolean;
		
		
		public function ZvrContainer(skinClass:Class)
		{
			_contents.mask = _mask;
			super(_contents, skinClass);
			_sizeManager = new ZvrContainerSizeManager(this);
			_contentPadding = new ZvrContentPadding(contentPaddingSetter);

			_base.addChild(_contents);
			_base.addChild(_mask);
			
			if (_skin.shell)
			{
				_base.setChildIndex(_skin.shell as DisplayObject, _base.numChildren -1);
			}
			
			addEventListener(ZvrComponentEvent.RESIZE, resized);
			
			//_debug.hideElements.push(_contents);
			//_debug.componetnMask = _mask;
			
		}
		
		override protected function setUpDebug():void
		{
			//_base.setChildIndex(_debug, _base.numChildren - 1);
		}
		
		// PRIVATE/PROTECTED
		
		
		/*
		 * 
		 * Capture of elements chanege
		 * 
		*/
		
		private function resized(e:ZvrComponentEvent):void
		{
			if (massChangeMode) return;
			updateLayout();
			updateMask();
		}
		
		// FIXME Shold be layouting first or updateSize ?
		// some layouts need width and height of container to layouting;
		
		private function elementChanged(e:ZvrComponentEvent):void
		{ 
			if (!e.component.present) return;
			updateContainer();
		}
		
		private function elementPresentsChange(e:ZvrComponentEvent):void
		{
			updatePresentElement(e.component as ZvrComponent);
			updateContainer();
		}
		
		/*
		 * 
		 * Updating container
		 * 
		*/
		
		private function updateContainer():void
		{
			if (massChangeMode) return;
			
			updateLayout();
			
			if (_autoSize != ZvrAutoSize.MANUAL)
			{
				updateSize();
			}
			updateContentSize();
			updateMask();
		}
		
		/**
		 * Updating present elements for layouting.
		 * @param	component
		 */
		
		private function updatePresentElement(component:ZvrComponent):void
		{
			var i:int = _presentElements.indexOf(component);
			
			if (component.present && i < 0)
				_presentElements.splice(getElementIndex(component), 0, component );
				
			if (!component.present && i >= 0)
				_presentElements.splice(i, 1);
		}
		
		// TODO Move updatateSiz,e autoSizeToContent to ZvrContainerSizeManager
		
		/**
		 * update size of contaier if autoSize is not MANUAL
		 */
		
		private function updateSize():void
		{
			switch (_autoSize)
			{
				case ZvrAutoSize.CONTENT: 
					autoSizeToContent(true, true);
					break;
				case ZvrAutoSize.CONTENT_HEIGHT: 
					autoSizeToContent(false, true);
					break;
				case ZvrAutoSize.CONTENT_WIDTH: 
					autoSizeToContent(true, false);
					break;
			}
		}
		
		/**
		 * Change size of container based on elements positions and sized.
		 * Negative positions of elements are ignored.
		 * @param	width indicates if Container should autoSize do width of content size;
		 * @param	height indicates if Container should autoSize do height of content size;
		 */
		
		// TODO ist'n updateContentSize doing the same calculations?
		 
		protected function autoSizeToContent(width:Boolean, height:Boolean):void
		{
			
			_contentHeightAreaIndependent = height;
			_contentWidthAreaIndependent = width;
			
			var r:Rectangle = new Rectangle();
			var e:IZvrComponent;
			var ex:ZvrExplicitReport;
			
			for (var i:int = 0; i < _presentElements.length; i++)
			{
				e = _presentElements[i];
				
				var b:Rectangle = e.independentBounds;
				var w:Number = b.right;
				var h:Number = b.bottom;
				
				ex = e.explicit;
				
				r.width = Math.max(r.right, w);
				r.height = Math.max(r.bottom, h);
				
				if (b.x < 0)
				{
					if (ex.x == ZvrExplicitBounds.X) e.x -= b.x;
					if (explicit.x == ZvrExplicitBounds.X) x += b.x;
				}
				
				if (b.y < 0)
				{
					if (ex.y == ZvrExplicitBounds.Y) e.y -= b.y;
					if (explicit.y == ZvrExplicitBounds.Y) y += b.y;
				}
			}
			
			var paddingWidth:Number = _contentPadding.left + _contentPadding.right;
			var paddingHeight:Number = _contentPadding.top + _contentPadding.bottom;
				
			setSize(width ? r.width + paddingWidth: bounds.width, height ? r.height + paddingHeight : bounds.height);
			
		}
		
		private function computeContentSize():Array
		{
			var h:Number = 0;
			var w:Number = 0;
			var e:IZvrComponent;
			
			for (var i:int = 0; i < _elements.length; i++)
			{
				e = _elements[i];
				h = Math.max(h, e.bounds.bottom);
				w = Math.max(w, e.bounds.right);
			}
			
			return [w, h];
		}
		
		private function updateContentSize():void
		{
			var size:Array = computeContentSize();
			setContentSize(size[0], size[1]);
		}
		
		private function setContentSize(w:Number, h:Number):void
		{
			if (w == _contentHeight && h == _contentHeight)
				return;
				
			_contentWidth = w;
			_contentHeight = h;
			
			dispatchEvent(new ZvrContainerEvent(ZvrContainerEvent.CONTENT_SIZE_CHANGE, this, null));
		}
		
		protected function updateMask():void
		{
			_mask.graphics.clear();
			_mask.graphics.beginFill(0x00FF00, 0.1);
			_mask.graphics.drawRect(_contentPadding.left, _contentPadding.top, bounds.width - _contentPadding.right - _contentPadding.left, bounds.height - _contentPadding.bottom - _contentPadding.top);
		}
		
		
		private function contentPaddingSetter(top:Number, left:Number, right:Number, bottom:Number):void 
		{
			if (top != 0 || left != 0) 
			{
				_contents.x -= left;
				_contents.y -= top;
				dispatchEvent(new ZvrContainerEvent(ZvrContainerEvent.CONTENT_POSITION_CHANGE, this, null));
				updateContainer();
			} 
			else if (right != 0 || bottom != 0)
			{
				updateContainer();
			}
		}
		
		private function updateLayout():void
		{
			if (_layout)
			{
				_updateLayout();
			}
		}
		
		// PUBLIC
		
		/**
		 * Adds child to container. Child should be ZvrCompoment,
		 * but other displayObjecs are also accepted but they are not layouted,
		 * also depth index of non ZvrComponent might be changed beceose of 
		 * and any change of it isn't tracked by components presents managment in container.
		 * @param	child preferable ZvrComponent
		 * @return added child
		 */
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (!(child is ZvrComponent))
			{
				updateContainer();
				return super.addChild(child);
			}
			
			var element:ZvrComponent = child as ZvrComponent;
			
			_elements.push(element);
			
			element.addEventListener(ZvrComponentEvent.MOVE, elementChanged);
			element.addEventListener(ZvrComponentEvent.RESIZE, elementChanged);
			element.addEventListener(ZvrComponentEvent.PRESENTS_CHANGE, elementPresentsChange);
			
			element.addToContainer(this);
			updatePresentElement(element);
			
			updateContainer();
			
			dispatchEvent(new ZvrContainerEvent(ZvrContainerEvent.ELEMENT_ADDED, this, element));
			
			if (skin.shell)
			{
				_base.setChildIndex(_skin.shell as DisplayObject, _base.numChildren -1);
			}
			
			return super.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject
		{
			if (!(child is ZvrComponent))
				return super.removeChild(child);
			
			var element:ZvrComponent = child as ZvrComponent;
			var i:int = getElementIndex(element);
			
			if (i == -1)
				return super.removeChild(child);
			
			_elements.splice(i, 1);
			
			element.removeEventListener(ZvrComponentEvent.MOVE, elementChanged);
			element.removeEventListener(ZvrComponentEvent.RESIZE, elementChanged);
			element.removeEventListener(ZvrComponentEvent.PRESENTS_CHANGE, elementPresentsChange);
			
			super.removeChild(child);
			
			element.removeFromContainer(this);
			
			i = _presentElements.indexOf(element);
			if (i != -1)
				_presentElements.splice(i, 1);
				
			updateContainer();
			
			dispatchEvent(new ZvrContainerEvent(ZvrContainerEvent.ELEMENT_REMOVED, this, element));
			
			return child;
		}
		
		public function getNumElements():int
		{
			return _elements.length;
		}
		
		public function getElementAt(index:int):IZvrComponent
		{
			return _elements[index] as IZvrComponent;
		}
		
		public function getElementIndex(element:IZvrComponent):int
		{
			return _elements.indexOf(element);
		}
		
		public function setElementIndex(child:IZvrComponent, index:int):void
		{
			if (!(child is ZvrComponent)) return;
			var i:int = getElementIndex(child as ZvrComponent);
			
			_elements.splice(i, 1);
			_elements.splice(index, 0, child);
			updateContainer();
		}
		
		public function setContentsPosition(x:Number, y:Number):void
		{
			if (x == _contents.x - _contentPadding.left && y == _contents.y - _contentPadding.right)
				return;
				
			_contents.x = x + _contentPadding.left;
			_contents.y = y + _contentPadding.top;
			
			dispatchEvent(new ZvrContainerEvent(ZvrContainerEvent.CONTENT_POSITION_CHANGE, this, null));
		}
		
		override public function set autoSize(value:String):void
		{
			if (value == _autoSize) return;
			
			_autoSize = value;
			
			updateContainer();
		}
		
		override public function exitMassChangeMode():void 
		{
			super.exitMassChangeMode();
			updateSize();
			updateContentSize();
		}
		
		/**
		 * Any Layout must extends ZvrLayout. Layout is responsible for placing elements in the view of container. 
		 * @param	layout Class with layout
		 */
		
		public function setLayout(layout:Class):void
		{
			if (_layout)
			{
				if (getQualifiedClassName(layout) == getQualifiedClassName(getClass(_layout))) return;
				_layout.destroy();
			}
			_layout = new layout(this, computeContentSize, registerLayout, setContentAreaIndependent);
			updateLayout();
		}
		
		private function registerLayout(updateLayoutFunction:Function):void 
		{
			_updateLayout = updateLayoutFunction;
		}
		
		private function setContentAreaIndependent(width:Object, height:Object):void
		{
			_contentWidthAreaIndependent = width;
			_contentHeightAreaIndependent = height;
		}
		
		public function get layout():ZvrLayout
		{
			return _layout;
		}
		
		/**
		 * Content bounds.
		 * @return Rectangle descriping bounds of content. Bounds includes content padding.
		 */
		
		public function get contentRect():Rectangle
		{
			return new Rectangle(
				_contents.x - _contentPadding.left, 
				_contents.y - _contentPadding.top, 
				_contentWidth, 
				_contentHeight 
			);
		}
		
		/**
		 * @return width of area for content.
		 */
		
		public function get contentAreaWidth():Number
		{
			return bounds.width - _contentPadding.right - _contentPadding.left;
		}
		
		/**
		 * @return height of area for content.
		 */
		
		public function get contentAreaHeight():Number
		{
			return bounds.height - _contentPadding.top - _contentPadding.bottom;
		}
		
		/**
		 * @return width of area for children.
		 */
		
		public function get childrenAreaWidth():Number
		{
			return bounds.width - _contentPadding.right - _contentPadding.left;
		}
		
		/**
		 * @return height of area for children.
		 */
		
		public function get childrenAreaHeight():Number
		{
			return bounds.height - _contentPadding.top - _contentPadding.bottom;
		}
		
		/**
		 * Elemets to layout. All elements has includeIn or includeInLayout set to true.
		 * @return Vector of components that need to be layout.
		 */
		
		public function get presentElements():Vector.<IZvrComponent>
		{
			return _presentElements;
		}
		
		public function get contentssssssss():Sprite
		{
			return _contents;
		}
		
		override public function set mouseChildren(value:Boolean):void 
		{
			super.mouseChildren = value;
			_base.mouseChildren = value;
		}
		
		public function get contentPadding():ZvrContentPadding 
		{
			return _contentPadding;
		}
		
		public function get childrenPadding():ZvrContentPadding 
		{
			return _contentPadding;
		}
		
		public function get maskingEnabled():Boolean 
		{
			return _maskingEnabled;
		}
		
		public function set maskingEnabled(value:Boolean):void 
		{
			if (_maskingEnabled == value) return;
			
			_maskingEnabled = value;
			
			if (_maskingEnabled)
			{
				_contents.mask = _mask;
				_mask.visible = true;
			}
			else
			{
				_contents.mask = null;
				_mask.visible = false;
			}
		}
		
		public function get contentHeightAreaIndependent():Boolean 
		{
			return _contentHeightAreaIndependent;
		}
		
		public function get contentWidthAreaIndependent():Boolean 
		{
			return _contentWidthAreaIndependent;
		}

		public function addComponent(child:IZvrComponent):IZvrComponent
		{
			return null;
		}

		public function removeComponent(child:IZvrComponent):IZvrComponent
		{
			return null;
		}

		public function addSkinLayer(skinLayer:IZvrSkinLayer):void
		{
		}

		public function addShellLayer(skinLayer:IZvrSkinLayer):void
		{
		}

		public function updateShellDepth(skinLayer:IZvrSkinLayer):void
		{
		}
	}
}

/*
 *
   override public function set mouseChildren (enable:Boolean) : void
   override public function get numChildren () : int
   override public function get tabChildren () : Boolean
   override public function set tabChildren (enable:Boolean) : void
   override public function addChild (child:DisplayObject) : flash.display.DisplayObject
   override public function addChildAt (child:DisplayObject, index:int) : flash.display.DisplayObject
   override public function areInaccessibleObjectsUnderPoint (point:Point) : Boolean
   override public function contains (child:DisplayObject) : Boolean
   override public function getChildAt (index:int) : flash.display.DisplayObject
   override public function getChildByName (name:String) : flash.display.DisplayObject
   override public function getChildIndex (child:DisplayObject) : int
   override public function getObjectsUnderPoint (point:Point) : Array
   override public function removeChild (child:DisplayObject) : flash.display.DisplayObject
   override public function removeChildAt (index:int) : flash.display.DisplayObject
   override public function removeChildren (beginIndex:int=0, endIndex:int=2147483647) : void
   override public function setChildIndex (child:DisplayObject, index:int) : void
   override public function swapChildren (child1:DisplayObject, child2:DisplayObject) : void
   override public function swapChildrenAt (index1:int, index2:int) : void
 *
 * */