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

	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
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
	import zvr.zvrTools.ZvrMath;

	public class StatsND2D extends Node2D {
		
		
		[Embed(source = "../../../assets/statsND2D.png")]
		private static const Bmp:Class;
		private static const BitmapD:BitmapData = Bitmap(new Bmp()).bitmapData;
		private static const tex:Texture2D = Texture2D.textureFromBitmapData(BitmapD); 
		
		private static const sliderTex:Texture2D = Texture2D.textureFromBitmapData(new BitmapData(64, 8, false, 0x1cd2ae));
		
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
		
		private var _fpss:Vector.<uint> = new Vector.<uint>();
		
        public function StatsND2D():void
		{
            mem_max = 0;
			
			_bg = new Sprite2D(tex);
			_slider1 = new Sprite2D(sliderTex);
			_slider3 = new Sprite2D(sliderTex);
			_slider2 = new Sprite2D(sliderTex);
			
            addEventListener(Event.ADDED_TO_STAGE, init, false, 0, true);
        }

        private function init(e:Event):void
		{
            
			addChild(_bg);
			addChild(_slider1);
			addChild(_slider2);
			addChild(_slider3);
			
			_slider1.x = 40 + _slider1.width * 0.5;
			_slider1.y = 19 + 1;
			
			_slider1.height = 2;
			_slider3.height = 6;
			
/*			_slider1.alpha = 0.3;
			_slider3.alpha = 0.3;*/
			
			_slider3.x = 40 + _slider3.width * 0.5;
			_slider3.y = 19 + 5;
			
			_slider2.x = 40 + _slider2.width * 0.5;
			_slider2.y = 50 + 4;
			
			_bg.x = 128;
			_bg.y = 32;
			
        }
		
		override protected function step(elapsed:Number):void 
		{
			super.step(elapsed);
            mem = Number((System.totalMemory * 0.000000954));
			
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
			}

        }
    }
}
