package zvr.zvrSnd
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSndManager
	{
		
		private var _mute:Boolean;
		private var _volume:Number = 1;
		
		public var maxSounds:int = int.MAX_VALUE;
		
		private var _sounds:Vector.<ZvrSnd> = new Vector.<ZvrSnd>;
		public var _quene:Vector.<ZvrSnd> = new Vector.<ZvrSnd>;
		
		
		public function ZvrSndManager()
		{
			
		}
		
		public function addSound(s:ZvrSnd):void
		{
			_sounds.push(s);
		}
		
		public function removeSound(s:ZvrSnd):void
		{
			_sounds.splice(_sounds.indexOf(s), 1);
		}
		
		public function get mute():Boolean 
		{
			return _mute;
		}
		
		public function set mute(value:Boolean):void 
		{
			_mute = value;
			
			for (var i:int = 0; i < _sounds.length; i++) 
			{
				_sounds[i].globalMute = _mute;
			}
		}
		
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void 
		{
			_volume = value;
			
			/*for (var i:int = 0; i < _sounds.length; i++) 
			{
				_sounds[i].globalVolume = value;
			}*/
		}
	
		public function get soundsNum():int
		{
			return _sounds.length;
		}
	}

}