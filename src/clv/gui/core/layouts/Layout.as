package clv.gui.core.layouts 
{
	
	import clv.gui.core.IComponent;
	import flash.geom.Rectangle;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Layout 
	{
		protected var _contentMaxIndependentHeight:Number;
		protected var _contentMaxIndependentWidth:Number;
		protected var _contentIndependentRight:Number;
		protected var _contentIndependentBottom:Number;
		
		protected var _contentWidth:Number;
		protected var _contentHeight:Number;
		
		
		public function Layout() 
		{
			
		}
		
		public function begin(contentWidth:Number, contentHeight:Number, contentIndependentRight:Number, contentIndependentBottom:Number, contentMaxIndependentWidth:Number, contentMaxIndependentHeight:Number, children:Vector.<IComponent>):void 
		{
			_contentIndependentRight = contentIndependentRight;
			_contentIndependentBottom = contentIndependentBottom;
			_contentMaxIndependentWidth = contentMaxIndependentWidth;
			_contentMaxIndependentHeight = contentMaxIndependentHeight;
			
			_contentHeight = contentHeight;
			_contentWidth = contentWidth;
			
		}
		
		public function layout(children:IComponent):Rectangle 
		{
			return null;
		}
		
		public function end():void 
		{
			
		}
		
	}

}