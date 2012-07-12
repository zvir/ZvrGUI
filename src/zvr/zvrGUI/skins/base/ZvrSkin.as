package zvr.zvrGUI.skins.base 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.Dictionary;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.events.ZvrStyleChangeEvent;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSkin
	{
		protected var _component:ZvrComponent;
		protected var _body:DisplayObject;
		protected var _shell:DisplayObject;
		protected var _availbleBehaviors:Array;
		
		protected var _styles:ZvrSkinStyleManager;
		
		private var _updateComponentSize:Function;
		private var _updateComponentPosition:Function;
		
		private var _getComponentWidth:Function;
		private var _getComponentHeight:Function;
		
		protected var _width:Number;
		protected var _height:Number;
		
		
		public function ZvrSkin(component:ZvrComponent, registration:Function) 
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
			// to be overrided;
		}
		
		protected function updateSize():void
		{
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
		
		public function get body():DisplayObject 
		{
			return _body;
		}
		
		public function get shell():DisplayObject 
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
		
		
	}

}