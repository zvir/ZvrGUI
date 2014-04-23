package zvr 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrVirtualTextfieldEvent extends Event 
	{
		public var textField:ZvrVirtualTextfield;
		
		static public const TEXT_CHANGE:String = "textChange";
		static public const CARRET_INDEX_CHAGE:String = "carretIndexChage";
		static public const ACTIVE_CHANGE:String = "activeChange";

		public function ZvrVirtualTextfieldEvent(type:String, textField:ZvrVirtualTextfield, bubbles:Boolean=false, cancelable:Boolean=false) 
		{ 
			super(type, bubbles, cancelable);
			this.textField = textField;
			
		} 
		
		public override function clone():Event 
		{ 
			return new ZvrVirtualTextfieldEvent(type, textField, bubbles, cancelable);
		} 
		
		public override function toString():String 
		{ 
			return formatToString("ZvrVirtualTextfieldEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}