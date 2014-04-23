package clv.gui.core.layouts 
{
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class ContentPadding 
	{
		private var _contentPaddingSetter:Function;
		
		private var _top:Number = 0;
		private var _left:Number = 0;
		private var _right:Number = 0;
		private var _bottom:Number = 0;
		
		public function ContentPadding(contentPaddingSetter:Function) 
		{
			_contentPaddingSetter = contentPaddingSetter;
		}
		
		public function dispose():void 
		{
			_contentPaddingSetter = null;
		}
		
		public function get top():Number 
		{
			return _top;
		}
		
		public function set top(value:Number):void 
		{
			var d:Number = _top - value;
			_top = value;
			_contentPaddingSetter(d, 0, 0, 0);
		}
		
		public function get left():Number 
		{
			return _left;
		}
		
		public function set left(value:Number):void 
		{
			var d:Number = _left - value;
			_left = value;
			_contentPaddingSetter(0, d, 0, 0);
		}
		
		public function get right():Number 
		{
			return _right;
		}
		
		public function set right(value:Number):void 
		{
			var d:Number = _right - value;
			_right = value;
			_contentPaddingSetter(0, 0, d, 0);
		}
		
		public function get bottom():Number 
		{
			return _bottom;
		}
		
		public function set bottom(value:Number):void 
		{
			var d:Number = _bottom - value;
			_bottom = value;
			_contentPaddingSetter(0, 0, 0, d);
		}
		
		public function set padding(value:Number):void 
		{
			var t:Number = _top - value;
			var l:Number = _left - value;
			var r:Number = _right - value;
			var b:Number = _bottom - value;
			_top = value;
			_left = value;
			_right = value;
			_bottom = value;
			_contentPaddingSetter(t, l, r, b);
		}
	}

}