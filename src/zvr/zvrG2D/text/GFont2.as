package zvr.zvrG2D.text 
{
	import _Map.Map_Impl_;
	import clv.gameDev.texture.ClvGraphAsset;
	import clv.gameDev.texture.ClvGraphAssetChar;
	import clv.gameDev.texture.ClvGraphAssetFont;
	import com.genome2d.context.IContext;
	import com.genome2d.textures.GCharTexture;
	import com.genome2d.textures.GFontTextureAtlas;
	import com.genome2d.textures.GTexture;
	import com.genome2d.textures.GTextureAtlas;
	import flash.geom.Rectangle;
	import zvr.zvrG2D.G2DFont;
	import zvr.zvrG2D.G2DFontChar;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class GFont2 extends GFontTextureAtlas
	{
		
		public var kernings:Object;
		public var chars:Object;
		
		
		public function GFont2(p_id:String=null) 
		{
			super(null, p_id);
		}
		
		override public function getSubTexture(p_subId:String):GTexture 
		{
			return chars[p_subId];
		}
		
		override public function getKerning(p_first:int, p_second:int):int 
		{
			if (kernings[p_first] && kernings[p_first][p_second]) return kernings[p_first][p_second];
			return 0;
		}
		
		
		public static function createFromCGA(a:GTextureAtlas, cgf:ClvGraphAssetFont):GFont2
		{
			
			
			
			var f:GFont2 = new GFont2(a.g2d_id + "_" + cgf.name);
			
			f.kernings = cgf.kernings;
			f.lineHeight = cgf.lineHeight;
			f.chars = { };
			t.g2d_id = a.g2d_id + "_" + cgf.name;
			
			for (var i:int = 0; i < cgf.chars.length; i++) 
			{
				var c:ClvGraphAssetChar = cgf.chars[i];
				
				var gc:G2DFontChar = new G2DFontChar();
				
				var t:GTexture = a.addSubTexture(cgf.name + "_" + c.chr, new Rectangle(c.x, c.y, c.width, c.height), null, false, -c.width / 2, -c.height / 2);
				
				gc.texture = t;
				gc.xadvance = c.xAdvance;
				gc.char = c.chr;
				gc.font;
				
				
				
				new GCharTexture(a.g2d_context, a.g2d_id + "_" + cgf.name + "_" + c.chr, 0, 0, , a);
				
				t.g2d_subId = cgf.name + "_" + c.chr;
				t.g2d_filteringType = a.g2d_filteringType;
				t.nativeTexture = a.nativeTexture;
				//f.chars[c.chr] = t;
				a.g2d_textures[cgf.name + "_" + c.chr] = t;
			}
			
			return f;
		}
		
	}

}