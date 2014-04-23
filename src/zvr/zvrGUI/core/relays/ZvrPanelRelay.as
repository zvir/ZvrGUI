package zvr.zvrGUI.core.relays
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrContentPadding;
	import zvr.zvrGUI.layouts.ZvrLayout;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrPanelRelay extends ZvrContainer
	{
		
		protected var _contents:ZvrContainer;
		protected var _container:ZvrPanelAccesor;
		
		public function ZvrPanelRelay(skin:Class)
		{
			_container = new ZvrPanelAccesor(superMethod, superGetter, superSetter);
			super(skin);
		}
		
		private function superMethod(method:String, ... args):*
		{
			var f:Function = super[method];
			return f.apply(this, args);
		}
		
		private function superGetter(property:String):*
		{
			return super[property];
		}
		
		private function superSetter(property:String, value:*):void
		{
			super[property] = value;
		}
		
		override public function get mouseChildren():Boolean
		{
			if (_contents)
			{
				return _contents.mouseChildren
			}
			else
			{
				return super.mouseChildren
			}
		}
		
		override public function set mouseChildren(enable:Boolean):void
		{
			if (_contents)
			{
				_contents.mouseChildren = enable;
			}
			else
			{
				super.mouseChildren = enable;
			}
		}
		
		override public function get numChildren():int
		{
			if (_contents)
			{
				return _contents.numChildren;
			}
			else
			{
				return super.numChildren;
			}
		}
		
		override public function get tabChildren():Boolean
		{
			if (_contents)
			{
				return _contents.tabChildren
			}
			else
			{
				return super.tabChildren
			}
		}
		
		override public function set tabChildren(enable:Boolean):void
		{
			if (_contents)
			{
				_contents.tabChildren = enable;
			}
			else
			{
				super.tabChildren = enable;
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			if (_contents)
			{
				return _contents.addChild(child);
			}
			else
			{
				return super.addChild(child);
			}
		}
		
		override public function addChildAt(child:DisplayObject, index:int):flash.display.DisplayObject
		{
			if (_contents)
			{
				return _contents.addChildAt(child, index);
			}
			else
			{
				return super.addChildAt(child, index);
			}
		}
		
		override public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
		{
			if (_contents)
			{
				return _contents.areInaccessibleObjectsUnderPoint(point)
			}
			else
			{
				return super.areInaccessibleObjectsUnderPoint(point)
			}
		}
		
		override public function contains(child:DisplayObject):Boolean
		{
			if (_contents)
			{
				return _contents.contains(child);
			}
			else
			{
				return super.contains(child)
			}
		}
		
		override public function getChildAt(index:int):flash.display.DisplayObject
		{
			if (_contents)
			{
				return _contents.getChildAt(index);
			}
			else
			{
				return super.getChildAt(index);
			}
		}
		
		override public function getChildByName(name:String):flash.display.DisplayObject
		{
			if (_contents)
			{
				return _contents.getChildByName(name);
			}
			else
			{
				return super.getChildByName(name);
			}
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			if (_contents)
			{
				return _contents.getChildIndex(child);
			}
			else
			{
				return super.getChildIndex(child);
			}
		}
		
		override public function getObjectsUnderPoint(point:Point):Array
		{
			if (_contents)
			{
				return _contents.getObjectsUnderPoint(point);
			}
			else
			{
				return super.getObjectsUnderPoint(point);
			}
		}
		
		override public function removeChild(child:DisplayObject):flash.display.DisplayObject
		{
			if (_contents)
			{
				return _contents.removeChild(child);
			}
			else
			{
				return super.removeChild(child);
			}
		}
		
		override public function removeChildAt(index:int):flash.display.DisplayObject
		{
			if (_contents)
			{
				return _contents.removeChildAt(index);
			}
			else
			{
				return super.removeChildAt(index);
			}
		}
		
		override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void
		{
			if (_contents)
			{
				return _contents.removeChildren(beginIndex, endIndex);
			}
			else
			{
				return super.removeChildren(beginIndex, endIndex);
			}
		}
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			if (_contents)
			{
				return _contents.setChildIndex(child, index);
			}
			else
			{
				return super.setChildIndex(child, index);
			}
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			if (_contents)
			{
				return _contents.swapChildren(child1, child2);
			}
			else
			{
				return super.swapChildren(child1, child2);
			}
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			if (_contents)
			{
				return _contents.swapChildrenAt(index1, index2);
			}
			else
			{
				return super.swapChildrenAt(index1, index2);
			}
		}
		
		override public function setLayout(layout:Class):void 
		{
			if (_contents)
			{
				_contents.setLayout(layout);
			}
			else
			{
				super.setLayout(layout);
			}
			
		}
		
		override public function get layout():ZvrLayout 
		{
			if (_contents)
			{
				return _contents.layout
			}
			else
			{
				return super.layout
			}
		}
		
		override public function set autoSize(value:String):void 
		{
			if (_contents)
			{
				_contents.autoSize = value;
			}
			else
			{
				super.autoSize = value;
			}
		}
		
		override public function get autoSize():String 
		{
			if (_contents)
			{
				return _contents.autoSize;
			}
			else
			{
				return super.autoSize;
			}
		}
		
		public function get contentsAAA():ZvrContainer 
		{
			return _contents;
		}
		
		override public function get childrenAreaHeight():Number 
		{
			if (_contents)
			{
				return _contents.childrenAreaHeight;
			}
			else
			{
				return super.childrenAreaHeight;
			}
		}
		
		override public function get childrenAreaWidth():Number 
		{
			if (_contents)
			{
				return _contents.childrenAreaWidth;
			}
			else
			{
				return super.childrenAreaWidth;
			}
		}
		
		override public function get childrenPadding():ZvrContentPadding 
		{
			if (_contents)
			{
				return _contents.childrenPadding;
			}
			else
			{
				return super.childrenPadding;
			}
		}
		
		override public function removeAllChildren():void 
		{
			if (_contents)
			{
				return _contents.removeAllChildren();
			}
			else
			{
				return super.removeAllChildren();
			}
		}
		
	}
}