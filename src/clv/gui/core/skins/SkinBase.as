package clv.gui.core.skins 
{
	import clv.gui.core.Component;
	import clv.gui.core.display.ISkinBody;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	internal class SkinBase 
	{
		
		private var created:Boolean;
		
		protected var _component:Component;
		
		protected var _styles:StyleManager;
		
		public var positionDirty:Boolean;
		public var sizeDirty:Boolean;
		
		public function SkinBase() 
		{
			
		}
		
		internal function init():void
		{
			_styles = new StyleManager(this);
			registerStyles();
			setStyles();
			create();
			_styles.init(_component);
		}
		
		public function addToComponent(component:Component):void
		{
			_component = component;
			
			if (!created)
			{
				init()
				created = true;
			}
			
		}
		
		public function removeFromComponent(component:Component):void 
		{
			
		}
		
		protected function create():void
		{
			// to override
		}
		
		protected function registerStyles():void
		{
			// to override
		}
		
		protected function setStyles():void
		{
			// to override
		}
		
		public function preUpdate():void 
		{
			// to override
		}
		
		public function update():void 
		{
			
		}
		
		public function updateBounds():void 
		{
			// to override
		}
		
		protected function registerStyle(styleName:String, setter:*, getter:Function = null):void
		{
			_styles.registerStyle(styleName, setter, getter);
		}
		
		public function setStyle(styleName:String, value:*, state:* = null):Boolean
		{
			if (state)
			{
				if (state is String)
				{
					if (!_component.hasState(state))
					{
						//trace(_component.states);
						//throw new Error("component has not '" + state + "' defined in states");
					}
				}

				if (state is Array)
				{
					for (var i:int = 0; i < state.length; i++)
					{
						if (!_component.hasState(state[i]))
						{
							//trace(_component.states);
							throw new Error("component has not '" + state[i] + "' defined in states");
						}
					}
				}
			}
			return _styles.setStyle(styleName, value, state);
		}
		
		public function getStyle(styleName:String):*
		{
			return _styles.getStyle(styleName);
		}

	}

}