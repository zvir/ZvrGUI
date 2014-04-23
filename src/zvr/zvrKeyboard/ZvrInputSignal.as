package zvr.zvrKeyboard 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrInputSignal 
	{
		public var selectionEnd:int;
		public var selectionBegin:int;
		public var text:String;
		
		public function ZvrInputSignal(text:String, selectionBegin:int, selectionEnd:int) 
		{
			this.selectionEnd = selectionEnd;
			this.selectionBegin = selectionBegin;
			this.text = text;
			
		}
		
	}

}