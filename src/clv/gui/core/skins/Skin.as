package clv.gui.core.skins 
{
	import clv.gui.core.Component;
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.display.ISkinBody;
	import clv.gui.core.IComponent;
	import clv.gui.core.skins.StyleManager;
	/**
	 * ...
	 * @author ...
	 */
	public class Skin extends SkinBase implements ISkin
	{
		
		
		protected var _componentBody:IComponentBody;
		
		public function Skin() 
		{
			
		}
		
		public function get componentBody():IComponentBody 
		{
			return _componentBody;
		}
		
		override internal function init():void 
		{
			super.init();
			
			if (!componentBody)
			{
				throw new Error("Skin must create componentBody");
			}
			
		}
		
	}

}