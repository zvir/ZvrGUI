package zvr.zvrGUI.layouts 
{
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrComplexLayout extends ZvrLayout
	{
		
		public static const VERTICAL:String = "vertical";
		public static const HORIZONTAL:String = "horizontal";
		
		private var _gap:Number = 2;
		private var _verticalAlign:String = ZvrVerticalAlignment.MIDDLE;
		private var _horizontalAlign:String = ZvrHorizontalAlignment.LEFT;
		private var _alignment:String = ZvrAlignment.HORIZONTAL;
		
		private var _pixelSharp:Boolean = false;
		
		public function ZvrComplexLayout(cointainer:ZvrContainer, computeContentBounds:Function, registration:Function) 
		{
			super(cointainer, computeContentBounds, registration);
		}
		
		override protected function layout():void 
		{
			
			switch (_alignment) 
			{
				case ZvrAlignment.HORIZONTAL:
					horizontalAlignment();
				break;
				
				case ZvrAlignment.VERTICAL:
					verticalAlignment();
				break;
			}
			
			var contentRect:Rectangle = getContentRectangle();
			var containerBounds:Rectangle = getContentAreaRectangle(contentRect);
			
			var c:Number =  containerBounds.width / 2 - contentRect.width / 2;
			var m:Number =  containerBounds.height / 2 - contentRect.height / 2;
			
			// TODO finish rest combination of leyouting, test it, and if it's ok, maybe move it's parts or all to the rest layouts
			
			var firstComponentLeft:Number = 0;
			var firstComponentTop:Number = 0;
			var lastComponentRight:Number = 0;
			var lastComponentBottom:Number = 0;
			
			if (elementes.length > 0)
			{
				firstComponentLeft = isNaN(elementes[0].left) ? 0 : elementes[0].left;
				firstComponentTop = isNaN(elementes[0].top) ? 0 : elementes[0].top;
				lastComponentRight = isNaN(elementes[elementes.length - 1].right) ? 0 : elementes[elementes.length - 1].right;
				lastComponentBottom = isNaN(elementes[elementes.length - 1].bottom) ? 0 : elementes[elementes.length - 1].bottom;
			}
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:ZvrComponent = elementes[i];
				
				if (_alignment == ZvrAlignment.HORIZONTAL)
				{
					if (_horizontalAlign == ZvrHorizontalAlignment.CENTER)
					{
						comp.x += getPos(c - firstComponentLeft * 0.5);
					}
					else if (_horizontalAlign == ZvrHorizontalAlignment.RIGHT)
					{
						comp.x += getPos(containerBounds.width - contentRect.width-lastComponentRight);
					}
					else if (_horizontalAlign == ZvrHorizontalAlignment.LEFT)
					{
						// deafult
					}
					
					if (_verticalAlign == ZvrVerticalAlignment.MIDDLE)
					{
						comp.y += getPos(containerBounds.height / 2 - comp.bounds.height / 2);
					}
				}
				
				if (_alignment == ZvrAlignment.VERTICAL)
				{
					
					if (_horizontalAlign == ZvrHorizontalAlignment.CENTER)
					{
						comp.x += getPos(containerBounds.width / 2 - comp.bounds.width / 2);
					}
					
					if (_horizontalAlign == ZvrHorizontalAlignment.LEFT)
					{
						comp.x -= getPos(comp.independentBounds.left);
					}
					
					if (_horizontalAlign == ZvrHorizontalAlignment.RIGHT)
					{
						comp.x += getPos(containerBounds.width - comp.independentBounds.width);
					}
					
					if (_verticalAlign == ZvrVerticalAlignment.MIDDLE)
					{
						comp.y += getPos(m);
					}
					
					if (_verticalAlign == ZvrVerticalAlignment.TOP)
					{
						comp.y += getPos(m);
					}
					
					if (_verticalAlign == ZvrVerticalAlignment.BOTTOM)
					{
						comp.y += getPos(m);
					}
					
				}
				
			}
		}
		
		private function getPos(v:Number):Number
		{
			return _pixelSharp ? int(v) : v;
		}
		
		private function horizontalAlignment():void
		{
			var x:Number = 0;
			var w:Number = 0;
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:ZvrComponent = elementes[i];
				comp.x = x + w + (isNaN(comp.left) ? 0 : comp.left);
				comp.y = 0;
				x = comp.x;
				w = comp.bounds.width + _gap + (isNaN(comp.right) ? 0 : comp.right);
			}
			
		}
		
		private function verticalAlignment():void
		{
			var y:Number = 0;
			var h:Number = 0;
			
			for (var i:int = 0; i < elementes.length; i++) 
			{
				var comp:ZvrComponent = elementes[i];
				comp.y = y + h + (isNaN(comp.top) ? 0 : comp.top);
				comp.x = 0;
				y = comp.y;
				h = comp.bounds.height + _gap;
			}
		}
		
		public function get alignment():String 
		{
			return _alignment;
		}
		
		public function set alignment(value:String):void 
		{
			_alignment = value;
			update();
		}
		
		public function get horizontalAlign():String 
		{
			return _horizontalAlign;
		}
		
		public function set horizontalAlign(value:String):void 
		{
			_horizontalAlign = value;
			update();
		}
		
		public function get verticalAlign():String 
		{
			return _verticalAlign;
		}
		
		public function set verticalAlign(value:String):void 
		{
			_verticalAlign = value;
			update();
		}
		
		public function get gap():Number 
		{
			return _gap;
		}
		
		public function set gap(value:Number):void 
		{
			_gap = value;
		}
		
		public function get pixelSharp():Boolean 
		{
			return _pixelSharp;
		}
		
		public function set pixelSharp(value:Boolean):void 
		{
			_pixelSharp = value;
			update();
		}
		
	}

}