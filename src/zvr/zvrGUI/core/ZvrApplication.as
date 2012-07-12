package zvr.zvrGUI.core 
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import zvr.zvrGUI.managers.ZvrActiveWindowManager;
	import zvr.zvrGUI.managers.ZvrGroupsManager;
	import zvr.zvrGUI.managers.ZvrPopupManager;
	import zvr.zvrGUI.managers.ZvrSnapManager;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrKeyboard.ZvrKeyboard;
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrApplication extends ZvrContainer
	{
		
		private var _activeWindowManager:ZvrActiveWindowManager;
		private var _groupsManager:ZvrGroupsManager;
		private var _snapManager:ZvrSnapManager;
		private var _popupManager:ZvrPopupManager;
		
		private var _windowsLayer:ZvrContainer;
		private var _backgraoundLayer:ZvrContainer;
		private var _popupLauer:ZvrContainer;
		
		public function ZvrApplication() 
		{
			super(ZvrSkin);
			
			//_interactiveCover.disable();
			
			_snapManager 		= new ZvrSnapManager(this);
			_windowsLayer 		= new ZvrContainer(ZvrSkin);
			_backgraoundLayer 	= new ZvrContainer(ZvrSkin);
			_popupLauer 		= new ZvrContainer(ZvrSkin);
			
			_windowsLayer.debugEnable = false;		
			_backgraoundLayer.debugEnable = false; 	
			_popupLauer.debugEnable = false;
			debugEnable = false;
			
			super.addChild(_backgraoundLayer);
			super.addChild(_windowsLayer);
			
			_windowsLayer.percentHeight = 100;
			_windowsLayer.percentWidth = 100;
			
			super.addChild(_popupLauer);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		protected function addedToStage(e:Event):void 
		{
			ZvrKeyboard.init(stage);
			
			if (parent != stage)
			{
				stage.addChild(this);
				return;
			}
			
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			stageResize(null);
			stage.addEventListener(Event.RESIZE, stageResize);
		}
		
		protected function removedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			stage.removeEventListener(Event.RESIZE, stageResize);
		}
		
		protected function stageResize(e:Event):void 
		{
			x = 0;
			y = 0;
			width = stage.stageWidth;
			height = stage.stageHeight;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject 
		{
			return _windowsLayer.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject 
		{
			return _windowsLayer.removeChild(child);
		}
		
		override public function get presentElements():Vector.<ZvrComponent> 
		{
			return _windowsLayer.presentElements;
		}
		
		public function get snaping():ZvrSnapManager 
		{
			return _snapManager;
		}
		
		public function get popups():ZvrPopupManager 
		{
			return _popupManager;
		}
		
	}

}