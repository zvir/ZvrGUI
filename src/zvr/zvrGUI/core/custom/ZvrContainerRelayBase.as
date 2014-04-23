package zvr.zvrGUI.core.custom
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.relays.*;

	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrContainerRelayBase extends ZvrComponentBase
	{
		private var _contents:IZvrComponentBody;
		protected var _base:ZvrContainerAccesorBase;
		
		public function ZvrContainerRelayBase(contents:IZvrComponentBody, skin:Class, bodyClass:Class)
		{
			_contents = contents;
			_base = new ZvrContainerAccesorBase(superMethod, superGetter, superSetter);
			super(skin, bodyClass);
		}
		
		override public function dispose():void 
		{
			super.dispose();
			
			_base.dispose();
			_base = null;
			_contents = null;
			
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

		override public function addChild(element:Object):Object
		{
			return _contents.addElement(element);
		}

		override public function removeChild(element:Object):Object
		{
			return _contents.removeElement(element);
		}
		
		protected function get contents():IZvrComponentBody 
		{
			return _contents;
		}

		
	}

}