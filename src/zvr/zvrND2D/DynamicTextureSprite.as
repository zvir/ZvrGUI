package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import flash.events.Event;
	/**
	 * ...
	 * @author Zvir
	 */
	public class DynamicTextureSprite extends Sprite2D
	{
		private var dynamicTexture:DynamicTexture;
		
		public function DynamicTextureSprite(dynamicTexture:DynamicTexture) 
		{
			this.dynamicTexture = dynamicTexture;
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
		}
		
		private function addedToStage(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			dynamicTexture.addSprite(this);
			
		}
		
		private function removedFromStage(e:Event):void 
		{
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			dynamicTexture.removeSprite(this);
			
		}
		
		override public function dispose():void 
		{
			super.dispose();
			removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			dynamicTexture.removeSprite(this);
		}
	}

}