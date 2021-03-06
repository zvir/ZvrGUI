package zvr.zvrGUI.skins.base 
{
	import zvr.zvrGUI.core.IZvrComponent;

	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSkin implements IZvrSkin
	{
		protected var _component:IZvrComponent;
		protected var _body:IZvrSkinLayer;
		protected var _shell:IZvrSkinLayer;
		protected var _availbleBehaviors:Array;
		
		protected var _styles:ZvrSkinStyleManager;
		
		private var _updateComponentSize:Function;
		private var _updateComponentPosition:Function;
		
		private var _getComponentWidth:Function;
		private var _getComponentHeight:Function;
		
		protected var _width:Number;
		protected var _height:Number;
		
		public function ZvrSkin(component:IZvrComponent, registration:Function)
		{
			_component = component;
			registration(updateSize, registerComponent, create);
			_styles = new ZvrSkinStyleManager(this, _component);
			registerStyles();
			setStyles();
			_styles.init();
			
		}

		private function registerComponent(updateComponentSize:Function, updateComponentPosition:Function, getComponentWidth:Function, getComponentHeight:Function):void
		{
			_updateComponentSize = updateComponentSize;
			_updateComponentPosition = updateComponentPosition;

			_getComponentHeight = getComponentHeight;
			_getComponentWidth = getComponentWidth;
		}

		protected function updateComponentSize(width:Number, height:Number):void
		{
			_updateComponentSize(width, height);
		}

		protected function updateComponentPosition(x:Number, y:Number):void
		{
			_updateComponentPosition(x, y);
		}

		protected function get componentWidth():Number
		{
			return _getComponentWidth();
		}

		protected function get componentHeight():Number
		{
			return _getComponentHeight();
		}

		protected function registerStyle(styleName:String, setter:*, getter:Function = null):void
		{
			_styles.registerStyle(styleName, setter, getter);
		}

		protected function create():void
		{
			//_body = new Sprite();
			// to be overrided;
		}

		protected function updateSize():void
		{
			/*var sp:Sprite = _body as Sprite;
			if (sp)
			{
			sp.graphics.clear();
			sp.graphics.beginFill(0x137D1C, 0.7);
			sp.graphics.lineStyle(1, 0x87ED8E, 0.8);
			sp.graphics.drawRect(0, 0, componentWidth, componentHeight);
			}*/

			// to be overrided;
		}

		protected function registerStyles():void
		{
			// to be overrided;
		}

		protected function setStyles():void
		{
			// to be overrided;
		}

		public function get body():IZvrSkinLayer
		{
			return _body;
		}

		public function get shell():IZvrSkinLayer
		{
			return _shell;
		}

		public function get width():Number
		{
			return _width;
		}

		public function get height():Number
		{
			return _height;
		}

		public function get availbleBehaviors():Array
		{
			return _availbleBehaviors;
		}

		// styles
		
		// TODO, proritetize styles. find a clue!

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

		public function forceUpdateSize():void
		{
			updateSize();
		}

		public function getStyle(styleName:String):*
		{
			return _styles.getStyle(styleName);
		}

		public function styleToString(styleName:String):String
		{
			return _styles.styleToString(styleName);
		}

		public function getStylesRegistration(styleName:String):ZvrSkinStyle
		{
			return _styles.getStylesRegistration(styleName);
		}
		
		public function dispose():void 
		{
			
			if (_body) _body.dispose();
			if (_shell) _shell.dispose();
			
			_component = null;
			_body = null;
			_shell = null;
			_availbleBehaviors = null;
			
			_styles.dispose();
			_styles = null;
			
			_updateComponentSize = null;
			_updateComponentPosition = null;
			
			_getComponentWidth = null;
			_getComponentHeight = null;
		}


	}

}