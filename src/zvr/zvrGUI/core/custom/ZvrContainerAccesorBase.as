package zvr.zvrGUI.core.custom
{
	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrContainerAccesorBase
	{
		protected var _superFunction:Function;
		protected var _superGetter:Function;
		protected var _superSetter:Function;
		
		public function ZvrContainerAccesorBase(superFunction:Function, superGetter:Function, superSetter:Function)
		{
			_superSetter = superSetter;
			_superGetter = superGetter;
			_superFunction = superFunction;
		}

		public function addChild(child:Object):Object
		{
			return _superFunction("addChild", child);
		}

		public function removeChild(child:Object):Object
		{
			return _superFunction("removeChild", child);
		}
		
		public function dispose():void 
		{
			_superFunction = null;
			_superGetter = null;
			_superSetter = null;
		}

	}

}