package zvr.zvrComps 
{
	import flash.events.Event;
	import flash.system.System;
	import flash.utils.getTimer;
	import utils.array.average;
	import utils.array.sum;

	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.LinearChartMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LinearChartMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.vo.charts.Chart;
	import zvr.zvrGUI.vo.charts.ChartPointGetter;
	import zvr.ZvrTools.ZvrTime;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrStatsChart extends WindowMD 
	{
		
		private var chart:LinearChartMD;
		private var mem:Chart;
		private var fps:Chart;
		private var avgfps:Chart;
		private var ct:int;
		
		private var avgfpsArray:Array = new Array();
		
		private var _memStatus:LabelMD = new LabelMD();
		private var _memMaxStatus:LabelMD = new LabelMD();
		private var _timeStatus:LabelMD = new LabelMD();
		
		private var _memMax:Number = 0;
		
		public var watchStats:Boolean = false;
		
		public function ZvrStatsChart() 
		{
			
			title.text = "Zvr Stats Charts v1.0";
			
			//width = 350;
			
			chart = new LinearChartMD();
			chart.percentWidth = 100;
			chart.percentHeight = 100;
			chart.chatType = LinearChartMDSkin.BITMAP_DOTS;
			addChild(chart);
			chart.scroll = panel.scroller;
			
			mem = new Chart();
			fps = new Chart();
			avgfps = new Chart();
			
			mem.color = 0xFFFF00;
			avgfps.color = 0x39FD00;
			
			fps.maxColor = 0x0080FF;
			fps.minColor = 0xFF0F09;
			
			fps.maxValueColor = 55;
			fps.minValueColor = 10;
			
			mem.maxPoins = 300;
			fps.maxPoins = 300;
			avgfps.maxPoins = 300;
			
			chart.addChart(mem);
			chart.addChart(fps);
			chart.addChart(avgfps);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			addStatusLabel(_memStatus);
			_memStatus.left = 60;
			_memStatus.width = 60;
			_memStatus.labelAutoSize = false;
			_memStatus.text = "mem: 00";
			_memStatus.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);

            addStatusLabel(_memMaxStatus);
			_memMaxStatus.left = 125;
			_memMaxStatus.width = 60;
			_memMaxStatus.labelAutoSize = false;
			_memMaxStatus.text = "mem: 00";
			_memMaxStatus.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);

            addStatusLabel(_timeStatus);
			_timeStatus.left = 205;
			_timeStatus.width = 60;
			_timeStatus.labelAutoSize = false;
			_timeStatus.text = "mem: 00";
			_timeStatus.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Uni05);
			
			status.labelAutoSize = false;
			status.x = 0;
			status.width = 60;
			
			name = "StatsChart";
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFormStage);
			addEventListener(Event.ENTER_FRAME, enterFrame);
			
			if (watchStats)
			{
				wch(this, "mem", 0);
				wch(this, "mem max", 0);
				wch(this, "fps", 0);
				wch(this, "avg fps", 0);
				wch(this, "app time", 0);
			}
			
		}
		
		private function removedFormStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFormStage);
			removeEventListener(Event.ENTER_FRAME, enterFrame);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function enterFrame(e:Event):void 
		{
			if (!visible) return;
			
			var t:int = getTimer()
			
			var f:Number = 1000 / (t - ct);
			f = f > stage.frameRate ? stage.frameRate : f;
			
			fps.addPoint(ChartPointGetter.getPoint(t/10, f));
			
			status.text = "fps: " + String(Number(f).toFixed(2));	
			
			var m:* = Number((System.totalMemory * 0.000000954));
			mem.addPoint(ChartPointGetter.getPoint(t / 10, m));
			_memMax = Math.max(m, _memMax)
			_memStatus.text = "mem: " + String(Number(m).toFixed(2))
			_memMaxStatus.text = "mem max:"+String(Number(_memMax).toFixed(2));	
			
			var td:Object = ZvrTime.milisecontsToTime(t);
			var ts:String = td.minutes+":"+td.seconds+"."+td.miliseconds;
			
			_timeStatus.text = "appTime: "+ts;
			
			avgfpsArray.push(f);
			if (avgfpsArray.length > 50) avgfpsArray.shift();
			
			var a:Number = average(avgfpsArray);
			
			avgfps.addPoint(ChartPointGetter.getPoint(t / 10, a));
			
			if (watchStats)
			{
				wch(this, "mem", m.toFixed(2));
				wch(this, "mem max", _memMax.toFixed(2));
				wch(this, "fps", f.toFixed(2));
				wch(this, "avg fps", a.toFixed(1));
				wch(this, "app time", ts);
			}
			ct = getTimer();
		}
		
	}

}