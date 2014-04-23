package zvr.zvrGUI.components.g2d 
{
	import flash.events.Event;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DApplication extends ZvrG2DContainer
	{
		
		//private var _pixelSharp:Boolean;
		
		private var _applicationRect:Rectangle
		
		public function ZvrG2DApplication() 
		{
			
			super(ZvrSkin, ZvrG2DBody); 
			
			if (body.stage)
			{
				addedToStage();
			}
			else
			{
				node.onAddedToStage.addOnce(addedToStage);
			}
			
		}
		
		public function updateToStage():void 
		{
			//applicationRect = new Rectangle( -body.stage.stageWidth * 0.5, - (body.stage.stageHeight) * 0.5, body.stage.stageWidth, body.stage.stageHeight - body.stage.softKeyboardRect.height);
			applicationRect = new Rectangle( 0, 0, body.stage.stageWidth, body.stage.stageHeight - body.stage.softKeyboardRect.height);
		}
		
		private function addedToStage():void 
		{
			node.onRemovedFromStage.addOnce(removedFromStage);
			stageResize(null);
			body.stage.addEventListener(Event.RESIZE, stageResize);
		}
		
		protected function removedFromStage():void 
		{
			node.onAddedToStage.addOnce(addedToStage);
			body.stage.removeEventListener(Event.RESIZE, stageResize);
		}
		
		protected function stageResize(e:Event):void 
		{
			updateToStage();
		}

		override public function set pixelSharp(value:Boolean):void 
		{
			super.pixelSharp = value;
			body.stage && stageResize(null);
		}
		
		public function get applicationRect():Rectangle 
		{
			return _applicationRect;
		}
		
		public function set applicationRect(value:Rectangle):void 
		{
			_applicationRect = value;
			
			x = _applicationRect.x - _applicationRect.width/2;
			y = _applicationRect.y - _applicationRect.height/2;
			
			width = pixelSharp ? int(_applicationRect.width * 0.5) * 2 : _applicationRect.width;
			height = pixelSharp ? int(_applicationRect.height * 0.5) * 2 : _applicationRect.height;
			
		}
	}

}