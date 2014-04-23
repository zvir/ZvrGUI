/**
 * Stats
 *
 * Released under MIT license:
 * http://www.opensource.org/licenses/mit-license.php
 *
 * How to use:
 *
 *    addChild( new Stats() );
 *
 *    or
 *
 *    addChild( new Stats( { bg: 0xffffff } );
 *
 * version log:
 *
 *    09.10.22        2.2        Mr.doob            + FlipX of graph to be more logic.
 *                                            + Destroy on Event.REMOVED_FROM_STAGE (thx joshtynjala)
 *    09.03.28        2.1        Mr.doob            + Theme support.
 *    09.02.21        2.0        Mr.doob            + Removed Player version, until I know if it's really needed.
 *                                            + Added MAX value (shows Max memory used, useful to spot memory leaks)
 *                                            + Reworked text system / no memory leak (original reason unknown)
 *                                            + Simplified
 *    09.02.07        1.5        Mr.doob            + onRemovedFromStage() (thx huihuicn.xu)
 *    08.12.14        1.4        Mr.doob            + Code optimisations and version info on MOUSE_OVER
 *    08.07.12        1.3        Mr.doob            + Some speed and code optimisations
 *    08.02.15        1.2        Mr.doob            + Class renamed to Stats (previously FPS)
 *    08.01.05        1.2        Mr.doob            + Click changes the fps of flash (half up increases, half down decreases)
 *    08.01.04        1.1        Mr.doob            + Shameless ripoff of Alternativa's FPS look :P
 *                            Theo            + Log shape for MEM
 *                                            + More room for MS
 *     07.12.13        1.0        Mr.doob            + First version
 **/

