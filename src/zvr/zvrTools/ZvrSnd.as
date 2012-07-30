package zvr.zvrTools 
{
	import flash.media.SoundMixer;
	import flash.utils.ByteArray;
		

	/**
	 * ...
	 * @author	Michał Zwieruho "Zvir"
	 * @www		$(WWW)
	 * @email	$(Email)
	 */
	
	public class ZvrSnd
	{
		
		public static const left_wave:Array = new Array();
		public static const right_wave:Array = new Array();
		public static const left_spectrum:Array = new Array();
		public static const right_spectrum:Array = new Array();
		
		public static var volume_left:Number = 0 
		public static var volume_right:Number = 0;
		
		private static const bytes:ByteArray = new ByteArray();
		
		private static const CHANNEL_LENGTH:int = 256;
		
		public static function updateChanels():void
		{
			try
			{
				bytes.length = 0;
				left_wave.length = 0;
				right_wave.length = 0;
				
				SoundMixer.computeSpectrum(bytes, false, 0);
				
				var n:Number = 0;
				var v:Number = 0;
				// left
				volume_left = 0;
				for (var i:int = 0; i < CHANNEL_LENGTH; i++)
				{
					n = (bytes.readFloat());
					left_wave.push(n);
					v = n > 0 ? n : -n;
					volume_left = volume_left < v ? v : volume_left;
				}
				
				//volume_left = v / CHANNEL_LENGTH;
				v = 0;
				// right
				
				volume_right = 0;
				for (i = CHANNEL_LENGTH; i > 0; i--)
				{
					n = (bytes.readFloat());
					right_wave.push(n);
					v = n > 0 ? n : -n ;
					volume_right = volume_right < v ? v : volume_right;
				}
				
				//volume_right = v / CHANNEL_LENGTH;
				
				bytes.length = 0;
				
				left_spectrum.length = 0;
				right_spectrum.length = 0;
			
				SoundMixer.computeSpectrum(bytes, true, 0);
				
				// left
				for (i = 0; i < CHANNEL_LENGTH; i++)
				{
					n = (bytes.readFloat());
					left_spectrum.push(n)
				}
				// right
				for (i = CHANNEL_LENGTH; i > 0; i--)
				{
					n = (bytes.readFloat());
					right_spectrum.push(n)
				}

			}
			catch ( e:* )
			{
				 for (i = 0; i < CHANNEL_LENGTH; i++)
				 {
					n = Math.random();
					left_wave.push(n)
					right_wave.push(n);
					left_spectrum.push(n);
					right_spectrum.push(n);
				}
			}
		}
	}
	
}