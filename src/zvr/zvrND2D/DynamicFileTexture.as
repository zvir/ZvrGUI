package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.Sprite2DMaterial;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.ProgressEvent;
	import flash.filesystem.File;
	import flash.net.URLRequest;
	/**
	 * ...
	 * @author Zvir
	 */
	
	[Event(name = "ready", type = "zvr.zvrND2D.DynamicFileTextureEvent")]
	[Event(name = "loading", type = "zvr.zvrND2D.DynamicFileTextureEvent")]
	[Event(name = "progress", type = "zvr.zvrND2D.DynamicFileTextureEvent")]
	
	public class DynamicFileTexture extends EventDispatcher
	{
		
		private var _sprite:Sprite2D;
		private var _path:String;
		private var _loader:Loader;
		
		public function DynamicFileTexture(path:String, sprite:Sprite2D) 
		{
			_path = path;
			_sprite = sprite;
			_sprite.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			_loader = new Loader();
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, complete);
			_loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			
		}
		
		private function addedToStage(e:Event):void 
		{
			_sprite.removeEventListener(Event.ADDED_TO_STAGE, addedToStage);
			_sprite.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			load();
			
		}
		
		private function removedFromStage(e:Event):void 
		{
			_sprite.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			_sprite.addEventListener(Event.ADDED_TO_STAGE, addedToStage);
			
			unload();
		}
		
		
		private function load():void
		{
			if (!_path) return;
			
			var f:File = new File(_path);
			if (!f.exists) return;
			_loader.load(new URLRequest(f.url));
			dispatchEvent(new DynamicFileTextureEvent(DynamicFileTextureEvent.LOADING, this, 0, 0));
		}
		
		private function unload():void
		{
			if (_sprite.texture) 
			{	
				_sprite.texture.dispose();
				_sprite.setTexture(null);
				_sprite.setMaterial(null);
			}
		}
		
		private function reload():void
		{
			if (!_sprite.stage) return;
			
			unload();
			load();
		}
		
		private function complete(e:Event):void 
		{
			trace("complete");
			
			var b:BitmapData = e.target.content.bitmapData;
			_sprite.setTexture(Texture2D.textureFromBitmapData(b));
			_sprite.setMaterial(new Sprite2DMaterial());
			
			dispatchEvent(new DynamicFileTextureEvent(DynamicFileTextureEvent.READY, this, 0, 0));
			
		}
		
		private function progress(e:ProgressEvent):void 
		{
			dispatchEvent(new DynamicFileTextureEvent(DynamicFileTextureEvent.PROGRESS, this, e.bytesLoaded, e.bytesTotal));
		}
		
		public function get sprite():Sprite2D 
		{
			return _sprite;
		}
		
		public function get path():String 
		{
			return _path;
		}
		
		public function set path(value:String):void 
		{
			if (_path != value)
			{
				_path = value;
				reload();
			}
			_path = value;
		}
		
	}

}