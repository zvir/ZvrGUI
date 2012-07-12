package zvr.zvrGUI.components.minimalDark 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrContainer;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrLabelChangeKind;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.events.ZvrSliderEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.skins.zvrMinimalDark.InputSkinMD;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ColorPickerMD extends ZvrContainer
	{
		
		private var _r:Number;
		private var _g:Number;
		private var _b:Number;
		private var _a:Number;
		
		private var _redLabel	:InputMD;
		private var _greenLabel	:InputMD;
		private var _blueLabel	:InputMD;
		private var _alphaLabel	:InputMD;
		
		private var _redSlider		:SliderMD;
		private var _greenSlider	:SliderMD;
		private var _blueSlider		:SliderMD;
		private var _alphaSlider	:SliderMD;
		private var _inputs:ZvrGroup;
		
		private var _colorSample:Sprite;
		
		private var _bitmapData:BitmapData = new BitmapData(1, 1);
		private const matrix:Matrix = new Matrix();
		private const clipRect:Rectangle = new Rectangle(0, 0, 1, 1);
		
		
		public function ColorPickerMD() 
		{
			
			super(InputSkinMD);
			
			minWidth = 150;
			minHeight = 30;
			
			autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			
			//setLayout(ZvrVerticalLayout);
			
			_inputs = new ZvrGroup();
			addChild(_inputs);
			_inputs.autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			_inputs.left = 40;
			_inputs.right = 0;
			
			_redLabel	= new InputMD();
			_greenLabel = new InputMD();
			_blueLabel	= new InputMD();
			_alphaLabel = new InputMD();
			
			_redSlider		= new SliderMD();
			_greenSlider	= new SliderMD();
			_blueSlider		= new SliderMD();
			_alphaSlider	= new SliderMD();
			
			configureInput(_redLabel)	
			configureInput(_greenLabel);
			configureInput(_blueLabel);
			configureInput(_alphaLabel);
			
			_inputs.addChild(_redSlider);
			_inputs.addChild(_greenSlider);
			_inputs.addChild(_blueSlider);
			_inputs.addChild(_alphaSlider);
			
			_redSlider.max = 255;
			_greenSlider.max = 255;
			_blueSlider.max = 255;
			_alphaSlider.max = 255;
			
			addSliderEvents();
			
			_inputs.addEventListener(ZvrComponentEvent.RESIZE, resize)
			resize(null);
			
			_redSlider.y = 14;
			_greenSlider.y = 14;
			_blueSlider.y = 14;
			_alphaSlider.y = 14;
			
			_colorSample = new Sprite();
			
			addChild(_colorSample);
			
			_colorSample.x = 3;
			_colorSample.y = 3;
			
			updateSample();
			
			_colorSample.addEventListener(MouseEvent.MOUSE_DOWN, colorSampleMouseDown);
			
			color32 = 0xFF043129;
		}
		
		private function colorSampleMouseDown(e:MouseEvent):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseUp);
			_alphaSlider.position = 255;
		}
		
		private function mouseUp(e:MouseEvent):void 
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, mouseUp);
		}
		
		private function mouseMove(e:MouseEvent):void 
		{
			matrix.setTo(1, 0, 0, 1, -stage.mouseX, -stage.mouseY)
			_bitmapData.draw(stage, matrix, null, null, clipRect);
			color24 = _bitmapData.getPixel(0, 0);
		}
		
		private function updateSample():void 
		{
			_colorSample.graphics.clear();
			_colorSample.graphics.beginFill(color24, alphaValue);
			_colorSample.graphics.drawRect(0, 0, 32, 24);
			_colorSample.graphics.endFill();
			
			dispatchEvent(new Event(Event.CHANGE));
			
		}
		
		private function resize(e:ZvrComponentEvent):void 
		{
			var s:Number = _inputs.childrenAreaWidth / 4;
			
			_redSlider.x = 0;
			_greenSlider.x = s;
			_blueSlider.x = s * 2;
			_alphaSlider.x = s * 3;
			
			_redSlider.width = s - 10;
			_greenSlider.width  = s - 10;
			_blueSlider.width 	 = s - 10;
			_alphaSlider.width  = s - 10;
			
			_redLabel.x = 0;
			_greenLabel.x = s;
			_blueLabel.x = s * 2;
			_alphaLabel.x = s * 3;
			
		}
		
		private function configureInput(i:InputMD):void
		{
			var t:TextField = LabelMDSkin(i.skin).textField;
			
			t.maxChars =  3;
			t.restrict = "1234567890";
			
			i.addEventListener(ZvrLabelEvent.TEXT_CHANGE, textChange);
			i.addEventListener(ZvrStateChangeEvent.CHANGE, inputStateChange);
			
			_inputs.addChild(i);
			
			i.labelAutoSize = false;
			i.height = 15;
			i.width = 32;
			i.top = -2;
		}
		
		private function textChange(e:ZvrLabelEvent):void 
		{
			
			if (e.kind != ZvrLabelChangeKind.INPUT) return;
			
			removeSliderEvents();
			
			switch (e.component) 
			{
				case _redLabel		: _r = int(_redLabel.text) ;	_redSlider.position		= _r;	break;
				case _greenLabel	: _g = int(_greenLabel.text);	_greenSlider.position	= _g; 	break;
				case _blueLabel		: _b = int(_blueLabel.text);	_blueSlider.position	= _b; 	break;
				case _alphaLabel	: _a = int(_alphaLabel.text);	_alphaSlider.position	= _a; 	break;
			}
			
			
			addSliderEvents();
			
			updateSample();
		}
		
		private function sliderPositionChange(e:ZvrSliderEvent):void 
		{
			switch (e.slider) 
			{
				case _redSlider		: _r = int(_redSlider.position) ;		_redLabel.text		= String(_r);	break;
				case _greenSlider	: _g = int(_greenSlider.position);		_greenLabel.text 	= String(_g); 	break;
				case _blueSlider	: _b = int(_blueSlider.position);		_blueLabel.text 	= String(_b); 	break;
				case _alphaSlider	: _a = int(_alphaSlider.position);		_alphaLabel.text 	= String(_a); 	break;
			}
			updateSample();
		}
		
		private function inputStateChange(e:ZvrStateChangeEvent):void 
		{
			if (!e.isRemoved(ZvrStates.FOCUSED)) return;
			
			switch (e.component) 
			{
				case _redLabel		: _redLabel.text	=  String(_redSlider.position);		break;
				case _greenLabel	: _greenLabel.text 	=  String(_greenSlider.position);	break;
				case _blueLabel		: _blueLabel.text 	=  String(_blueSlider.position);	break;
				case _alphaLabel	: _alphaLabel.text 	=  String(_alphaSlider.position);	break;
			}
			updateSample();
		}
		
		private function addSliderEvents():void
		{
			_redSlider.addEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_greenSlider.addEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_blueSlider.addEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_alphaSlider.addEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
		}
		
		private function removeSliderEvents():void
		{
			_redSlider.removeEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_greenSlider.removeEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_blueSlider.removeEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
			_alphaSlider.removeEventListener(ZvrSliderEvent.POSITION_CHANGED, sliderPositionChange);
		}
		
		public function set color24(v:uint):void
		{
			_redSlider.position = v >> 16 & 0xFF;
			_greenSlider.position = v >> 8 & 0xFF;
			_blueSlider.position = v & 0xFF;
		}
		
		public function set color32(v:uint):void
		{
			_alphaSlider.position = v >> 24 & 0xFF;
			_redSlider.position = v >> 16 & 0xFF;
			_greenSlider.position = v >> 8 & 0xFF;
			_blueSlider.position = v & 0xFF;
		}
		
		public function get color24():uint
		{
			return (_r << 16) | (_g << 8) | _b;
		}
		
		public function get color32():uint
		{
			return (_a << 24) | (_r << 16) | (_g << 8) | _b;
		}
		
		public function get alphaValue():Number
		{
			return _a/255;
		}
		
		public function get r():Number 
		{
			return _r;
		}
		
		public function get g():Number 
		{
			return _g;
		}
		
		public function get b():Number 
		{
			return _b;
		}
		
		public function get a():Number 
		{
			return _a;
		}
		
	}

}