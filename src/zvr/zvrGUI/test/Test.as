/**
 * Created by IntelliJ IDEA.
 * User: Zvir
 * Date: 24.10.12
 * Time: 23:13
 * To change this template use File | Settings | File Templates.
 */
package zvr.zvrGUI.test
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;

	import zvr.zvrGUI.core.flash.ZvrFlashComponent;
	import zvr.zvrGUI.core.flash.ZvrFlashContainer;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TestSkin;

	[SWF(width='1440',height='900',backgroundColor='#000000',frameRate='60')]
	public class Test extends Sprite
	{
		public function Test()
		{

			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
			
			

		}

		private function init(e:Event = null):void
		{

			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;


			var c:ZvrFlashContainer = new ZvrFlashContainer(TestSkin);

			addChild(c);
			
			c.x = 100;
			c.y = 100;
			
			c.width = 100;
			c.height = 100;


			
			var o:ZvrFlashComponent;
			o = new ZvrFlashComponent(TestSkin);
			o.setStyle(ZvrStyles.BG_COLOR, 0x0000ff);

			o.width = 20;
			o.height = 20;

			o.x = 0;
			o.y = 0;

			c.addComponent(o);

			o = new ZvrFlashComponent(TestSkin);
			o.setStyle(ZvrStyles.BG_COLOR, 0x0000ff);

			o.width = 20;
			o.height = 20;

			o.x = 0;
			o.y = 0;

			c.addComponent(o);

			o = new ZvrFlashComponent(TestSkin);
			o.setStyle(ZvrStyles.BG_COLOR, 0x0000ff);

			o.width = 20;
			o.height = 20;

			o.x = 0;
			o.y = 0;

			c.addComponent(o);
			
			c.setLayout(ZvrHorizontalLayout);
			
			trace(o.width, o.height, o.scaleX, o.scaleY);
			
		}
	}
}
