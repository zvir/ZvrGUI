package clv.gui.core 
{
	import clv.gui.core.skins.Skin;
	import clv.gui.core.skins.SkinContainer;
	import flash.display.Stage;
	import flash.geom.Rectangle;
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author ...
	 */
	public class Application extends Container
	{
		
		public var updates:int;
		
		public var pointer:PointerManager = new PointerManager();
		
		public var pixelSharp:Boolean = true;
		
		public var stage:Stage;
		
		public function Application(skin:SkinContainer) 
		{
			super(skin);
			
			pointer = new PointerManager();
			
			_app = this;
		}
		
		public function updateApp(x:Number, y:Number, width:Number, height:Number):void
		{
			updates = 0;
			
			if (pixelSharp)
			{
				width = Math.floor(width / 2) * 2;
				height = Math.floor(height / 2) * 2;
			}
			
			if (x != this.x) this.x = x;
			if (y != this.y) this.y = y;
			
			
			if (width != this.width) this.width = width;
			if (height != this.height) this.height = height;
			
			prepareForUpdate();
			
			update(new Rectangle(0, 0, width, height));
			
			//trace(updates);
			
		}
	}

}