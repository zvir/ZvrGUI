package 
{
	import flash.desktop.NativeApplication;
	import flash.display.StageAlign;
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import zvr.zvrComps.zvrTool.ZvrTool;
	import zvr.zvrGUI.components.minimalDark.dataList.DataListHorizontallGridLayout;
	import zvr.zvrGUI.components.minimalDark.dataList.DataListVerticalGridLayout;
	import zvr.zvrGUI.components.minimalDark.DataListMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.core.ZvrApplication;
	import zvr.zvrGUI.events.ZvrWindowEvent;
	import zvr.zvrGUI.test.dataTest.DataListItem;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class Main extends ZvrApplication 
	{
		private var dataCont:DataListMD;
		
		public function Main():void 
		{
			super();
		}
		
		override protected function addedToStage(e:Event):void 
		{
			super.addedToStage(e);
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			
			//stage.addEventListener(KeyboardEvent.KEY_DOWN, escapePrevent);
			childrenPadding.padding = 10;
			
			tests();
			
			var t:ZvrTool = new ZvrTool();
			addChild(t);
		}
		
		private function tests():void 
		{
			
			var w:WindowMD = new WindowMD();
			w.horizontalCenter = 0;
			w.top = 0;
			w.bottom = 0;
			w.width = 300;
			addChild(w);
			
			w.addEventListener(ZvrWindowEvent.CLOSE, windowClosed);
			
			var data:Array = [];
			
			for (var i:int = 0; i < 100; i++) 
			{
				data[i] = i + " :: TEST";
			}
			
			dataCont = new DataListMD(DataListItem, w.panel.scroller.verticalScroll, w.panel.scroller.horizontalScroll);
			
			//dataCont.setDataLayout(DataListVerticalLayout);
			dataCont.setLayout(DataListVerticalGridLayout);
			
			//ZvrVerticalLayout(dataCont.layout).gap = 0;
			
			dataCont.percentHeight = 100;
			dataCont.percentWidth = 100;
			
			w.panel.scroller.customScroll = true;
			
			w.addChild(dataCont);
			dataCont.setData(data);
			stage.addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void 
		{
			var data:Array = [];
			
			for (var i:int = 0; i < 100 + Math.random() * 100; i++) 
			{
				data[i] = i + " :: " + Math.random().toFixed(5);
			}
			
			dataCont.setData(data);
		}
		
		private function windowClosed(e:ZvrWindowEvent):void 
		{
			NativeApplication.nativeApplication.exit();
		}
		
		/*private function escapePrevent(e:KeyboardEvent):void 
		{
			if( e.keyCode == Keyboard.ESCAPE )
			{
				e.preventDefault();
			}
			
		}*/
		
	}
	
}