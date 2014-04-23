package zvr.zvrFont 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrFont 
	{
		
		public var name:String;
		public var face:String;
		
		public var size:Number;
		
		public var bold:Boolean;
		public var italic:Boolean;
		
		public var lineHeight:Number;
		public var base:Number;
		
		public var chars:Object;
		
		public var kernings:Object;
		
		public function ZvrFont() 
		{
			
		}
		
		public function getChar(code:int):ZvrFontChar
		{
			return chars[code] as ZvrFontChar;
		}
		
		public function getKerning(f:int, s:int):Number
		{
			if (kernings[f] == undefined) return 0;
			
			if (kernings[f][s] == undefined) return 0;
			
			return kernings[f][s];
		}
		
	}

}