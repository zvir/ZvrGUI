package zvr.maxRect 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;

	[SWF(backgroundColor="#ffffff", frameRate="60", width="1024", height="1024")]

	public class MaxRectTest extends Sprite
	{
		private var packer:MaxRectsBinPack;

		public function MaxRectTest()
		{
			packer = new MaxRectsBinPack(512, 512);
			packer.addEventListener("progress", progressHandler);
			packer.addEventListener("complete", completeHandler);
			packer.allowFlip = false;

			var rects:Vector.<Rectangle> = new Vector.<Rectangle>();
			for(var i:uint = 0; i < 100; i++) {
				rects.push(new Rectangle(
					0,
					0,
					Math.round(10 + Math.random() * 90),
					Math.round(10 + Math.random() * 90)
				));
			}

			packer.insertBulk(rects, MaxRectsBinPack.METHOD_RECT_BEST_AREA_FIT);
		}

		private function progressHandler(event:Event):void {
			drawResults();
		}

		private function completeHandler(event:Event):void {
			drawResults();
		}

		private function drawResults():void {
			graphics.clear();
			for each(var usedRect:Rectangle in packer.usedRectangles) {
				drawRect(usedRect, 0xff0000);
			}
			for each(var freeRect:Rectangle in packer.freeRectangles) {
				drawRect(freeRect, 0xdddddd);
			}
		}

		private function drawRect(rect:Rectangle, color:uint):void {
			if(!rect.isEmpty()) {
				graphics.lineStyle(1, 0);
				graphics.beginFill(color);
				graphics.drawRect(rect.x, rect.y, rect.width, rect.height);
				graphics.endFill();
			}
		}
	}
}