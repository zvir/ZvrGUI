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
	}

}