package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.geom.Rectangle;
	import zvr.ZvrVirtualTextfield;
	import zvr.ZvrVirtualTextfieldEvent;
	/**
	 * ...
	 * @author Zvir
	 */
	public class FNTDynamicSprite extends FNTSprite
	{
		
		private var virt:ZvrVirtualTextfield;
		private var carret:Sprite2D;
		private var counter:int;
		
		
		public function FNTDynamicSprite(textureObject:Texture2D) 
		{
			super(textureObject);
			
			virt = new ZvrVirtualTextfield();
			carret = new Sprite2D();	
			//addChild(carret);	
			
			virt.addEventListener(ZvrVirtualTextfieldEvent.TEXT_CHANGE, textChange);
			virt.addEventListener(ZvrVirtualTextfieldEvent.CARRET_INDEX_CHAGE, carretChange);
			virt.addEventListener(ZvrVirtualTextfieldEvent.ACTIVE_CHANGE, activChanged);
		}
		
		
		override public function setSpriteSheet(value:ASpriteSheetBase):void 
		{
			super.setSpriteSheet(value);
		}
		
		
		override public function textChanged():void 
		{
			if (virt.active) removeChild(carret);
			
			super.textChanged();
			
			if (virt.active && spriteSheet) 
			{
				addChild(carret);
			}
			
		}
		
		
		private function updateCatter():void
		{
			
			if (!spriteSheet) return;
			
			var fntSpriteSheet:FNTSpriteSheet = FNTSpriteSheet(spriteSheet);
				
			carret.setFrameByName("124");

			var lastSpriteX:Number = virt.carretIndex < 1 ? 0 : virt.carretIndex ;
			carret.x = lettersX[lastSpriteX] + 1; 
			
			carret.y = int(fntSpriteSheet.lineHeight / 2) + 1;
			
			if (virt.active && spriteSheet) 
			{
				addChild(carret);
			}
		}
		
		override protected function step(elapsed:Number):void 
		{
			super.step(elapsed);
			
			if (virt.active)
			{
				counter++;
				carret.visible = int(counter / 10) % 2 == 0;
				
				if (!carret.parent || (spriteSheet && carret.spriteSheet.frame != 92))
				{
					addChild(carret);
					updateCatter();
				}
			}
			
		}
		
		private function carretChange(e:ZvrVirtualTextfieldEvent):void 
		{
			updateCatter();
		}
		
		override public function get text():String 
		{
			return super.text;
		}
		
		override public function set text(value:String):void 
		{
			super.text = value;
			virt.setText(value);
		}
		
		private function textChange(e:ZvrVirtualTextfieldEvent):void 
		{
			_text = e.textField.text;
			_textChanged = true;
			textChanged();
		}
		
		private function activChanged(e:ZvrVirtualTextfieldEvent):void 
		{
			if (virt.active) 
			{
				counter = 0;
				_textChanged = true;
				textChanged();
				updateCatter();
			}
			else
			{
				removeChild(carret);
			}
			
		}
		
		public function set edit(v:Boolean):void
		{
			if (v) virt.activate(); else virt.deactivate();
		}
		
		public function set carretIndex(v:int):void
		{
			virt.setCarretIndex(v);
		}
		
		public function get maxChars():int
		{
			return virt.maxChars;
		}
		
		public function set maxChars(value:int):void 
		{
			virt.maxChars = value;
		}
		
	}

}