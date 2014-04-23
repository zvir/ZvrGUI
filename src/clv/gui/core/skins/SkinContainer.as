package clv.gui.core.skins 
{
	import clv.gui.core.display.IChildrenBody;
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.display.IContainerBody;
	import clv.gui.core.display.IContainerMask;
	import clv.gui.core.ICointainer;
	import clv.gui.core.IComponent;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SkinContainer extends Skin implements ISkin
	{
		
		protected var _cointainerBody:IContainerBody;
		
		protected var _mask:IContainerMask;
		
		protected var _childrenBody:IChildrenBody;
		
		public function SkinContainer() 
		{
			
		}
		
		override internal function init():void 
		{
			super.init();
			
			if (!_cointainerBody)
			{
				throw new Error("Skin must create componentBody");
			}
			
		}
		
		public function set maskEnabled(v:Boolean):void
		{
			if (_mask) _mask.enabled = v;
		}
		
		public function setChildrenPosition(x:Number, y:Number):void
		{
			_childrenBody.x = x;
			_childrenBody.y = y;
		}
		
		public function setMaskRect(top:Number, left:Number, width:Number, height:Number):void
		{
			if (_mask) _mask.updateMask(top, left, width, height);
		}
		
		override public function get componentBody():IComponentBody 
		{
			return _cointainerBody;
		}
		
		public function get childrenBody():IChildrenBody 
		{
			return _childrenBody;
		}
		
	}

}