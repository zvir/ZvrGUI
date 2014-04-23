package zvr.zvrGUI.skins.g2d 
{
	import com.genome2d.signals.GNodeMouseSignal;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.components.g2d.ZvrG2DFNTBody;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrKeyboard.ZvrInputSignal;
	import zvr.zvrKeyboard.ZvrInputTextField;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DLabelSkin extends ZvrSkin
	{
		private var _autoSize:Boolean = true;
		
		private var _editable:Boolean;
		
		private var fnt:ZvrG2DFNTBody;
		
		public function ZvrG2DLabelSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function registerStyles():void 
		{
			super.registerStyles();
			
			registerStyle(ZvrG2DFNTStyle.FONT, setFont);
			registerStyle(ZvrG2DFNTStyle.FONT_COLOR, setFontColor);
			registerStyle(ZvrG2DFNTStyle.FONT_SPACING, setFontSpacing);
			registerStyle(ZvrG2DFNTStyle.FONT_LINE_HEIGHT, setLineHeight);
			registerStyle(ZvrG2DFNTStyle.FONT_ALIGN, setAlign);
			registerStyle(ZvrG2DFNTStyle.FONT_SIZE, setFontSize);
		}
		
		private function setLineHeight():void 
		{
			fnt.lineSpacing = getStyle(ZvrG2DFNTStyle.FONT_LINE_HEIGHT);
		}
		
		private function setAlign():void 
		{
			fnt.align = getStyle(ZvrG2DFNTStyle.FONT_ALIGN);
		}
		
		private function setFontSpacing():void 
		{
			fnt.spacing = getStyle(ZvrG2DFNTStyle.FONT_SPACING);
		}
		
		private function setFontColor():void 
		{
			//fnt.tint = getStyle(ZvrG2DFNTStyle.FONT_COLOR);
			fnt.transform.color = getStyle(ZvrG2DFNTStyle.FONT_COLOR);
		}
		
		private function setFont():void 
		{
			fnt.font = getStyle(ZvrG2DFNTStyle.FONT);
		}
		
		override protected function create():void 
		{
			_body = IZvrSkinLayer(_component.body);
			fnt = _body as ZvrG2DFNTBody;
			fnt.onTextChanged.add(change);
		}
		
		public function focusIn():void
		{
			trace("focusIn");
			
			fnt.inputBegin();
			fnt.caretIndex = fnt.text.length;
			/*
			ZvrInputTextField.begin(fnt.core.stage, fnt.text, fnt.caretIndex, fnt.caretIndex, true);
			ZvrInputTextField.onChange.add(textChangeSignal);
			ZvrInputTextField.maxChars = maxChars;
			ZvrInputTextField.multiline = false;*/
			
			fnt.onMouseDown.add(setSelectionMouse);
			
			fnt.onMouseOutside.add(mosueOutsideSignal);
			
		}
		
		private function startInput(e:GNodeMouseSignal):void 
		{
			
			trace("startInput");
			
			var index:int = fnt.getCharIndexAt(e.localX, e.localY);
			
			fnt.inputBegin();
			fnt.caretIndex = index;
			/*
			ZvrInputTextField.begin(fnt.core.stage, fnt.text, index, index, true);
			ZvrInputTextField.onChange.add(textChangeSignal);
			ZvrInputTextField.maxChars = maxChars;
			ZvrInputTextField.multiline = false;
			*/
			fnt.onMouseDown.add(setSelectionMouse);
			
			fnt.onMouseOutside.add(mosueOutsideSignal);
			
		}
		
		private function change(s:String):void 
		{
			switch (_component.autoSize) 
			{
				case ZvrAutoSize.CONTENT:
					updateComponentSize(fnt.width, fnt.height);
				break;
				case ZvrAutoSize.CONTENT_WIDTH:
					updateComponentSize(fnt.width, componentHeight);
				break;
				case ZvrAutoSize.CONTENT_HEIGHT:
					updateComponentSize(componentWidth, fnt.height);
				break;
				
				default:
			}
		}
		
		private function setFontSize():void 
		{
			fnt.fontSize = getStyle(ZvrG2DFNTStyle.FONT_SIZE);
		}
		
		private function textChangeSignal(e:ZvrInputSignal):void 
		{
			fnt.text = e.text;
			fnt.caretIndex = e.selectionBegin;
		}
		
		private function setSelectionMouse(e:GNodeMouseSignal):void 
		{
			var index:int = fnt.getCharIndexAt(e.localX, e.localY);
			ZvrInputTextField.setSelection(index, index);
		}
		
		private function mosueOutsideSignal(e:GNodeMouseSignal):void 
		{
			if (e.type == "OUTSIDE_" + MouseEvent.MOUSE_DOWN)
			{
				
				trace("OUTSIEDE CLICK");
				
				ZvrInputTextField.end();
				ZvrInputTextField.onChange.remove(textChangeSignal);
				fnt.onMouseDown.remove(setSelectionMouse);
				fnt.onMouseOutside.remove(mosueOutsideSignal);
				fnt.inputEnd();
				if (_editable) fnt.onMouseDown.addOnce(startInput);
			}
		}
		
		public function get editable():Boolean 
		{
			return _editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			if (_editable == value) return;
			
			_editable = value;
			
			if (_editable)
			{
				fnt.mouseEnabled = true;
				fnt.onMouseDown.addOnce(startInput);
			}
			else
			{
				fnt.onMouseDown.remove(startInput);
			}
			
		}
		
		public function get maxChars():Number 
		{
			return fnt.maxChars;
		}
		
		public function set maxChars(value:Number):void 
		{
			fnt.maxChars = value;
		}
		
	}

}