package zvr.zvrGUI.components.g2d 
{
	import zvr.zvrG2D.G2DFont;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.skins.g2d.ZvrG2DFNTStyle;
	import zvr.zvrGUI.skins.g2d.ZvrG2DLabelSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DLabel extends ZvrG2DComponent
	{
		public function ZvrG2DLabel(font:G2DFont) 
		{
			super(ZvrG2DLabelSkin, ZvrG2DFNTBody);
			
			autoSize = ZvrAutoSize.CONTENT;
			
			setStyle(ZvrG2DFNTStyle.FONT, font);
			
		}
		
		override public function set maxWidth(value:Number):void 
		{
			super.maxWidth = value;
			ZvrG2DFNTBody(body).maxWidth = value;
		}
		
		public function get text():String 
		{
			return fntBody.text;
		}
		
		public function set text(value:String):void 
		{
			fntBody.text = value;
		}
		
		public function get editable():Boolean 
		{
			return ZvrG2DLabelSkin(skin).editable;
		}
		
		public function set editable(value:Boolean):void 
		{
			ZvrG2DLabelSkin(skin).editable = value;
		}
		
		public function get maxChars():Number 
		{
			return ZvrG2DLabelSkin(skin).maxChars;
		}
		
		public function set maxChars(value:Number):void 
		{
			ZvrG2DLabelSkin(skin).maxChars = value;
		}
		
		public function get fntBody():ZvrG2DFNTBody 
		{
			return ZvrG2DFNTBody(body);
		}
		
		
	}

}