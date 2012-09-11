package zvr.zvrComps.zvrTool.zvtStatsChart 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.system.System;
	import flash.utils.getTimer;
	import utils.array.average;
	import utils.array.sum;
	import zvr.zvrGUI.components.minimalDark.SimpleChartMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;

	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.LinearChartMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LinearChartMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.vo.charts.Chart;
	import zvr.zvrGUI.vo.charts.ChartPointGetter;
	import zvr.zvrTools.ZvrTime;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrStatsChart extends WindowMD 
	{
		
		private var chart:SimpleChartMD;
		private var ct:int;
		private var counter:int = 0;
		
		private var timer : uint;
		private var ms_prev : uint;
		
		private var avgfpsArray:Array = new Array();
		
		private var _ramStatus:LabelMD = new LabelMD();
		private var _ramMaxStatus:LabelMD = new LabelMD();
		private var _timeStatus:LabelMD = new LabelMD();
		
		private var _ramMax:Number = 0;
		
		private var enableButton:ToggleButtonMD;
		private var wchButton:ToggleButtonMD;
		private var charts:ToggleButtonMD;
		
		private var stageFrameRate:int;
		
		public var miniStats:MiniStats = new MiniStats();
		
		public function ZvrStatsChart() 
		{
			
			
			
			title.text = "Zvr Stats Charts v1.1";
			
			//width = 350;
			var menu:ZvrGroup = new ZvrGroup();
			
			menu.percentWidth = 100;
			menu.setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(menu.layout).gap = 1;
			menu.height = 17;
			
			enableButton = new ToggleButtonMD();
			wchButton = new ToggleButtonMD();
			charts = new ToggleButtonMD();
			enableButton.contentPadding.padding = 0;
			wchButton.contentPadding.padding = 0;
			charts.contentPadding.padding = 0;
			
			enableButton.label.text = "enable";
			wchButton.label.text = "wch stats";
			charts.label.text = "charts";
			wchButton.addEventListener(ZvrStateChangeEvent.CHANGE, wchStateChage);
			
			menu.addChild(enableButton);
			menu.addChild(charts);
			menu.addChild(wchButton);
			
			chart = new SimpleChartMD();
			chart.percentWidth = 100;
			chart.top = 0;
			chart.bottom = 0;
			addChild(chart);
			addChild(menu);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addStatusLabel(_ramStatus);
			_ramStatus.left = 60;
			_ramStatus.text = "mem: 00";
			
			addStatusLabel(_ramMaxStatus);
			_ramMaxStatus.left = 125;
			_ramMaxStatus.text = "mem: 00";
			
			addStatusLabel(_timeStatus);
			_timeStatus.left = 205;
			_timeStatus.text = "mem: 00";
			
			name = "StatsChart";
			
			
			enableButton.selected = true;
			charts.selected = true;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
		}
		
		private function wchStateChage(e:ZvrStateChangeEvent):void 
		{
			if (e.isRemoved(ZvrStates.SELECTED)) 
			{
				wch(this, "ram", 0, true);
				wch(this, "ram max", 0, true);
				wch(this, "fps", 0, true);
				wch(this, "avg fps", 0, true);
				wch(this, "fps pr", 0);
				wch(this, "app time", 0, true);
				wch(this, "frame", 0, true);
			}
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFormStage);
			stageFrameRate = stage.frameRate;
			if (watchStats)
			{
				wch(this, "ram", 0);
				wch(this, "ram max", 0);
				wch(this, "fps", 0);
				wch(this, "avg fps", 0);
				wch(this, "fps pr", 0);
				wch(this, "frame", 0);
				wch(this, "app time", 0);
			}
		}
		
		private function removedFormStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFormStage);	
			//removeEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function enterFrame(e:Event):void 
		{
		
			if (owner && !owner.visible) return;
			
			if (stage) stageFrameRate = stage.frameRate;
			
			timer = getTimer();
			var frameDuration:Number = timer - ct;
			ct = timer;
			var fps:Number = 1000 / frameDuration;
			var ram:Number = Number((System.totalMemory * 0.000000954));
			var td:Object = ZvrTime.milisecontsToTime(timer);
			var ts:String = td.minutes+":"+td.seconds;
			
			_ramMax = Math.max(ram, _ramMax);
			
			avgfpsArray.push(fps);
			if (avgfpsArray.length > 50) avgfpsArray.shift();
			var avrageFps:Number = average(avgfpsArray);
			
			miniStats.setStats("fps:\t\t"+avrageFps.toFixed()+"\n"+"ram:\t"+ram.toFixed(1));
			
			
			
			if (!enable) return;
			if (!visible && !watchStats) return;
			
			if (chartsEnabled)
			{
				chart.addValue(fps, 0x25631B);
				chart.addValue(ram, 0xFF1717);
				chart.addValue(avrageFps, 0x34FF17);
				chart.addValue(frameDuration, 0x17FFF3);
				chart.addValue((Math.sin(timer/400)+1)*chart.bounds.height*0.5, 0x489586);
			}
			
			status.text = "fps: " + String(Number(avrageFps).toFixed(2));	
			_ramStatus.text = "mem: " + String(Number(ram).toFixed(2))
			_ramMaxStatus.text = "mem max:"+String(Number(_ramMax).toFixed(2));	
			_timeStatus.text = "appTime: "+ts;
			
			if (watchStats)
			{
				wch(this, "ram", ram.toFixed(2));
				wch(this, "ram max", _ramMax.toFixed(2));
				wch(this, "fps", fps.toFixed(2));
				wch(this, "avg fps", avrageFps.toFixed(0));
				wch(this, "fps pr", int(avrageFps/stageFrameRate*100)+"%");
				wch(this, "frame", frameDuration.toFixed(1));
				wch(this, "app time", ts);
			}
			
			
		}
		
		public function get watchStats():Boolean 
		{
			return wchButton.selected;
		}
		
		public function set watchStats(value:Boolean):void 
		{
			wchButton.selected = value;
		}
		
		public function get enable():Boolean 
		{
			return enableButton.selected;
		}
		
		public function set enable(value:Boolean):void 
		{
			enableButton.selected = value;
		}
		
		public function get chartsEnabled():Boolean 
		{
			return charts.selected;
		}
		
		public function set chartsEnabled(value:Boolean):void 
		{
			charts.selected = value;
		}
		
	}

}