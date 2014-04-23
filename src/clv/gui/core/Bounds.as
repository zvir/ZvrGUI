package clv.gui.core 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class Bounds 
	{
		
		private static const px:int = 0;
		
		private static const pr:int = 1;
		
		private static const cpx:int = 2;
		
		private static const cpr:int = 3;
		
		
		
		
		private var _dirty:Boolean;
		
		private var _idepended:Boolean;
		
		private var _bX:Number = 0.0;
		private var _bY:Number = 0.0;
		private var _bW:Number = 0.0;
		private var _bH:Number = 0.0;
		
		/*private var _x          :Number = 0.0;
		private var _y          :Number = 0.0;*/
		
		private var _width		:Number = 0.0;
		private var _height     :Number = 0.0;
		private var _top        :Number;
		private var _bottom     :Number;
		private var _right      :Number;
		private var _left       :Number;
		private var _prWidth    :Number;
		private var _prHeight   :Number;
		private var _prX        :Number;
		private var _prY        :Number;
		private var _vX         :Number;
		private var _hY         :Number;
		private var _hPrX       :Number;
		private var _vPrY       :Number;
		
		
		
		
		public function Bounds() 
		{
			
		}
		
		public function reset():void
		{
			_dirty = true;
			
			_width		= 0.0;
			_height     = 0.0;
			
			_top        = NaN;
			_bottom     = NaN;
			_right      = NaN;
			_left       = NaN;
			_prWidth    = NaN;
			_prHeight   = NaN;
			_prX        = NaN;
			_prY        = NaN;
			_vX         = NaN;
			_hY         = NaN;
			_hPrX       = NaN;
			_vPrY       = NaN;
		}
		
		public function update(container:Container):void
		{
			_dirty = false;
		}
		
		public function get idepended():Boolean 
		{
			return _idepended;
		}
		
		public function get x():Number 
		{
			return _left;
		}
		
		public function set x(value:Number):void 
		{
			if (_left == value) return;
			_dirty = true;
			_left = value;
		}
		
		public function get y():Number 
		{
			return _top;
		}
		
		public function set y(value:Number):void 
		{
			if (_top == value) return;
			_dirty = true;
			_top = value;
		}
		
		public function get width():Number 
		{
			return _width;
		}
		
		public function set width(value:Number):void 
		{
			if (_width == value) return;
			_dirty = true;
			_width = value;
		}
		
		public function get height():Number 
		{
			return _height;
		}
		
		public function set height(value:Number):void 
		{
			if (_height == value) return;
			_dirty = true;
			_height = value;
		}
		
		public function get top():Number 
		{
			return _top;
		}
		
		public function set top(value:Number):void 
		{
			if (_top == value) return;
			_dirty = true;
			_top = value;
		}
		
		public function get bottom():Number 
		{
			return _bottom;
		}
		
		public function set bottom(value:Number):void 
		{
			if (_bottom == value) return;
			_dirty = true;
			_bottom = value;
		}
		
		public function get right():Number 
		{
			return _right;
		}
		
		public function set right(value:Number):void 
		{
			if (_right == value) return;
			_dirty = true;
			_right = value;
		}
		
		public function get left():Number 
		{
			return _left;
		}
		
		public function set left(value:Number):void 
		{
			if (_left == value) return;
			_dirty = true;
			_left = value;
		}
		
		public function get prWidth():Number 
		{
			return _prWidth;
		}
		
		public function set prWidth(value:Number):void 
		{
			if (_prWidth == value) return;
			_dirty = true;
			_prWidth = value;
		}
		
		public function get prHeight():Number 
		{
			return _prHeight;
		}
		
		public function set prHeight(value:Number):void 
		{
			if (_prHeight == value) return;
			_dirty = true;
			_prHeight = value;
		}
		
		public function get prX():Number 
		{
			return _prX;
		}
		
		public function set prX(value:Number):void 
		{
			if (_prX == value) return;
			_dirty = true;
			_prX = value;
		}
		
		public function get prY():Number 
		{
			return _prY;
		}
		
		public function set prY(value:Number):void 
		{
			if (_prY == value) return;
			_dirty = true;
			_prY = value;
		}
		
		public function get vX():Number 
		{
			return _vX;
		}
		
		public function set vX(value:Number):void 
		{
			if (_vX == value) return;
			_dirty = true;
			_vX = value;
		}
		
		public function get hY():Number 
		{
			return _hY;
		}
		
		public function set hY(value:Number):void 
		{
			if (_hY == value) return;
			_dirty = true;
			_hY = value;
		}
		
		public function get hPrX():Number 
		{
			return _hPrX;
		}
		
		public function set hPrX(value:Number):void 
		{
			if (_hPrX == value) return;
			_dirty = true;
			_hPrX = value;
		}
		
		public function get vPrY():Number 
		{
			return _vPrY;
		}
		
		public function set vPrY(value:Number):void 
		{
			if (_vPrY == value) return;
			_dirty = true;
			_vPrY = value;
		}
		
		public function get bX():Number 
		{
			return _bX;
		}
		
		public function get bY():Number 
		{
			return _bY;
		}
		
		public function get bH():Number 
		{
			return _bH;
		}
		
		public function get bW():Number 
		{
			return _bW;
		}
		
	}

}