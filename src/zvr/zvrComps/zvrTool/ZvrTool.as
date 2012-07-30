package zvr.zvrComps.zvrTool 
{
	import flash.display.DisplayObject;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.UncaughtErrorEvent;
	import flash.system.Capabilities;
	import flash.ui.Keyboard;
	
	import utils.garbageCollection.gc;
	import utils.type.getClass;
	import utils.type.getName;
	
	import zvr.zvrTools.ZvrCompilationDate;
	import zvr.zvrComps.zvrTool.elements.ZvrToolMenu;
	import zvr.zvrComps.zvrTool.zvrSounder.ZvrSounder;
	import zvr.zvrComps.zvrTool.zvrToggler.Toggler;
	import zvr.zvrComps.zvrTool.zvrToggler.ZvrToggler;
	import zvr.zvrComps.zvrTool.zvrTracer.Tracer;
	import zvr.zvrComps.zvrTool.zvrTracer.ZvrTracer;
	import zvr.zvrComps.zvrTool.zvrTracy.Tracy;
	import zvr.zvrComps.zvrTool.zvrTracy.ZvrTracy;
	import zvr.zvrComps.zvrTool.zvrWatcher.Watcher;
	import zvr.zvrComps.zvrTool.zvrWatcher.ZvrWatcher;
	import zvr.zvrComps.zvrTool.zvtStatsChart.ZvrStatsChart;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.TouchMouseMD;
	import zvr.zvrGUI.core.ZvrApplication;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.events.ZvrWindowEvent;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrKeyboard.ZvrKeyboard;


	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTool extends ZvrApplication
	{
		public static var tool:ZvrTool;
		
		public var watcher:ZvrWatcher;
		public var statsChart:ZvrStatsChart;
		public var tracer:ZvrTracer;
		public var tracy:ZvrTracy;
		public var toggler:ZvrToggler;
		public var sounder:ZvrSounder;
		
		private var _lastParentChildNumber:int = 0;
		private var _errors:int = 0;
		private var _uncaughtErrorListenerAdded:Boolean = false;
		
		private var _w:Number;
		
		public var menu:ZvrToolMenu;
		
		
		public function ZvrTool() 
		{	
			super();
			
			tool = this;
			
			statsChart = new ZvrStatsChart();
			statsChart.resetComponent();
			statsChart.width = 120;
			statsChart.height = 150;
			statsChart.bottom = 10;
			statsChart.left = 10;
			
			tracy = new ZvrTracy();
			tracy.resetComponent();
			tracy.width = 450;
			tracy.height = 150;
			tracy.left = 140;
			tracy.bottom = 10;
			
			tracer = new ZvrTracer();
			tracer.resetComponent();
			tracer.height = 150;
			tracer.right = 10;
			tracer.left = 600;
			tracer.bottom = 10;
			
			watcher = new ZvrWatcher();
			watcher.resetComponent();
			watcher.width = 450;
			watcher.right = 10;
			watcher.top = 45;
			watcher.height = 260;
			
			sounder = new ZvrSounder();
			sounder.resetComponent();
			sounder.width = 450;
			sounder.right = 10;
			sounder.top = 315;
			sounder.height = 120;
			
			toggler = new ZvrToggler();
			toggler.resetComponent();
			toggler.width = 450;
			toggler.right = 10;
			toggler.top = 445;
			toggler.bottom = 170;
			
			addChild(statsChart);
			addChild(tracer);
			addChild(watcher);
			addChild(tracy);
			addChild(toggler);
			addChild(sounder);
			
			snaping.enableSnaping(statsChart);
			snaping.enableSnaping(tracer);
			snaping.enableSnaping(watcher);
			snaping.enableSnaping(tracy);
			snaping.enableSnaping(toggler);
			snaping.enableSnaping(sounder);
			
			Watcher.watcher = watcher;
			Tracer.tracer = tracer;
			Tracy.tracy = tracy;
			Toggler.toggler = toggler;
			
			menu = new ZvrToolMenu(this);
			menu.autoSize = ZvrAutoSize.CONTENT;
			addChild(menu);
			menu.right = 15;
			menu.top = 15;
			
			addChild(statsChart.miniStats);
			statsChart.miniStats.top = 3;
			statsChart.miniStats.left = 3;
			
			ZvrKeyboard.addKeyShortcuts(toggleVisible, ZvrKeyboard.CTRL, ZvrKeyboard.ALT, ZvrKeyboard.M);
			ZvrKeyboard.addKeySequenceCallback(toggleVisible, ZvrKeyboard.Z, ZvrKeyboard.X, ZvrKeyboard.C);
			
			if (isReleaseBuild()) toggleVisible();
			if (isDebugPlayer() && isReleaseBuild()) tr("This application run terribly slow on debug player, please run it on relase player");
			if (isDebugPlayer() && isDebugBuild()) tr("Wecome to debug, trace and watch evo.");
			
			tr("----------------------------------------------------------------------------");
			tr("ZvrComonents ver: 0.3");
			tr("Development_progress: Solving last issues with behaviors");
			tr("----------------------------------------------------------------------------");
			
			tgr("Garbage Collector").setFunction(gc);
			
			
			//addChild(new TouchMouseMD());
			
			
		}
		
		private function toggleButtonClick(e:MouseEvent):void 
		{
			toggleVisible();
		}
		
		public function setDocumentClass(documentClass:DisplayObject):void 
		{
			if (_uncaughtErrorListenerAdded) return;
			_uncaughtErrorListenerAdded = true;
			
			documentClass.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, uncaughtError);
			tr("UncaughtErrorListener added. Document class:", getName(getClass(documentClass)));
			
			var ct:ZvrCompilationDate = new ZvrCompilationDate(documentClass);
			tr("----------------------------------------------------------------------------");
			tr("Version:", ct.version);
			tr("BuildTime:", ct.compilationDate.getDate()+"-"+(ct.compilationDate.getMonth()+1)+"-"+ct.compilationDate.getFullYear()+"..."+ct.compilationDate.getHours()+":"+ct.compilationDate.getMinutes()+":"+ct.compilationDate.getSeconds()+"."+ct.compilationDate.getMilliseconds());
			tr("----------------------------------------------------------------------------");
		}
		
		private function uncaughtError(e:UncaughtErrorEvent):void 
		{
			if (e.error is Error)
            {
                var error:Error = e.error as Error;
				var stack:String = error.getStackTrace();
				
                tr(
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n",
				"id:", error.errorID, "\n",
				stack == null ? "Error : "+error.message+"\n\tunknow stackTrace due relasePlayer" : stack , "\n",
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n"
				);
            }
            else if (e.error is ErrorEvent)
            {
                var errorEvent:ErrorEvent = e.error as ErrorEvent;
				tr(
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n",
				"Error (Event)",
				"id:",  errorEvent.errorID, "\n",
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n"
				);
            }
            else
            {
				tr(
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n",
				"Error (Event)",
				"id:",  errorEvent.errorID, "\n",
				"------------------------------------------------------------------------------------------------------------------------------------------------", "\n"
				);
            }
			
			tracy.forceUpdate();
			
			_errors++;
			wch(this, "Errors", _errors);
		}
		
		public static function isDebugPlayer() : Boolean
		{
			return Capabilities.isDebugger;
		}
 
		public static function isDebugBuild() : Boolean
		{
			var r:Boolean = false;
			var e:Error = new Error();
			var s:String = e.getStackTrace();
			if (s != null)
				r = s.search(/:[0-9]+]$/m) > -1;
			else 
				r = false;

			return r;
		}
 
		public static function isReleaseBuild() : Boolean
		{
			return !isDebugBuild();
		}
		
		public function toggleVisible():void 
		{
			if (visible)
			{
				visible = false;
				statsChart.visible = false;
				tracer.visible = false;
				watcher.visible = false;
				tracy.visible = false;
			}
			else
			{
				visible = true;
				statsChart.visible = true;
				tracer.visible = true;
				watcher.visible = true;
				tracy.visible = true;
			}
			
			bringOnTop();
		}
		
		public function bringOnTop():void
		{
			if (!parent) return;
			
			if (parent.getChildIndex(this) != parent.numChildren - 1)
			{
				parent.setChildIndex(this, parent.numChildren -1);
			}
		}
		
		public function layoutForPlayBook():void
		{
			
			tracer.resetComponent();
			tracer.left = 10;
			tracer.width = 550;
			tracer.height = 150;
			tracer.bottom = 15;
			
			toggler.resetComponent();
			toggler.width = 195;
			toggler.right = 215;
			toggler.top = 255;
			toggler.height = 200;
			
			watcher.resetComponent();
			watcher.top = 45;
			watcher.width = 400;
			watcher.right = 10;
			watcher.height = 200;
			
			statsChart.resetComponent();
			statsChart.width = 195;
			statsChart.right = 10;
			statsChart.top = 255;
			statsChart.height = 200;
			
			tracy.resetComponent();
			tracy.width = 400;
			tracy.right = 10;
			tracy.top = 470;
			tracy.bottom = 10;
			
			sounder.close();
			
			
		}
		
		
	}
}