package zvr.zvrGUI.skins.zvrMinimalDark 
{
	import flash.display.Sprite;
	import zvr.zvrGUI.behaviors.ZvrBehaviors;
	import zvr.zvrGUI.behaviors.ZvrBringToFrontBehavior;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.behaviors.ZvrRollOverHilight;
	import zvr.zvrGUI.components.minimalDark.TestPanel;
	import zvr.zvrGUI.core.ZvrComponent;
	import zvr.zvrGUI.core.ZvrStates;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class TestPanelSkin extends ZvrSkin 
	{
		
		public function TestPanelSkin(component:ZvrComponent, registration:Function) 
		{
			super(component, registration);
			_availbleBehaviors = [ZvrDragable, ZvrResizable, ZvrRollOverHilight, ZvrBringToFrontBehavior];
			
		}
		
		override protected function create():void
		{
			_body = new Sprite();
			drawBackground();
			_component.behaviors.addBehavior(ZvrBehaviors.get(ZvrBehaviors.DRAGABLE));
		}
		
		override protected function updateSize():void
		{
			drawBackground();
		}
		
		private function drawBackground():void 
		{
			sprite.graphics.clear();
			sprite.graphics.beginFill(0x64ADFF, 0.5);
			sprite.graphics.drawRect(0, 0, componentWidth, componentHeight);
		}
		
		private function get sprite():Sprite
		{
			return _body as Sprite;
		}
		
		private function get panel():TestPanel
		{
			return _component as TestPanel;
		}
	}

}