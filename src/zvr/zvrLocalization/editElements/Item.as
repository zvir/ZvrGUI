package zvr.zvrLocalization.editElements 
{
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.core.IZvrSimpleDataItem;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrLocalization.ZvrLocItem;
	/**
	 * ...
	 * @author Zvir
	 */
	public class Item extends ZvrGroup implements IZvrSimpleDataItem
	{
		
		private var _name:LabelMD = new LabelMD();
		private var _text:LabelMD = new LabelMD();
		private var _button:ButtonMD = new ButtonMD();
		
		private var _item:ZvrLocItem;
		
		public function Item() 
		{
			percentWidth = 100;
			height = 40;
			
			childrenPadding.padding = 3;
			_text.top = 0;
			_text.maxWidth = 200;
			_text.labelAutoSize = false;
			_text.height = 20;
			_text.right = 20;
			_text.left = 0;
			_text.cutLabel = true;
			_text.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Monaco);
			_text.setStyle(ZvrStyles.LABEL_FONT_SIZE, 14);
			
			
			_name.bottom = 0;
			
			_button.bottom = 0;
			_button.right = 0;
			_button.label.text = "edit";
			_button.contentPadding.padding = 2;
			
			addChild(_text);
			addChild(_name);
			addChild(_button);
			
		}
		
		public function set item(i:ZvrLocItem):void
		{
			_item = i;
			
			if (!_item) 
			{
				visible = false;
				return;
			}
			
			visible = true;
			
			_name.text = _item.name;
			_text.text = _item.text;
			
		}
		
		public function get item():ZvrLocItem 
		{
			return _item;
		}
		
	}

}