package zvr.zvrComps.zvrTool.zvrToggler 
{
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToggler extends WindowMD
	{
		
		private var _togglers:Object = {};
		
		public function ZvrToggler() 
		{
			super();
			setLayout(ZvrVerticalLayout);
			ZvrVerticalLayout(layout).gap = 1;
			title.text = "ZvrToggler v 1.0"
		}
		
		public function addToggler(name:String):ZvrTogglerItem 
		{
			
			if (_togglers[name] != undefined) return _togglers[name];
			
			var t:ZvrTogglerItem = new ZvrTogglerItem();
			t.name = name;
			t.toggler = this;
			_togglers[name] = t;
			
			var b:ToggleButtonMD = new ToggleButtonMD();
			addChild(b);
			t.button = b;
			b.percentWidth = 100;
			return t;
		}
		
		public function remove(name:String):void 
		{
			_togglers[name] = null;
			delete _togglers[name];
		}
	}

}