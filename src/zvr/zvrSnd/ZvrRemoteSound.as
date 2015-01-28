package zvr.zvrSnd 
{
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrRemoteSound 
	{
		
		private static const snds:Dictionary = new Dictionary();
		
		public function ZvrRemoteSound() 
		{
			
		}
		
		public static function play(file:File, vol:Number = 1):SoundChannel
		{
			
			if (!file || !file.exists) return null;
			
			if (snds[file]) snds[file].stop();
			
			//var f:File = new File(file);
			
			var req:URLRequest = new URLRequest(file.url); 
			
			var s:Sound = new Sound(req); 
			
			var sc:SoundChannel = s.play();
			
			snds[file] = sc;
			
			sc.addEventListener(Event.SOUND_COMPLETE, sndComplete);
			
			var st:SoundTransform = new SoundTransform();
			
			st.volume = vol;
			sc.soundTransform = st;
			
			return sc;
			
		}
		
		public static function stop(file:File):void
		{
			if (!snds[file]) return;
			SoundChannel(snds[file]).stop();
		}
		
		public static function getSoundChannel(file:String):SoundChannel
		{
			return SoundChannel(snds[file])
		}
		
		static private function sndComplete(e:Event):void 
		{
			
		}
		
	}

}