package zvr.zvrND2D {

	import de.nulldesign.nd2d.display.BitmapFont2DZVR;
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import de.nulldesign.nd2d.materials.texture.TextureOption;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import flash.system.System;
	import flash.text.StyleSheet;
	import flash.text.TextField;
	import flash.utils.getTimer;
	import zvr.zvrGUI.skins.zvrMinimalDark.ColorsMD;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrTools.ZvrMath;

	public class StatsND2D extends Node2D {
		
		
		private static var _instance:StatsND2D;
		
		/*static public function get instance():StatsND2D 
		{
			if (!_instance) _instance = new StatsND2D();
			return _instance;
		}*/
		
		static public function set instance(value:StatsND2D):void 
		{
			_instance = value;
		}
		
		[Embed(source = "../../../assets/statsND2D.png")]
		private static const Bmp:Class;
		private static const BitmapD:BitmapData = Bitmap(new Bmp()).bitmapData;
		
		private var tex:Texture2D;
		
		private var sliderTex:Texture2D;
		
        protected const WIDTH:uint = 80;
        protected const HEIGHT:uint = 100;

        protected var timer:uint;
        protected var fps:uint = 0;
        protected var ms:uint;
        protected var ms_prev:uint;
        protected var mem:Number = 0;
        protected var mem_max:Number;

        protected var fps_graph:uint;
        protected var mem_graph:uint;
        protected var mem_max_graph:uint;

		public var measuredFPS:Number = 0.0;
        public var driverInfo:String;
        protected var driverInfoToggle:Boolean = false;

        /**
         * <b>Stats</b> FPS, MS and MEM, all in one.
         */
		private var _bg:Sprite2D;
		private var _slider1:Sprite2D;
		private var _slider2:Sprite2D;
		private var _slider3:Sprite2D;
		
		private var _tSlider1:Sprite2D;
		private var _tSlider2:Sprite2D;
		private var _tSlider3:Sprite2D;
		private var _tSlider4:Sprite2D;
		private var _tSlider5:Sprite2D;
		
		private var _fpss:Vector.<uint> = new Vector.<uint>();
		
		private var _text:BitmapFont2DZVR;
		
		private var _ts1:Array = [1];
		private var _ts2:Array = [1];
		private var _ts3:Array = [1];
		private var _ts4:Array = [1];
		
		private var _t1:int;
		private var _t2:int;
		private var _t3:int;
		private var _t4:int;
		
		private var _ft:int;
		
		
        public function StatsND2D():void
		{
			
			instance = this;
			
            mem_max = 0;
			//0x1cd2ae
			tex = Texture2D.textureFromBitmapData(BitmapD); 
			sliderTex = Texture2D.textureFromBitmapData(new BitmapData(64, 8, false, 0xffffff));
			sliderTex.textureOptions = TextureOption.QUALITY_LOW;
			
			_bg = new Sprite2D(tex);
			_slider1 = new Sprite2D(sliderTex);
			_slider3 = new Sprite2D(sliderTex);
			_slider2 = new Sprite2D(sliderTex);
			
			_tSlider1 = new Sprite2D(sliderTex);
			_tSlider2 = new Sprite2D(sliderTex);
			_tSlider3 = new Sprite2D(sliderTex);
			_tSlider4 = new Sprite2D(sliderTex);
			_tSlider5 = new Sprite2D(sliderTex);
			
			_text = FontTextureGenerator.texture(FontTextureGenerator.commonChar1, MDFonts.Mono0755, 8, ColorsMD.c2, 6, 13, 50);
			
            addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
			
			//scrollRect = new Rectangle(100, 100, 256, 120);
        }

		override public function dispose():void 
		{
			super.dispose();
			//if (instance == this) instance = null;
			_bg = null;
			_slider1 = null;
			_slider3 = null;
			_slider2 = null;
			
			_tSlider1 = null;
			_tSlider2 = null;
			_tSlider3 = null;
			_tSlider4 = null;
			_tSlider5 = null;
			
			_text = null;
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}
		
        private function init(e:Event):void
		{
            
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			addChild(_bg);
			addChild(_slider1);
			addChild(_slider2);
			addChild(_slider3);
			
			_slider1.tint = 0x1cd2ae;
			_slider2.tint = 0x1cd2ae;
			_slider3.tint = 0x1cd2ae;
			
			addChild(_tSlider4);
			
			addChild(_tSlider1);
			addChild(_tSlider2);
			addChild(_tSlider3);
			addChild(_tSlider5);
			
			
			addChild(_text);
			
			_slider1.x = 40 + _slider1.width * 0.5;
			_slider1.y = 19 + 1;
			
			_slider1.height = 2;
			_slider3.height = 6;
			
			_slider3.x = 40 + _slider3.width * 0.5;
			_slider3.y = 19 + 5;
			
			_slider2.x = 40 + _slider2.width * 0.5;
			_slider2.y = 50 + 4;
			
			_tSlider1.width = 20;
			_tSlider2.width = 20;
			_tSlider3.width = 20;
			_tSlider4.width = 20;
			
			_tSlider1.tint = 0x00FFFF;
			_tSlider2.tint = 0xFF0000;
			_tSlider3.tint = 0xFF0000;
			_tSlider4.tint = 0x16A98B;
			_tSlider5.tint = 0x56E9CB;
			
			_tSlider1.x = 50;
			_tSlider2.x = 70;
			_tSlider3.x = 90;
			_tSlider4.x = 110;
			
			_tSlider1.y = 85;
			_tSlider2.y = 85;
			_tSlider3.y = 85;
			_tSlider4.y = 85;
			_tSlider5.y = 85;
			
			_bg.x = 128;
			_bg.y = 60;
			
			_text.x = 40;
			_text.y = 96;
			_text.text = "STATS";
        }
		
		override protected function step(elapsed:Number):void 
		{
			super.step(elapsed);
            mem = Number((System.totalMemory * 0.000000954));
			
			var t:int =  getTimer();
			t4 = t - _ft;
			_ft = t;
			
			fps = 1 / elapsed;
			
			_fpss.push(fps);
			
			if (_fpss.length > 100)
			{
				_fpss.shift();
			}
			
			var afps:uint = 0;
			
			for (var i:int = 0; i <_fpss.length; i++) 
			{
				afps += _fpss[i];
			}
			afps /= _fpss.length;
			
			if (fps > 10)
			{
				_slider1.width = fps * 2;
				_slider1.width = _slider1.width > 200 ? 200 : _slider1.width;
				_slider3.width = afps * 2;
				_slider3.width = _slider3.width > 200 ? 200 : _slider3.width;
				_slider2.width = int(mem * 0.66666);
				_slider2.width = int(_slider2.width > 216 ? 216 : _slider2.width);
				
				_slider1.x = 40 + _slider1.width * 0.5;
				_slider3.x = 40 + _slider3.width * 0.5;
				_slider2.x = 40 + _slider2.width * 0.5;
				
				_tSlider1.width = getTa(_ts1) * 4;
				_tSlider2.width = getTa(_ts2) * 4;
				_tSlider3.width = getTa(_ts3) * 4;
				
				_tSlider1.x = 40 + _tSlider1.width * 0.5;
				_tSlider2.x = _tSlider1.x + _tSlider1.width * 0.5 + _tSlider2.width * 0.5;
				_tSlider3.x = _tSlider2.x + _tSlider2.width * 0.5 + _tSlider3.width * 0.5;
				
				_tSlider4.width = getTa(_ts4) * 4;
				_tSlider4.width = _tSlider4.width > 216 ? 216 : _tSlider4.width;
				_tSlider4.x = 40 + _tSlider4.width * 0.5;
				
				_tSlider5.width = 2;
				_tSlider5.x = 40 + (1000 / _stage.frameRate) * 4;
				
			}
			
        }
		
		public function set text(value:String):void 
		{
			_text.text = value;
		}
		
		public function set t1(v:int):void { _t1 = v; setT(v, _ts1); }
		public function set t2(v:int):void { _t2 = v; setT(v, _ts2); }
		public function set t3(v:int):void { _t3 = v; setT(v, _ts3); }
		private function set t4(v:int):void { _t4 = v; setT(v, _ts4); }
		
		public function get t1():int { return _t1;	}
		public function get t2():int { return _t2;	}
		public function get t3():int { return _t3;	}
		private function get t4():int { return _t4;	}
		
		private function setT(v:int, a:Array):void
		{
			a.push(v);
			if (a.length > 10) a.shift();
		}
		
		private function getTa(a:Array):Number
		{
			var v:Number = 0;
			
			for (var i:int = 0; i <a.length; i++) 
			{
				v += a[i];
			}
			
			v /= a.length;
			
			v = v == 0 ? 0.1 : v;
			
			return v;
		}
		
    }
}
