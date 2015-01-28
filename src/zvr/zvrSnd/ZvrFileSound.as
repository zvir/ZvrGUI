package zvr.zvrSnd 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ZvrFileSound implements IZvrSnd
	{
		
		private const snds:Dictionary = new Dictionary();
		
		private var _volume:Number = 1;
		private var _mute:Boolean;
		
		private var _manager:ZvrSndManager;
		
		private var _sounds:Vector.<Sound> = new Vector.<Sound>();
		private var _soundChannels:Vector.<SoundChannel> = new Vector.<SoundChannel>();
		
		private var _currentSound:Sound;
		private var _currentChannel:SoundChannel;
		
		private var _maxSounds:int = 99;
		private var _minSoundsInterval:int = 0;
		
		private var _lastSoundTime:uint;
		private var _files:Array;
		
		
		public function ZvrFileSound(files:Array, manager:ZvrSndManager = null, maxSounds:int = 99, minSoundsInterval:int = 0)
		{
			_files = files;
			
			_maxSounds = maxSounds;
			
			_minSoundsInterval = minSoundsInterval;
			
			_manager = manager;
			
		
			//if (sndClasses.length == 0) throw new Error("Zero sounds classes");
			
			/*for (var i:int = 0; i < files.length; i++) 
			{
				_sounds.push(new sndClasses[i]());
			}*/
			
		}
		
		public function play(startTime:Number = 0, loops:int = 0, volume:Number = 1, pan:Number = 0):SoundChannel
		{
			var time:int = getTimer();
			
			if (time - _lastSoundTime <  _minSoundsInterval && _lastSoundTime != 0) return null;
			if (_manager && _manager.soundsNum >= _manager.maxSounds) return null;
			if (_soundChannels.length >= _maxSounds) return null;
			if (_files.length == 0) return null;
			
			
			var s:Sound = getSound(int(Math.random() * _files.length));
			
			var soundChannel:SoundChannel = s.play(startTime, loops);
			
			if (!soundChannel) return null;
			
			_currentSound = s;
			
			_soundChannels.push(soundChannel);
			
			soundChannel.addEventListener(Event.SOUND_COMPLETE, soundComplete);
			
			var st:SoundTransform = new SoundTransform();
			st.volume = volume / 1 * getVoulume();
			st.pan = pan;
			
			soundChannel.soundTransform = st;
			
			if (_manager && _soundChannels.length == 1) _manager.addSound(this);
			
			_lastSoundTime = time
			
			return soundChannel;
		}
		
		private function getSound(i:int):Sound 
		{
			var file:File = _files[i];
			
			if (!file || !file.exists) 
			{
				return null;
			}
			
			if (snds[file] != undefined) 
			{
				return snds[file];
			}
			
			var req:URLRequest = new URLRequest(file.url); 
			
			var s:Sound = new Sound(req); 
			
			snds[file] = s;
			
			return s;
			
		}
		
		private function soundComplete(e:Event):void 
		{
			stopChannel(e.currentTarget as SoundChannel);
			_currentSound = null;
		}
		
		public function stop():void
		{
			for (var i:int = 0; i < _soundChannels.length; i++) 
			{
				_soundChannels[i].stop();
			}
			_currentSound = null;
		}
		
		private function stopChannel(soundChannel:SoundChannel):void 
		{
			soundChannel.stop();
			_soundChannels.splice(_soundChannels.indexOf(soundChannel), 1);
			if (_manager && _soundChannels.length == 0) _manager.removeSound(this);
			_currentSound = null;
		}
		
		private function getVoulume():Number
		{
			if (globalMute) return 0;
			if (_mute) return 0;
			return _volume * globalVolume;
		}
		
		public function get globalMute():Boolean 
		{
			if (!_manager) return false;
			
			return _manager.mute;
		}
		
		public function set globalMute(v:Boolean):void
		{
			
		}
		
		public function get globalVolume():Number 
		{
			if (!_manager) return 1;
			return _manager.volume;
		}
		
		public function get volume():Number 
		{
			return _volume;
		}
		
		public function set volume(value:Number):void 
		{
			_volume = value;
		}
		
		public function get mute():Boolean 
		{
			return _mute;
		}
		
		public function set mute(value:Boolean):void 
		{
			_mute = value;
		}
		
		public function get currentSound():Sound 
		{
			return _currentSound;
		}
		
		public function get currentChannel():SoundChannel 
		{
			return _soundChannels.length > 0 ? _soundChannels[_soundChannels.length - 1] : null;
		}
		
	}

}