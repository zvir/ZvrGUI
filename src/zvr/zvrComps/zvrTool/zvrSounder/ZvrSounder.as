package zvr.zvrComps.zvrTool.zvrSounder 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import zvr.zvrGUI.components.minimalDark.SliderMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrSliderEvent;
	import zvr.ZvrTools.ZvrColor;
	import zvr.ZvrTools.ZvrMath;
	import zvr.ZvrTools.ZvrSnd;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrSounder extends WindowMD
	{
		
		
		private var _bitmap:Bitmap;
		private var _bitmapL:Bitmap;
		private var _bitmapR:Bitmap;
		private var _bitmapTemp:BitmapData;
		
		
		private var _colorFilter:ColorMatrixFilter;
		private var _blur:BlurFilter;
		
		private var _volumeBar:SliderMD = new SliderMD();
		
		public function ZvrSounder() 
		{
			super();
			
			title.text = "ZvrSounder v 1.0";
			
			addEventListener(ZvrComponentEvent.RESIZE, onResize);
			

			_bitmap = new Bitmap(new BitmapData(contWidth, contHeight/3, true, 0x00000000));
			_bitmapL = new Bitmap(new BitmapData(contWidth, 1, true, 0x00000000));
			_bitmapR = new Bitmap(new BitmapData(contWidth, 1, true, 0x00000000));
			
			addChild(_bitmap);
			addChild(_bitmapL);
			addChild(_bitmapR);
			
			_volumeBar.bottom = 0;
			_volumeBar.percentWidth = 100;
			_volumeBar.min = 0;
			_volumeBar.max = 1;
			_volumeBar.position = 1;
			addChild(_volumeBar);
			
			_volumeBar.addEventListener(ZvrSliderEvent.POSITION_CHANGED, volumeChanged);
			
			
			_colorFilter = ZvrColor.setAlpha(0.9);
			_blur = new BlurFilter(2, 0, 1);
			
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
		}
		
		private function volumeChanged(e:ZvrSliderEvent):void 
		{
			SoundMixer.soundTransform = new SoundTransform(e.slider.position);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function removedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function get contWidth():Number
		{
			return panel.scroller.contentAreaWidth -2;
		}
		
		private function get contHeight():Number
		{
			return panel.scroller.contentAreaHeight -13 - _volumeBar.bounds.height;
		}
		
		private function onResize(e:ZvrComponentEvent):void 
		{
			
			var matrix:Matrix = new Matrix();
			matrix.scale(1 ,(Math.round(contHeight/3))/_bitmap.bitmapData.height);
			matrix.translate(contWidth - _bitmap.bitmapData.width, 0);
			
			var newBD:BitmapData = new BitmapData(contWidth, Math.round(contHeight/3), true, 0x00000000);
			newBD.draw(_bitmap.bitmapData, matrix, null, null, null, false);
			
			_bitmap.bitmapData = newBD;
			_bitmapL.y = contHeight / 3;
			
			_bitmapL.bitmapData = new BitmapData(contWidth, 1, true, 0x00000000);
			_bitmapL.height = contHeight / 3;
			_bitmapR.y = contHeight / 3 * 2;
			
			_bitmapR.bitmapData = new BitmapData(contWidth, 1, true, 0x00000000);
			_bitmapR.height = contHeight / 3;
		}
		
		private function enterFrame(e:Event):void 
		{
			
			ZvrSnd.updateChanels();
			
			var l:Array = ZvrSnd.left_spectrum;
			var r:Array = ZvrSnd.right_spectrum;
			
			var i:int

			var w:Number = contWidth;
			var h:Number = contHeight/3;
			var colW:Number = w / l.length;
			
			_bitmapL.bitmapData.applyFilter(_bitmapL.bitmapData , _bitmapL.bitmapData.rect, new Point(0, 0), _blur);
			_bitmapL.bitmapData.applyFilter(_bitmapL.bitmapData , _bitmapL.bitmapData.rect, new Point(0, 0), _colorFilter);
			_bitmapR.bitmapData.applyFilter(_bitmapR.bitmapData , _bitmapL.bitmapData.rect, new Point(0, 0), _blur);
			_bitmapR.bitmapData.applyFilter(_bitmapR.bitmapData , _bitmapL.bitmapData.rect, new Point(0, 0), _colorFilter);
			
			_bitmapTemp = _bitmapL.bitmapData.clone();
			
			for (i = 0; i < l.length; i++) 
			{		
				_bitmapTemp.fillRect(new Rectangle(colW * i, 0, colW, 1), ZvrColor.ARGBfromRGBandA(0xff0000, l[i]));
			}
			
			_bitmapL.bitmapData.draw(_bitmapTemp, null, null, BlendMode.SCREEN);
			
			_bitmapTemp = _bitmapR.bitmapData.clone();
			
			for (i = 0; i < r.length; i++) 
			{		
				_bitmapTemp.fillRect(new Rectangle(colW * i, 0, colW, 1), ZvrColor.ARGBfromRGBandA(0x0000ff, r[i]));
			}
			_bitmapR.bitmapData.draw(_bitmapTemp, null, null, BlendMode.SCREEN);
			
			_bitmap.bitmapData.scroll( -1, 0);
			_bitmap.bitmapData.fillRect(new Rectangle(w - 1, 0, 1, h), ZvrColor.ARGBfromRGBandA(ZvrColor.fadeHex(0xff0000, 0x0000ff, ZvrSnd.volume_right/(ZvrSnd.volume_right+ZvrSnd.volume_left)), (ZvrSnd.volume_left+ZvrSnd.volume_right)/2));
			
			var ah:Number = ZvrSnd.volume_left * (h / 2);
			_bitmap.bitmapData.fillRect(new Rectangle(w - 1, (h / 2) - ah, 1, ah), ZvrColor.ARGBfromRGBandA(0xff0000, ZvrSnd.volume_left));
			
			ah = ZvrSnd.volume_right * (h / 2);
			_bitmap.bitmapData.fillRect(new Rectangle(w - 1, (h / 2), 1, ah), ZvrColor.ARGBfromRGBandA(0x0000ff, ZvrSnd.volume_right));
			
		}
		
	}

}