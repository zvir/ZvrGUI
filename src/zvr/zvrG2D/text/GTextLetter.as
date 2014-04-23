package zvr.zvrG2D.text 
{
	import com.genome2d.textures.GTexture;
	import flash.geom.Rectangle;
	import zvr.zvrG2D.G2DFontChar;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class GTextLetter 
	{
		
		private var _char:G2DFontChar;
		private var _rect:Rectangle;
		
		public var x:Number = 0;
		public var y:Number = 0;
		
		public var texture:GTexture;
		
		
		
		public function GTextLetter() 
		{
			
		}
		
		public function set char(value:G2DFontChar):void 
		{
			if (!value)
			{
				_char = null;
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
				_rect = new Rectangle(x, y, _char.xadvance, _char.font.lineHeight);
			}
			
			return _rect;
		}
		
		public function get char():G2DFontChar 
		{
			return _char;
		}
	}

}