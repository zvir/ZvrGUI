package zvr.zvrComps.zvrTool.elements 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.ui.Multitouch;
	import zvr.zvrComps.zvrTool.ZvrTool;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.events.ZvrWindowEvent;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrToolButton extends ToggleButtonMD 
	{
		
		private var _window:WindowMD;
		private var _tool:ZvrTool;
		
		public function ZvrToolButton(window:WindowMD, tool:ZvrTool) 
		{
			super();
			_tool = tool;
			_window = window;
			_window.addEventListener(ZvrWindowEvent.CLOSE, close);
			
			if (Multitouch.supportsTouchEvents)
			{
				addEventListener(TouchEvent.TOUCH_TAP, click);
			}
			else
			{
				addEventListener(MouseEvent.CLICK, click);
			}
			
			
		}
		
		private function click(e:Event):void 
		{
			if (!selected)
			{
				_window.removeEventListener(ZvrWindowEvent.CLOSE, close);
				_window.close();
				_window.addEventListener(ZvrWindowEvent.CLOSE, close);
			}
			else
			{
				_tool.addChild(_window);
			}
		}
		
		private function close(e:ZvrWindowEvent):void 
		{
			selected = false;
		}
		
	}

}