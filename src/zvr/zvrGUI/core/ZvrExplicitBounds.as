package zvr.zvrGUI.core 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrExplicitBounds 
	{
		
		public static const X					:String = "x";
		public static const Y					:String = "y";
		public static const WIDTH				:String = "width";
		public static const HEIGHT				:String = "height";
		public static const LEFT				:String = "left";
		public static const RIGHT				:String = "right";
		public static const TOP					:String = "top";
		public static const BOTTOM				:String = "bottom";
		public static const PERCTENT_WIDTH		:String = "perctentWidth";
		public static const PERCTENT_HEIGHT		:String = "perctentHeight";
		public static const VERTICAL_CENTER		:String = "verticalCenter";
		public static const HORIZONTAL_CENTER	:String = "horizontalCenter";
	
		public static const NONE				:String = "none";
		
		private var _x:String = NONE;
		private var _y:String = NONE;
		private var _width:String = NONE;
		private var _height:String = NONE;
		private var _right:String = NONE;
		private var _bottom:String = NONE;
		
		private var _expricitReport:ZvrExplicitReport = new ZvrExplicitReport();
		
		public function ZvrExplicitBounds()
		{
			super();			
		}
		
		public function get x():String 
		{
			return _x;
		}
		
		public function set x(value:String):void 
		{
			_x = value;
			_expricitReport.x = value;
		}
		
		public function get y():String 
		{
			return _y;
		}
		
		public function set y(value:String):void 
		{
			_y = value;
			_expricitReport.y = value;
		}
		
		public function get width():String 
		{
			return _width;
		}
		
		public function set width(value:String):void 
		{
			_width = value;
			_expricitReport.width = value;
		}
		
		public function get right():String 
		{
			return _right;
		}
		
		public function set right(value:String):void 
		{
			_right = value;
			_expricitReport.right = value;
		}
		
		public function get height():String 
		{
			return _height;
		}
		
		public function set height(value:String):void 
		{
			_height = value;
			_expricitReport.height = value;
		}
		
		public function get bottom():String 
		{
			return _bottom;
		}
		
		public function set bottom(value:String):void 
		{
			_bottom = value;
			_expricitReport.bottom = value;
		}
		
		public function get explicitRaport():ZvrExplicitReport
		{
			return _expricitReport;
		}
		
		public function clone():ZvrExplicitBounds
		{
			var e:ZvrExplicitBounds = new ZvrExplicitBounds();
			
			e.x = _x;
			e.y = _y;
			e.width = _width;
			e.height = _height;
			
			return e;
			
		}
		
	}

}
	
	
	
	
	
	