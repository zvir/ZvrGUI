package zvr.zvrGUI.core.relays
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrComponent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrContainerRelay extends ZvrComponent
	{
		
		private var _contents:DisplayObjectContainer;
		protected var _base:ZvrContainerAccesor;
		
		public function ZvrContainerRelay(contents:DisplayObjectContainer, skin:Class)
		{
			_contents = contents;
			_base = new ZvrContainerAccesor(superMethod, superGetter, superSetter);
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
			return _contents.mouseChildren;
		}
		
		override public function set mouseChildren(enable:Boolean):void
		{
			_contents.mouseChildren = enable;
		}
		
		override public function get numChildren():int
		{
			return _contents.numChildren;
		}
		
		override public function get tabChildren():Boolean
		{
			return _contents.tabChildren
		}
		
		override public function set tabChildren(enable:Boolean):void
		{
			_contents.tabChildren = enable;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject
		{
			return _contents.addChild(child);
		}
		
		override public function addChildAt(child:DisplayObject, index:int):flash.display.DisplayObject
		{
			return _contents.addChildAt(child, index);
		}
		
		override public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
		{
			return _contents.areInaccessibleObjectsUnderPoint(point)
		}
		
		override public function contains(child:DisplayObject):Boolean
		{
			return _contents.contains(child);
		}
		
		override public function getChildAt(index:int):flash.display.DisplayObject
		{
			return _contents.getChildAt(index);
		}
		
		override public function getChildByName(name:String):flash.display.DisplayObject
		{
			return _contents.getChildByName(name);
		}
		
		override public function getChildIndex(child:DisplayObject):int
		{
			return _contents.getChildIndex(child);
		}
		
		override public function getObjectsUnderPoint(point:Point):Array
		{
			return _contents.getObjectsUnderPoint(point);
		}
		
		override public function removeChild(child:DisplayObject):flash.display.DisplayObject
		{
			return _contents.removeChild(child);
		}
		
		override public function removeChildAt(index:int):flash.display.DisplayObject
		{
			return _contents.removeChildAt(index);
		}
		
		/*override public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void
		{
			return _contents.removeChildren(beginIndex, endIndex);
		}*/
		
		override public function setChildIndex(child:DisplayObject, index:int):void
		{
			return _contents.setChildIndex(child, index);
		}
		
		override public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			return _contents.swapChildren(child1, child2);
		}
		
		override public function swapChildrenAt(index1:int, index2:int):void
		{
			return _contents.swapChildrenAt(index1, index2);
		}
		
		
	}

}