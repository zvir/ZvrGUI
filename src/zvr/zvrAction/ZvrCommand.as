package zvr.zvrAction 
{
	/**
	 * ...
	 * @author ...
	 */
	public class ZvrCommand
	{
		
		internal var manager:ZvrActionCommander;
		
		public function ZvrCommand() 
		{
			
		}
		
		protected function exec(type:String, ...rest):void
		{
			manager.eventExec(this, type, rest);
		}
		
	}

}