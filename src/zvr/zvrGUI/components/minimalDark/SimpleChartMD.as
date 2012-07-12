package zvr.zvrGUI.components.minimalDark 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.skins.zvrMinimalDark.SimpleChartMDSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class SimpleChartMD extends ZvrComponent 
	{
		
		private var _pointsToDraw:Array = [];
		private var _clear:Boolean;
		
		public function SimpleChartMD() 
		{
			super(SimpleChartMDSkin);	
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		public function addValue(value:Number, color:uint):void
		{
			if (_pointsToDraw.length == 0)
			{
				_pointsToDraw[0] = [];
			}
			_pointsToDraw[_pointsToDraw.length - 1].push( { value:value, color:color } );
		}
		
		public function step():void
		{
			_pointsToDraw[_pointsToDraw.length] = [];
		}
		
		public function clear():void 
		{
			_clear = true;
		}
		
		private function enterFrame(e:Event):void 
		{
			
			if (_clear) 
			{
				SimpleChartMDSkin(skin).clear();
				_clear = false;
			}
			
			if (_pointsToDraw.length == 0) return;
			
			SimpleChartMDSkin(skin).redraw(_pointsToDraw);
			
			_pointsToDraw.length = 0;
		}
		
	}

}