package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.events.MouseEvent;
	import org.osflash.signals.Signal;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DFNTStyle;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DLabelSkin;
	import zvr.zvrKeyboard.ZvrKeyboard;
	import zvr.zvrLocalization.IZvrLocEditLabel;
	import zvr.zvrND2D.FNTSpriteSheet;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DLabel extends ZvrND2DComponent implements IZvrLocEditLabel
	{
		private var _text:String;
		
		private var _onEdit:Signal = new Signal(IZvrLocEditLabel);
		
		public function ZvrND2DLabel(fntTexture:Texture2D = null, fntSpriteSheet:FNTSpriteSheet = null)
		{
			super(ZvrND2DLabelSkin, ZvrND2DFNTBody);
			
			setStyle(ZvrND2DFNTStyle.FONT_TEXTURE, fntTexture);
			setStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, fntSpriteSheet);
			
			CONFIG::debug
			{
				node.addEventListener(MouseEvent.CLICK, nd2dClick);
				node.mouseEnabled = true;
			}
		}
		
		CONFIG::debug
		private function nd2dClick(e:MouseEvent):void 
		{
			if (ZvrKeyboard.CTRL.pressed)
				_onEdit.dispatch(this);
		}
		
		override public function get maxWidth():Number 
		{
			return super.maxWidth;
		}
		
		override public function set maxWidth(value:Number):void 
		{
			super.maxWidth = value;
			ZvrND2DFNTBody(body).maxWidth = value;
		}
		
		public function setFont(t:Texture2D, s:FNTSpriteSheet):void
		{
			setStyle(ZvrND2DFNTStyle.FONT_TEXTURE, t);
			setStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, s);
		}
		
		/* INTERFACE zvr.zvrLocalization.IZvrLocEditLabel */
		
		public function get onEdit():Signal 
		{
			return _onEdit;
		}
		
		public function get text():String 
		{
			return fntBody.text;
		}
		
		public function set text(value:String):void 
		{
			fntBody.text = value;
		}
		
		public function get fntBody():ZvrND2DFNTBody
		{
			return _body as ZvrND2DFNTBody;
		}
		
		public function get lines():int
		{
			return fntBody.lines;
		}
		
	}

}