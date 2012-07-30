package zvr.zvrTools 
{
	import air.update.descriptors.StateDescriptor;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
		

	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrSignature
	{
		
		private var _body:ZvrSignatureBody;
		
		private var _z:Boolean = false;
		private var _v:Boolean = false;
		private var _r:Boolean = false;
		private var _stage:Stage;
		
		private var _visible:Boolean = false;
		
		public function ZvrSignature(stage:Stage) 
		{
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			_body = new ZvrSignatureBody();
		}
		
		private function keyDown(e:KeyboardEvent):void 
		{
			
			if (e.keyCode == Keyboard.Z) _z = true;
			if (_z && e.keyCode == Keyboard.V) _v = true;
			if (_v && e.keyCode == Keyboard.R) _r = true;
			
			if (e.keyCode != Keyboard.Z && e.keyCode != Keyboard.V && e.keyCode != Keyboard.R)
			{
				_z = false;
				_v = false;
				_r = false;
				
			}
			
			if (_z && _r && _v)
			{
				_stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyDown);
				showSignature();
				_z = false;
				_v = false;
				_r = false;
			}
			
		}
		
		private function showSignature():void
		{
			trace("Show Signature");
			_stage.addChild(_body);
			_stage.addEventListener(MouseEvent.CLICK, closeSignature);
			_stage.addEventListener(Event.RESIZE, stageResize);
			stageResize(null);
		}
		
		private function stageResize(e:Event):void 
		{
			_body.x = _stage.stageWidth / 2;
			_body.y = _stage.stageHeight / 2;
		}
		
		private function closeSignature(e:MouseEvent):void 
		{
			trace("Close Signature");
			_stage.removeChild(_body);
			_stage.removeEventListener(MouseEvent.CLICK, closeSignature);
			_stage.removeEventListener(Event.RESIZE, stageResize);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
		}
	}

}