package zvr.zvrG2D 
{
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import zvr.zvrFont.ZvrFont;
	import zvr.zvrFont.ZvrFontChar;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class G2DFont extends ZvrFont 
	{
		
		public var atlas:GTextureAtlas;
		
		public function G2DFont() 
		{
			super();
		}
		
		public function getG2DChar(code:int):G2DFontChar
		{
			var c:G2DFontChar = getChar(code) as G2DFontChar;
			if (!c) 
			{
				trace("WTF");
			}
			return c;
		}
		
		public static function createFromFontXML(name:String, atlas:GTextureAtlas, xml:XML):G2DFont
		{
			var font:G2DFont = new G2DFont();
			
			font.name = name;
			font.atlas = atlas;
			
			font.bold = xml.info.@bold != "0";
			font.italic = xml.info.@italic != "0";
			
			font.size = Math.abs(xml.info.@size);
			
			font.lineHeight = xml.common.@lineHeight;
			font.base = xml.common.@base;
			font.chars = { };
			font.kernings = { };
			
			for (var i:int = 0; i < xml.chars.children().length(); ++i)
			{
				var node:XML = xml.chars.children()[i];
				var char:G2DFontChar = new G2DFontChar();
				char.font = font;
				char.char = node.@id;
				char.texture = atlas.getSubTexture(name + "_" + char.char.toString());
				char.xadvance = node.@xadvance;
				char.width = 
				font.chars[node.@id] = char;
			}
			
			var kernigList:XMLList = xml.kernings.kerning;
				
			for each (var item:XML in kernigList) 
			{
				var f:int = item.@first
				var s:int = item.@second;
				var a:Number = item.@amount;
				
				if (font.kernings[f] == undefined)
				{
					font.kernings[f] = { };
				}
				
				font.kernings[f][s] = a;
			}
			
			return font;
		}
		
	}

}