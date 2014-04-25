package clv.gui.core 
{
	import org.osflash.signals.Signal;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Pointer 
	{
		
		protected var _onUp			:Signal = new Signal(Pointer);
		protected var _onDown		:Signal = new Signal(Pointer);
		protected var _onMove		:Signal = new Signal(Pointer);
		protected var _onLeave		:Signal = new Signal(Pointer);
		protected var _onWheel		:Signal = new Signal(Pointer);
		protected var _onDragIn		:Signal = new Signal(Pointer);
		protected var _onDragOut	:Signal = new Signal(Pointer);
		protected var _onDrag		:Signal = new Signal(Pointer);
		protected var _onDragBegin	:Signal = new Signal(Pointer);
		protected var _onDragEnd	:Signal = new Signal(Pointer);
		protected var _onRollOver	:Signal = new Signal(Pointer);
		protected var _onRollOut	:Signal = new Signal(Pointer);
		protected var _onPoint		:Signal = new Signal(Pointer);
		
		public var x:Number;
		public var y:Number;
		
		public var index:int;
		public var downTime:int;
		
		public var down:Boolean;
		public var over:Boolean;
		public var drag:Boolean;
		
		public var wheel:int;
		
		public var pointTimeInterval:int = 300;
		public var dragTrigerDistance:int = 20;
		
		public var lastX:Number;
		public var lastY:Number;
		
		public var downX:Number;
		public var downY:Number;
		
		public var lastGlobalX:Number;
		public var lastGlobalY:Number;
		
		public var globalX:Number;
		public var globalY:Number;
		
		public function Pointer() 
		{
			
		}
		
		public function get onWheel():Signal 
		{
			return _onWheel;
		}
		
		public function get onLeave():Signal 
		{
			return _onLeave;
		}
		
		public function get onMove():Signal 
		{
			return _onMove;
		}
		
		public function get onDown():Signal 
		{
			return _onDown;
		}
		
		public function get onUp():Signal 
		{
			return _onUp;
		}
		
		public function get onDragOut():Signal 
		{
			return _onDragOut;
		}
		
		public function get onDragIn():Signal 
		{
			return _onDragIn;
		}
		
		public function get onRollOut():Signal 
		{
			return _onRollOut;
		}
		
		public function get onRollOver():Signal 
		{
			return _onRollOver;
		}
		
		public function get onPoint():Signal 
		{
			return _onPoint;
		}
		
		public function get onDragEnd():Signal 
		{
			return _onDragEnd;
		}
		
		public function get onDragBegin():Signal 
		{
			return _onDragBegin;
		}
		
		public function get onDrag():Signal 
		{
			return _onDrag;
		}
		
	}

}