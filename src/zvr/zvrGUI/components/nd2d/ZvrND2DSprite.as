package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import flash.display.Sprite;
	import zvr.zvrGUI.core.custom.ZvrComponentBase;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DSprite extends ZvrComponentBase implements IZvrND2DComponent
	{	
		
		public function ZvrND2DSprite() 
		{
			super(ZvrSkin, ZvrND2DSprite2DBody);
			
			minWidth = 2;
			minHeight = 2;
			
		}
		
		public function update():void
		{
			if (sprite.spriteSheet)
			{
				width = sprite.spriteSheet.sourceWidth;
				height = sprite.spriteSheet.sourceHeight;
			}
			
			setSuperPosition(_rect.x, _rect.y);
		}
		
		override protected function setSuperPosition(x:Number, y:Number):void 
		{
			//super.setSuperPosition(x, y);
			
			if (sprite.spriteSheet)
			{
				_body.x = x + int(Sprite2D(_body).spriteSheet.sourceWidth  /2);
				_body.y = y + int(Sprite2D(_body).spriteSheet.sourceHeight /2);
			}
			else
			{
				_body.x = x +  Sprite2D(_body).width >> 1;
				_body.y = y +  Sprite2D(_body).height >> 1;
			}
		}
		
		public function get node():Node2D
		{
			return Node2D(body);
		}
		
		public function get sprite():Sprite2D
		{
			return Sprite2D(body);
		}
	}

}