package zvr.zvrTools 
{
		

	/**
	 * ...
	 * @author	Michał Zwieruho "Zvir"
	 * @www		$(WWW)
	 * @email	$(Email)
	 */
	
	public class ZvrTime
	{
		
		
		public static function milisecontsToTime(time:Number):Object
		{
			var minutes:Number = Math.floor(time / 1000 / 60);
			var seconds:Number = Math.floor(time / 1000) % 60;
			var miliseconds:Number = Math.floor(time % 1000);
			
			var reasult:Object =  new Object();
			
			reasult.minutes = ((minutes < 10) ? "0" + minutes : minutes)
			reasult.seconds = ((seconds < 10) ? "0" + seconds : seconds);
			reasult.miliseconds = ((miliseconds < 100) ?  "0" + miliseconds : ((miliseconds < 10) ? "00" + miliseconds : miliseconds));
			
			return reasult;
		}
		
		public static function milisecontsToShortest(time:Number):Object
		{
			/*var minutes:Number = Math.floor(time / 1000 / 60);
			var seconds:Number = Math.floor(time / 1000) % 60;
			var miliseconds:Number = Math.floor(time % 1000);
			*/
			var reasult:Object =  new Object();
			
			/*reasult.minutes = ((minutes < 10) ? "0" + minutes : minutes)
			reasult.seconds = ((seconds < 10) ? "0" + seconds : seconds);
			reasult.miliseconds = ((miliseconds < 100) ?  "0" + miliseconds : ((miliseconds < 10) ? "00" + miliseconds : miliseconds));
			*/
			reasult.hours = time % (1000 * 60 * 60);
			reasult.minutes = (time % (1000 * 60 * 60)) / (1000 * 60);
			reasult.seconds = ((time % (1000 * 60 * 60)) % (1000 * 60)) / 1000;
			
			return reasult;
		}
		
		public static function secondsToHMS(seconds:Number/*, doNotRound:Boolean = false*/):Object
		{
			
			const MINUTE:Number = 60;
			const HOUR:Number = 60 * MINUTE;
			const DAY:Number = 24 * HOUR;
			
			var reasult:Object =  new Object();
			
			reasult.hours = Math.floor(seconds / HOUR);
			reasult.minutes = Math.floor((seconds / MINUTE) % MINUTE);
			reasult.seconds = (seconds | 0) % MINUTE;
			
			return reasult;
			
		}
		
	}

}