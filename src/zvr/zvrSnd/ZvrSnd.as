package zvr.zvrSnd
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.utils.getTimer;
	import zvr.zvrSound.*;
	
	/**
	 * ...
	 * @author Zvir
	 */
	
	public class ZvrSnd
	{
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
		
		public function ZvrSnd(sndClasses:Array, manager:ZvrSndManager = null, maxSounds:int = 99, minSoundsInterval:int = 0)
		{
			_maxSounds = maxSounds;
			_minSoundsInterval = minSoundsInterval;
			
			_manager = manager;
			
			//if (sndClasses.length == 0) throw new Error("Zero sounds classes");
			
			for (var i:int = 0; i < sndClasses.length; i++) 
			{
				
				
				if (sndClasses[i] is Sound)
				{
					_sounds.push(sndClasses[i]);
				}
				else
				{
					_sounds.push(new sndClasses[i]());
				}
				
			}
			
		}
		
		public function play(startTime:Number = 0, loops:int = 0, volume:Number = 1, pan:Number = 0):SoundChannel
		{
			var time:int = getTimer();
			
			if (time - _lastSoundTime <  _minSoundsInterval && _lastSoundTime != 0) return null;
			if (_manager && _manager.soundsNum >= _manager.maxSounds) return null;
			if (_soundChannels.length >= _maxSounds) return null;
			if (_sounds.length == 0) return null;
			
			var s:Sound = _sounds[int(Math.random() * _sounds.length)];
			
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