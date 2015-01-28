package zvr.zvrSnd 
{
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IZvrSnd 
	{
		
		function set globalMute(value:Boolean):void;
		function get globalVolume():Number;
		
		function get currentChannel():SoundChannel;
		
		
		function get currentSound():Sound;
		
		function set mute(value:Boolean):void;
		
		function get mute():Boolean;
		
		function set volume(value:Number):void;
		
		function get volume():Number;
		
		function stop():void;
		
		function play(startTime:Number = 0, loops:int = 0, volume:Number = 1, pan:Number = 0):SoundChannel;
		
		function get globalMute():Boolean;
	}
	
}