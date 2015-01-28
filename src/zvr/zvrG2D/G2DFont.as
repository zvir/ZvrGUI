package zvr.zvrG2D 
{
	import clv.gameDev.texture.ClvGraphAssetChar;
	import clv.gameDev.texture.ClvGraphAssetFont;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import flash.geom.Rectangle;
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
				trace("char not found");
			}
			return c;
		}
		
		public static function createFromCGAF(atlas:GTextureAtlas, cgf:ClvGraphAssetFont):G2DFont
		{
			var font:G2DFont = new G2DFont();
			
			font.atlas 		= atlas;
			
			font.name 		= cgf.name;
			font.bold		= cgf.bold;
			font.italic		= cgf.bold;
			font.kernings	= cgf.kernings;
			font.base		= cgf.base;
			font.lineHeight	= cgf.lineHeight;
			font.size		= cgf.size;
			font.size		= cgf.size;
			font.chars = { };
			
			for (var i:int = 0; i < cgf.chars.length; i++) 
			{
				var ac:ClvGraphAssetChar = cgf.chars[i];
				var char:G2DFontChar = new G2DFontChar();
				
				var region:Rectangle = new Rectangle(ac.x, ac.y, ac.width, ac.height);
				
				var pivotX:int = -ac.xOffset - ac.width * 0.5;
				var pivotY:int = -ac.yOffset - ac.height * 0.5;
				
				char.texture = atlas.addSubTexture(font.name+"_" + ac.chr, region, ac.xOffset, ac.yOffset, region.width, region.height);
				
				char.font = font;
				char.char = ac.chr;
				char.width = ac.width;
				char.height = ac.height;
				char.xadvance = ac.xAdvance;
				
				font.chars[char.char] = char;
			}
			
			return font;
			
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
				//char.width = 
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