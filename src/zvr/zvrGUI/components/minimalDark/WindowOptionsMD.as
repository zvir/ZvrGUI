package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrWindowEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.WindowOptionsMDSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class WindowOptionsMD extends ZvrContainer 
	{
		
		[Embed(source = "../../../../../assets/windowTitleOptions/maximilize.png")]
		private var _maximilize:Class;
		private var _maximilizeBD:BitmapData = Bitmap(new _maximilize()).bitmapData;
		
		[Embed(source = "../../../../../assets/windowTitleOptions/minimalize.png")]
		private var _minimalize:Class;
		private var _minimalizeBD:BitmapData = Bitmap(new _minimalize()).bitmapData;
		
		[Embed(source="../../../../../assets/windowTitleOptions/restore.png")]
		private var _restore:Class;
		private var _restoreBD:BitmapData = Bitmap(new _restore()).bitmapData;
		
		[Embed(source = "../../../../../assets/windowTitleOptions/close.png")]
		private var _close:Class;
		private var _closeBD:BitmapData = Bitmap(new _close()).bitmapData;
		
		[Embed(source = "../../../../../assets/windowTitleOptions/restore2.png")]
		private var _restore2:Class;
		private var _restoreBD2:BitmapData = Bitmap(new _restore2()).bitmapData;
		
		private var _window:WindowMD;
		
		public var minimalize	:WindowOptionsButtonMD;
		public var maximilaze	:WindowOptionsButtonMD;
		public var close		:WindowOptionsButtonMD;
		
		public function WindowOptionsMD(window:WindowMD) 
		{
			super(WindowOptionsMDSkin);
			_window = window;
			
			autoSize = ZvrAutoSize.CONTENT;
			
			minimalize = new WindowOptionsButtonMD(_minimalizeBD);
			maximilaze = new WindowOptionsButtonMD(_maximilizeBD);
			close = new WindowOptionsButtonMD(_closeBD);
			
			
			addChild(minimalize);
			addChild(maximilaze);
			addChild(close);
			
			minimalize.delegateStates = this
			maximilaze.delegateStates = this
			close.delegateStates = this
			
			minimalize.combineWithDelegateStates = true;
			maximilaze.combineWithDelegateStates = true;
			close.combineWithDelegateStates = true;
			 
			setLayout(ZvrHorizontalLayout);
			
			ZvrHorizontalLayout(layout).gap = 5;
			
			minimalize.addEventListener(MouseEvent.CLICK, click);
			maximilaze.addEventListener(MouseEvent.CLICK, click);
			close.addEventListener(MouseEvent.CLICK, click);
			
			_window.addEventListener(ZvrWindowEvent.MAXIMILIZE, windowMaximilize);
			_window.addEventListener(ZvrWindowEvent.MINIMALIZE, windowMinimalize);
			_window.addEventListener(ZvrWindowEvent.RESTORE, windowRestore);
			
		}
		
		private function windowRestore(e:ZvrWindowEvent):void 
		{			
			maximilaze.icon.bitmapData = _maximilizeBD;
			minimalize.icon.bitmapData  = _minimalizeBD;
		}
		
		private function windowMinimalize(e:ZvrWindowEvent):void 
		{
			maximilaze.icon.bitmapData = _maximilizeBD;
			minimalize.icon.bitmapData  = _restoreBD2;
		}
		
		private function windowMaximilize(e:ZvrWindowEvent):void 
		{
			
			maximilaze.icon.bitmapData = _restoreBD;
			minimalize.icon.bitmapData  = _minimalizeBD;
		}
		
		private function click(e:MouseEvent):void 
		{			
			
			switch (e.currentTarget) 
			{
				case minimalize:
					if (_window.currentStates.indexOf(ZvrStates.RESTORED) != -1 && _window.currentStates.indexOf(ZvrStates.MINIMALIZED) != -1) _window.restore();
					if (_window.currentStates.indexOf(ZvrStates.MINIMALIZED) == -1) _window.minimalize(); else _window.restore();
				break;
				case maximilaze:
					if (_window.currentStates.indexOf(ZvrStates.RESTORED) != -1 && _window.currentStates.indexOf(ZvrStates.MAXIMILIZED) != -1) _window.restore();
					if (_window.currentStates.indexOf(ZvrStates.MAXIMILIZED) == -1) _window.maximilize(); else _window.restore();
				break;
				case close:
					_window.close();
				break;
			}
			
			
			
		}
		
	}

}