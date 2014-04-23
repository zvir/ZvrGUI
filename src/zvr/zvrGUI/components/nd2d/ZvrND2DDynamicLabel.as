package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.events.Event;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DDynamicLabelSkin;
	import zvr.zvrGUI.skins.nd2d.ZvrND2DFNTStyle;
	import zvr.zvrND2D.FNTSpriteSheet;
	/**
	 * ...
	 * @author Zvir
	 */
	[Event(name = "change", type = "flash.events.Event")] 
	
	public class ZvrND2DDynamicLabel extends ZvrND2DComponent 
	{
		private var _text:String;
		
		public function ZvrND2DDynamicLabel(fntTexture:Texture2D = null, fntSpriteSheet:FNTSpriteSheet = null)
		{
			super(ZvrND2DDynamicLabelSkin, ZvrND2DFNTDynamicBody);
			
			ZvrND2DFNTDynamicBody(body).addEventListener(Event.CHANGE, textChange);
			
			setStyle(ZvrND2DFNTStyle.FONT_TEXTURE, fntTexture);
			setStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, fntSpriteSheet);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.FOCUSED);
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
		
		private function textChange(e:Event):void 
		{
			dispatchEvent(e.clone());
		}
		
		public function get text():String 
		{
			return fntBody.text;
		}
		
		public function set text(value:String):void 
		{
			fntBody.text = value;
		}
		
		public function get fntSkin():ZvrND2DDynamicLabelSkin
		{
			return _skin as ZvrND2DDynamicLabelSkin;
		}
		
		public function get fntBody():ZvrND2DFNTDynamicBody
		{
			return _body as ZvrND2DFNTDynamicBody;
		}
		
		public function get lines():int
		{
			return fntBody.lines;
		}
		
		public function get maxChars():int 
		{
			return fntSkin.maxChars;
		}
		
		public function set maxChars(value:int):void 
		{
			fntSkin.maxChars = value;
		}
		
	}

}