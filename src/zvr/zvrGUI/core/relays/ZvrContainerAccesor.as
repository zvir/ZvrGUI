package zvr.zvrGUI.core.relays
{
	import flash.display.DisplayObject;
	import flash.geom.Point;
	import zvr.zvrGUI.core.ZvrContainer;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrContainerAccesor
	{
		protected var _superFunction:Function;
		protected var _superGetter:Function;
		protected var _superSetter:Function;
		
		public function ZvrContainerAccesor(superFunction:Function, superGetter:Function, superSetter:Function)
		{
			_superSetter = superSetter;
			_superGetter = superGetter;
			_superFunction = superFunction;
		}
		
		public function get mouseChildren():Boolean
		{
			return _superGetter("mouseChildren");
		}
		
		public function set mouseChildren(enable:Boolean):void
		{
			_superSetter("mouseChildren", enable);
		}
		
		public function get numChildren():int
		{
			return _superGetter("numChildren");
		}
		
		public function get tabChildren():Boolean
		{
			return _superGetter("tabChildren");
		}
		
		public function set tabChildren(enable:Boolean):void
		{
			_superSetter("tabChildren", enable);
		}
		
		public function addChild(child:DisplayObject):DisplayObject
		{
			return _superFunction("addChild", child);
		}
		
		public function addChildAt(child:DisplayObject, index:int):DisplayObject
		{
			return _superFunction("addChildAt", child, index);
		}
		
		public function areInaccessibleObjectsUnderPoint(point:Point):Boolean
		{
			return _superFunction("areInaccessibleObjectsUnderPoint", point)
		}
		
		public function contains(child:DisplayObject):Boolean
		{
			return _superFunction("contains", child);
		}
		
		public function getChildAt(index:int):DisplayObject
		{
			return _superFunction("getChildAt", index);
		}
		
		public function getChildByName(name:String):DisplayObject
		{
			return _superFunction("getChildByName", name);
		}
		
		public function getChildIndex(child:DisplayObject):int
		{
			return _superFunction("getChildIndex", child);
		}
		
		public function getObjectsUnderPoint(point:Point):Array
		{
			return _superFunction("getObjectsUnderPoint", point);
		}
		
		public function removeChild(child:DisplayObject):DisplayObject
		{
			return _superFunction("removeChild", child);
		}
		
		public function removeChildAt(index:int):DisplayObject
		{
			return _superFunction("removeChildAt", index);
		}
		
		public function removeChildren(beginIndex:int = 0, endIndex:int = 2147483647):void
		{
			_superFunction("removeChildren", beginIndex, endIndex);
		}
		
		public function setChildIndex(child:DisplayObject, index:int):void
		{
			_superFunction("setChildIndex", child, index);
		}
		
		public function swapChildren(child1:DisplayObject, child2:DisplayObject):void
		{
			_superFunction("swapChildren", child1, child2);
		}
		
		public function swapChildrenAt(index1:int, index2:int):void
		{
			_superFunction("swapChildrenAt", index1, index2);
		}
	
	}

}