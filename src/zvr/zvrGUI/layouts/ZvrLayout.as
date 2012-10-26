package zvr.zvrGUI.layouts 
{
	import flash.geom.Rectangle;

	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.IZvrContainer;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.core.ZvrScroller;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	
	/**
	 *  <p>ZvrLayouts does layouting of elements in container. </p>
	 * 
	 * <p>Main roules of writing custom layouts</p>
	 * 
	 * <p>Update function</p>
	 * <ul>
	 * <li>Custom layout should ovveride <b>update</b> function. </li>
	 * <li>On the begging shoud chceck if it's not already updating then should enter mass mode for all elements.</li>
	 * <li>on the end it should exit mass mode change for all elements.</li>
	 * </ul>
	 * <ul>
	 * <li>Layout should not be useing container contentRect if container, beceose it's updated after update layout.</li>
	 * <li>In case when layout adiust position of elements to container size, there is must to check if container is in manual mode of autoSize.</li>
	 * <li>If not layout shoudl compute the content size itself beceose container size will be changed after layouting.</li>
	 * </ul>
	 * 
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrLayout 
	{
		private var _container:IZvrContainer;
		private var _computeContentBounds:Function;
		private var _contentRectangle:Rectangle = new Rectangle();
		private var _contentAreaRectangle:Rectangle = new Rectangle();
		private var _updatating:Boolean = false;
		
		private var _contentHeightAreaIndependent:Object;
		private var _contentWidthAreaIndependent:Object;
		private var _contentAreaIndependent:Function;
		
		public function ZvrLayout(container:IZvrContainer, computeContentBounds:Function, registration:Function, contentAreaIndependent:Function)
		{
			_contentAreaIndependent = contentAreaIndependent;
			_container = container;
			_computeContentBounds = computeContentBounds;
			registration(update);
		}
		
		// TODO begin and end update methods - to prevent recurection from events dispatchin after changing items.
		// Consider layout registration in conainer and exchange of private methods to:
		// begin
		// update
		// endlayouting
		
		protected final function update():void
		{
			if (_updatating) 
			{
				return;
			}
			_updatating = true;
			enterMassChangeMode();
			layout();
			exitMassChangeMode();
			_updatating = false;
		}
		
		protected function setContentAreaIndependent(width:Object, height:Object):void
		{
			_contentAreaIndependent(width, height);
		}
		
		protected function layout():void
		{
			// to be overrided
		}
		
		public function destroy():void
		{
			_container = null;
		}
		
		protected function get elementes():Vector.<IZvrComponent>
		{
			return _container.presentElements;
		}
		
		/**
		 * Getter for computed bounds of component. Should be stored as local value if is mulit used.
		 * @return  rectangle with bounding box of content in component.
		 */
		
		protected function getContentRectangle():Rectangle 
		{
			var size:Array = _computeContentBounds();
			_contentRectangle.width = size[0];
			_contentRectangle.height = size[1];
			return _contentRectangle;
		}
		
		/**
		 * Getter for computed bounds of component. Should be stored as local value if is mulit used.
		 * @return  rectangle with bounding box of content area in component.
		 */
		
		public function getContentAreaRectangle(contentRect:Rectangle):Rectangle 
		{
			
			switch (_container.autoSize) 
			{
				case ZvrAutoSize.MANUAL:
					_contentAreaRectangle.width = _container.contentAreaWidth;
					_contentAreaRectangle.height = _container.contentAreaHeight;
				break;
				case ZvrAutoSize.CONTENT:
					_contentAreaRectangle.width = contentRect.width;
					_contentAreaRectangle.height = contentRect.height;
				break;
				case ZvrAutoSize.CONTENT_WIDTH:
					_contentAreaRectangle.width = contentRect.width;
					_contentAreaRectangle.height = _container.contentAreaHeight;
				break;
				case ZvrAutoSize.CONTENT_HEIGHT:
					_contentAreaRectangle.width = contentRect.width;
					_contentAreaRectangle.height = _container.contentAreaWidth;
				break;
			}
			
			return _contentAreaRectangle;
		}
		
		protected function enterMassChangeMode():void
		{
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:IZvrComponent = elementes[i];
				comp.enterMassChangeMode();
			}
		}
		
		protected function exitMassChangeMode():void
		{
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:IZvrComponent = elementes[i];
				comp.exitMassChangeMode();
			}
		}
		
	}

}