package zvr.zvrGUI.skins.nd2d 
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.components.nd2d.ZvrND2DFNTDynamicBody;
	import zvr.zvrGUI.core.IZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DDynamicLabelSkin extends ZvrSkin 
	{
		
		private var fnt:ZvrND2DFNTDynamicBody;
		
		public function ZvrND2DDynamicLabelSkin(component:IZvrComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function registerStyles():void 
		{
			super.registerStyles();
			
			registerStyle(ZvrND2DFNTStyle.FONT_TEXTURE, setFntTexture);
			registerStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET, setFntSpriteSheet);
			registerStyle(ZvrND2DFNTStyle.FONT_COLOR, setFontColor);
			registerStyle(ZvrND2DFNTStyle.FONT_SPACING, setFontSpacing);
			registerStyle(ZvrND2DFNTStyle.FONT_LINE_HEIGHT, setLineHeight);
			registerStyle(ZvrND2DFNTStyle.FONT_ALIGN, setAlign);
			registerStyle(ZvrND2DFNTStyle.EDIT, setEdit);
		}
		
		override protected function setStyles():void 
		{
			super.setStyles();
			
			setStyle(ZvrND2DFNTStyle.EDIT, true, [ZvrStates.FOCUSED]);
			setStyle(ZvrND2DFNTStyle.EDIT, false);
			
		}
		
		private function setLineHeight():void 
		{
			fnt.lineHeight = getStyle(ZvrND2DFNTStyle.FONT_LINE_HEIGHT);
		}
		
		private function setAlign():void 
		{
			fnt.align = getStyle(ZvrND2DFNTStyle.FONT_ALIGN);
		}
		
		private function setFontSpacing():void 
		{
			fnt.spacing = getStyle(ZvrND2DFNTStyle.FONT_SPACING);
		}
		
		private function setFontColor():void 
		{
			fnt.tint = getStyle(ZvrND2DFNTStyle.FONT_COLOR);
		}
		
		private function setFntTexture():void 
		{
			fnt.texture = getStyle(ZvrND2DFNTStyle.FONT_TEXTURE);
		}
		
		private function setFntSpriteSheet():void 
		{
			fnt.setSpriteSheet(getStyle(ZvrND2DFNTStyle.FONT_SPRITESHEET));
		}
		
		override protected function create():void 
		{
			_body = IZvrSkinLayer(_component.body);
			fnt = _body as ZvrND2DFNTDynamicBody;
			fnt.addEventListener(Event.CHANGE, change);
			
			fnt.mouseEnabled = true;
			
			fnt.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			fnt.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		private function setEdit():void 
		{
			var e:Boolean = getStyle(ZvrND2DFNTStyle.EDIT);
			
			fnt.edit = e;
			
			if (e)
			{
				fnt.stage.addEventListener(MouseEvent.CLICK, stageClick);
			}
			else
			{
				fnt.stage.removeEventListener(MouseEvent.CLICK, stageClick);
			}
			
		}
		
		private function addedToStage(e:Event):void 
		{
			fnt.addEventListener(MouseEvent.CLICK, click);
		}
		
		private function removedFromStage(e:Event):void 
		{
			_component.removeState(ZvrStates.FOCUSED);
			fnt.removeEventListener(MouseEvent.CLICK, click);
			fnt.stage.removeEventListener(MouseEvent.CLICK, stageClick);
		}
		
		private function click(e:MouseEvent):void 
		{
			if (!_component.checkState(ZvrStates.FOCUSED))
			{
				_component.addState(ZvrStates.FOCUSED);
			}
			
			for (var i:int = 0; i < fnt.lettersX.length - 1; i++) 
			{
				if (fnt.mouseX > fnt.lettersX[i] && fnt.mouseX < fnt.lettersX[i + 1])
				{
					break;
				}
			}
			fnt.carretIndex = i;
		}
		
		private function stageClick(e:MouseEvent):void 
		{
			if (!fnt.mouseIn())
			{
				_component.removeState(ZvrStates.FOCUSED);
				fnt.stage.removeEventListener(MouseEvent.CLICK, stageClick);
			}
		}
		
		private function change(e:Event):void 
		{
			updateComponentSize(fnt.width, fnt.height);
		}
		
		public function get maxChars():int
		{
			return fnt.maxChars;
		}
		
		public function set maxChars(value:int):void 
		{
			fnt.maxChars = value;
		}
		
	}

}