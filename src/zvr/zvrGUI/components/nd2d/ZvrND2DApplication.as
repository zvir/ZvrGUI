package zvr.zvrGUI.components.nd2d 
{
	import flash.events.Event;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DApplication extends ZvrND2DContainer
	{
		
		//private var _pixelSharp:Boolean;
		
		public function ZvrND2DApplication() 
		{
			
			super(ZvrSkin, ZvrND2DBody); 
			
			if (node.stage)
			{
				addedToStage(null);
			}
			else
			{
				node.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			}
		}
		
		private function addedToStage(e:Event):void 
		{
			node.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			node.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			stageResize(null);
			node.stage.addEventListener(Event.RESIZE, stageResize);
		}
		
		protected function removedFromStage(e:Event):void 
		{
			node.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			node.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			node.stage.removeEventListener(Event.RESIZE, stageResize);
		}
		
		protected function stageResize(e:Event):void 
		{
			x = 0;
			y = 0;
			
			width = pixelSharp ? int(node.stage.stageWidth * 0.5) * 2 : node.stage.stageWidth;
			height = pixelSharp ? int(node.stage.stageHeight * 0.5) * 2 : node.stage.stageHeight;
		}

		override public function set pixelSharp(value:Boolean):void 
		{
			super.pixelSharp = value;
			node.stage && stageResize(null);
		}
	}

}