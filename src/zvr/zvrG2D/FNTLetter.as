package zvr.zvrG2D 
{
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import flash.geom.Rectangle;
	import zvr.zvrFont.ZvrFont;
	/**
	 * ...
	 * @author Zvir
	 */
	//use namespace g2d;
	
	public class FNTLetter extends GSprite
	{
		private static function getEmptyChar():G2DFontChar
		{
			var c:G2DFontChar = new G2DFontChar();
			c.font = new ZvrFont();
			c.font.lineHeight = 10;
			c.xadvance = 0;
			return c;
		}
		
		public static const EMPTY_CHAR:G2DFontChar = getEmptyChar();
		
		private var _char:G2DFontChar;
		
		private var _rect:Rectangle;
		
		
		public function FNTLetter(p_node:GNode) 
		{
			super(p_node);
		}
		
		public function get char():G2DFontChar 
		{
			return _char;
		}
		
		public function set char(value:G2DFontChar):void 
		{
			if (!value)
			{
				_char = EMPTY_CHAR;
				texture = null;
				return;
			}
			_char = value;
			texture = _char.texture;
			
			_rect = null;
			
		}
		
		public function get rect():Rectangle 
		{
			
			if (!_rect && _char)
			{
				_rect = new Rectangle(node.transform.x, node.transform.y, _char.xadvance, _char.font.lineHeight);
			}
			
			return _rect;
		}
		
	}

}