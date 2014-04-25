package clv.gui.g2d.components 
{
	import clv.gui.common.styles.TextStyle;
	import clv.gui.common.styles.TextStyleAlign;
	import clv.gui.g2d.core.SkinG2D;
	import com.genome2d.components.renderables.GSprite;
	import zvr.zvrG2D.text.GTextComponent;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class LabelSkinG2D extends SkinG2D
	{
		private var _label:GTextComponent;
		
		private var _autoSizeToText:Boolean;
		
		private var _sprite:GSprite;
		
		public function LabelSkinG2D() 
		{
			
		}
		
		override protected function registerStyles():void 
		{
			registerStyle(TextStyle.ALIGN				, setAlign);
			registerStyle(TextStyle.FONT				, setFont);
			registerStyle(TextStyle.SIZE				, setSize);
			registerStyle(TextStyle.COLOR				, setColor);
			registerStyle(TextStyle.LETTER_SPACING		, setLetterSpacing);
			registerStyle(TextStyle.LINE_SPACING		, setLineSpacing);
			registerStyle(TextStyle.AUTO_SIZE_TO_TEXT	, autoSizeToText);
		}
		
		override protected function setStyles():void 
		{
			setStyle(TextStyle.ALIGN			, TextStyleAlign.LEFT);
			setStyle(TextStyle.LETTER_SPACING	, 0);
			setStyle(TextStyle.LINE_SPACING		, 0);
			setStyle(TextStyle.AUTO_SIZE_TO_TEXT, true);
			setStyle(TextStyle.COLOR, 0xFFFFFF);
		}
		
		override protected function create():void 
		{
			super.create();
			
			_label = _skinNode.addComponent(GTextComponent) as GTextComponent;
			_label.onTextChanged.add(onTextChanged);
		}
		
		private function autoSizeToText():void 
		{
			_autoSizeToText = getStyle(TextStyle.AUTO_SIZE_TO_TEXT);
			
			if (_autoSizeToText)
			{
				_label.maxWidth = Number.MAX_VALUE;
			}
			else
			{
				_label.maxWidth = _component.width;
			}
			
		}
		
		private function setLineSpacing():void 
		{
			_label.lineSpacing = getStyle(TextStyle.LINE_SPACING);
		}
		
		private function setLetterSpacing():void 
		{
			_label.letterSpacing = getStyle(TextStyle.LETTER_SPACING);
		}
		
		private function setFont():void 
		{
			_label.font = getStyle(TextStyle.FONT);
		}
		
		private function setAlign():void 
		{
			var a:String =  getStyle(TextStyle.ALIGN);
			
			switch (a) 
			{
				case TextStyleAlign.LEFT: 	_label.align = 1; break;
				case TextStyleAlign.RIGHT: 	_label.align = -1; break;
				case TextStyleAlign.CENTER: _label.align = 0; break;
			}
			
		}
		
		private function setSize():void 
		{
			_label.size = getStyle(TextStyle.SIZE);
		}
		
		private function setColor():void 
		{
			var c:* = getStyle(TextStyle.COLOR);
			_skinNode.transform.color = uint(c);
		}
		
		private function onTextChanged(s:String):void 
		{
			if (_autoSizeToText)
			{
				_component.width = _label.width;
				_component.height = _label.height;
			}
		}
		
		override public function preUpdate():void
		{
			if (_autoSizeToText)
			{
				_label.update();
				if (_component.width != _label.width) _component.width = _label.width;
				if (_component.height != _label.height) _component.height = _label.height;
			}
			else
			{
				if (_label.maxWidth != _component.bounds.width) 
				{
					_label.maxWidth = _component.bounds.width;
				}
				_label.update();
			}
		}
		
		override public function updateBounds():void 
		{
			super.updateBounds();
			
			_componentBody.x = int(_component.bounds.x);
			_componentBody.y = int(_component.bounds.y);
			
		}
		
		public function set text(v:String):void
		{
			_label.text = v;
		}
		
		public function get text():String
		{
			return _label.text;
		}
		
		public function get maxChars():Number 
		{
			return _label.maxChars;
		}
		
		public function set maxChars(value:Number):void 
		{
			_label.maxChars = value;
		}
		
		public function get label():GTextComponent 
		{
			return _label;
		}
	}

}