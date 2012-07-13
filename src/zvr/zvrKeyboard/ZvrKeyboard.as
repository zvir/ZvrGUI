package zvr.zvrKeyboard
{
	import de.popforge.ui.KeyboardShortcut;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.utils.Dictionary;
	import utils.array.equals;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	// BUG think of testing focus bug
	 
	public class ZvrKeyboard
	{
		private static const keySetter:Dictionary = new Dictionary();
		private static const keys:Dictionary = new Dictionary();
		
		public static const BACKSPACE		:ZvrKey = new ZvrKey(8, registerKey);
		public static const TAB				:ZvrKey = new ZvrKey(9, registerKey);
		
		public static const NUMPAD_5_OFF	:ZvrKey = new ZvrKey(12, registerKey);
		
		public static const ENTER			:ZvrKey = new ZvrKey(13, registerKey);
		public static const COMMAND			:ZvrKey = new ZvrKey(15, registerKey);
		public static const SHIFT			:ZvrKey = new ZvrKey(16, registerKey);
		public static const CTRL			:ZvrKey = new ZvrKey(17, registerKey);
		public static const ALT				:ZvrKey = new ZvrKey(18, registerKey);
		public static const PAUSE_BREAK		:ZvrKey = new ZvrKey(19, registerKey);
		
		public static const CAPS_LOCK		:ZvrKey = new ZvrKey(20, registerKey);
		public static const NUMPAD			:ZvrKey = new ZvrKey(21, registerKey);
		public static const ESCAPE			:ZvrKey = new ZvrKey(27, registerKey);
		public static const SPACE			:ZvrKey = new ZvrKey(32, registerKey);
		public static const PAGE_UP			:ZvrKey = new ZvrKey(33, registerKey);
		public static const PAGE_DOWN		:ZvrKey = new ZvrKey(34, registerKey);
		public static const END				:ZvrKey = new ZvrKey(35, registerKey);
		public static const HOME			:ZvrKey = new ZvrKey(36, registerKey);
		
		public static const LEFT			:ZvrKey = new ZvrKey(37, registerKey);
		public static const UP				:ZvrKey = new ZvrKey(38, registerKey);
		public static const RIGHT			:ZvrKey = new ZvrKey(39, registerKey);
		public static const DOWN			:ZvrKey = new ZvrKey(40, registerKey);
		
		public static const INSERT			:ZvrKey = new ZvrKey(45, registerKey);
		public static const DELETE			:ZvrKey = new ZvrKey(46, registerKey);
		
		public static const NUMBER_0		:ZvrKey = new ZvrKey(48, registerKey);
		public static const NUMBER_1		:ZvrKey = new ZvrKey(49, registerKey);
		public static const NUMBER_2		:ZvrKey = new ZvrKey(50, registerKey);
		public static const NUMBER_3		:ZvrKey = new ZvrKey(51, registerKey);
		public static const NUMBER_4		:ZvrKey = new ZvrKey(52, registerKey);
		public static const NUMBER_5		:ZvrKey = new ZvrKey(53, registerKey);
		public static const NUMBER_6		:ZvrKey = new ZvrKey(54, registerKey);
		public static const NUMBER_7		:ZvrKey = new ZvrKey(55, registerKey);
		public static const NUMBER_8		:ZvrKey = new ZvrKey(56, registerKey);
		public static const NUMBER_9		:ZvrKey = new ZvrKey(57, registerKey);
		
		public static const A				:ZvrKey = new ZvrKey(65, registerKey);
		public static const B				:ZvrKey = new ZvrKey(66, registerKey);
		public static const C				:ZvrKey = new ZvrKey(67, registerKey);
		public static const D				:ZvrKey = new ZvrKey(68, registerKey);
		public static const E				:ZvrKey = new ZvrKey(69, registerKey);
		public static const F				:ZvrKey = new ZvrKey(70, registerKey);
		public static const G				:ZvrKey = new ZvrKey(71, registerKey);
		public static const H				:ZvrKey = new ZvrKey(72, registerKey);
		public static const I				:ZvrKey = new ZvrKey(73, registerKey);
		public static const J				:ZvrKey = new ZvrKey(74, registerKey);
		public static const K				:ZvrKey = new ZvrKey(75, registerKey);
		public static const L				:ZvrKey = new ZvrKey(76, registerKey);
		public static const M				:ZvrKey = new ZvrKey(77, registerKey);
		public static const N				:ZvrKey = new ZvrKey(78, registerKey);
		public static const O				:ZvrKey = new ZvrKey(79, registerKey);
		public static const P				:ZvrKey = new ZvrKey(80, registerKey);
		public static const Q				:ZvrKey = new ZvrKey(81, registerKey);
		public static const R				:ZvrKey = new ZvrKey(82, registerKey);
		public static const S				:ZvrKey = new ZvrKey(83, registerKey);
		public static const T				:ZvrKey = new ZvrKey(84, registerKey);
		public static const U				:ZvrKey = new ZvrKey(85, registerKey);
		public static const V				:ZvrKey = new ZvrKey(86, registerKey);
		public static const W				:ZvrKey = new ZvrKey(87, registerKey);
		public static const X				:ZvrKey = new ZvrKey(88, registerKey);
		public static const Y				:ZvrKey = new ZvrKey(89, registerKey);
		public static const Z				:ZvrKey = new ZvrKey(90, registerKey);
		
		
		public static const WIN_START_L		:ZvrKey = new ZvrKey(91, registerKey);
		public static const WIN_START_R		:ZvrKey = new ZvrKey(92, registerKey);
		public static const WIN_MENU		:ZvrKey = new ZvrKey(93, registerKey);
		public static const NUMPAD_0		:ZvrKey = new ZvrKey(96, registerKey);
		public static const NUMPAD_1		:ZvrKey = new ZvrKey(97, registerKey);
		public static const NUMPAD_2		:ZvrKey = new ZvrKey(98, registerKey);
		public static const NUMPAD_3		:ZvrKey = new ZvrKey(99, registerKey);
		public static const NUMPAD_4		:ZvrKey = new ZvrKey(100, registerKey);
		public static const NUMPAD_5		:ZvrKey = new ZvrKey(101, registerKey);
		public static const NUMPAD_6		:ZvrKey = new ZvrKey(102, registerKey);
		public static const NUMPAD_7		:ZvrKey = new ZvrKey(103, registerKey);
		public static const NUMPAD_8		:ZvrKey = new ZvrKey(104, registerKey);
		public static const NUMPAD_9		:ZvrKey = new ZvrKey(105, registerKey);
		public static const NUMPAD_MULTIPLY	:ZvrKey = new ZvrKey(106, registerKey);
		public static const NUMPAD_ADD		:ZvrKey = new ZvrKey(107, registerKey);
		public static const NUMPAD_ENTER	:ZvrKey = new ZvrKey(108, registerKey);
		public static const NUMPAD_SUBTRACT	:ZvrKey = new ZvrKey(109, registerKey);
		public static const NUMPAD_DECIMAL	:ZvrKey = new ZvrKey(110, registerKey);
		public static const NUMPAD_DIVIDE	:ZvrKey = new ZvrKey(111, registerKey);
		
		public static const F1				:ZvrKey = new ZvrKey(112, registerKey);
		public static const F2				:ZvrKey = new ZvrKey(113, registerKey);
		public static const F3				:ZvrKey = new ZvrKey(114, registerKey);
		public static const F4				:ZvrKey = new ZvrKey(115, registerKey);
		public static const F5				:ZvrKey = new ZvrKey(116, registerKey);
		public static const F6				:ZvrKey = new ZvrKey(117, registerKey);
		public static const F7				:ZvrKey = new ZvrKey(118, registerKey);
		public static const F8				:ZvrKey = new ZvrKey(119, registerKey);
		public static const F9				:ZvrKey = new ZvrKey(120, registerKey);
		public static const F10				:ZvrKey = new ZvrKey(121, registerKey);
		public static const F11				:ZvrKey = new ZvrKey(122, registerKey);
		public static const F12				:ZvrKey = new ZvrKey(123, registerKey);
		public static const F13				:ZvrKey = new ZvrKey(124, registerKey);
		public static const F14				:ZvrKey = new ZvrKey(125, registerKey);
		public static const F15				:ZvrKey = new ZvrKey(126, registerKey);
		
		public static const NUMPAD_LOCK		:ZvrKey = new ZvrKey(144, registerKey);
		public static const SCROLLLOCK		:ZvrKey = new ZvrKey(145, registerKey);
		
		public static const SEMICOLON		:ZvrKey = new ZvrKey(186, registerKey);
		public static const EQUAL			:ZvrKey = new ZvrKey(187, registerKey);
		public static const COMMA			:ZvrKey = new ZvrKey(188, registerKey);
		public static const MINUS			:ZvrKey = new ZvrKey(189, registerKey);
		public static const PERIOD			:ZvrKey = new ZvrKey(190, registerKey);
		public static const SLASH 			:ZvrKey = new ZvrKey(191, registerKey);
		public static const BACKQUOTE		:ZvrKey = new ZvrKey(192, registerKey);
		public static const LEFTBRACKET		:ZvrKey = new ZvrKey(219, registerKey);
		public static const BACKSLASH		:ZvrKey = new ZvrKey(220, registerKey);
		public static const RIGHTBRACKET	:ZvrKey = new ZvrKey(221, registerKey);
		public static const QUOTE			:ZvrKey = new ZvrKey(222, registerKey);
		
		private static const downKeys:Array = new Array();
		private static var downKeysSignature:String = new String();
		
		private static var keySequences:Array = new Array();
		private static var keyShortcuts:Array = new Array();
		
		public static var currentEvent:KeyboardEvent;
		private static var initialized:Boolean = false;
		
		private static var _stage:Stage;
		
		private static var _lastFocus:DisplayObject;
		
		private static var _presedKeys:/*ZvrKey*/Array = new Array();
		
		public static function init(stage:Stage):void
		{
			if (initialized) return;
			initialized = true;
			_stage = stage;
			_stage.addEventListener(KeyboardEvent.KEY_UP, keyUp);
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown);
			
			_stage.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			_stage.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
		}
		
		// Bug in flash - if there was display object with focus in, and it was removed from display list, 
		// stage does not dispatch key events, focus stays on removed display object.
		// Solution is detect when focused item is removed and set focus to stage.
		
		static private function focusOut(e:FocusEvent):void 
		{
			if (e.target == _stage) return;
			DisplayObject(e.target).removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		static private function focusIn(e:FocusEvent):void 
		{
			if (e.target == _stage) return;
			DisplayObject(e.target).addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
		}
		
		static private function removedFromStage(e:Event):void 
		{
			DisplayObject(e.target).removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			_stage.focus = _stage;
		}
		
		private static function keyDown(e:KeyboardEvent):void
		{
			currentEvent = e;
			
			var k:ZvrKey = keys[e.keyCode];
			
			if (!k)
			{
				tr("Keyboad Warning: Unknown key. Code:", e.keyCode);
				return;
			}
			
			var i:int = _presedKeys.indexOf(k);
			
			if (i == -1)
			{
				_presedKeys.push(k);

			}
			updateWch();
			setKeyState(e.keyCode, true);
		}
		
		private static function keyUp(e:KeyboardEvent):void
		{
			currentEvent = e;
			
			var k:ZvrKey = keys[e.keyCode];
			if (!k) return;
			
			var i:int = _presedKeys.indexOf(k);
			_presedKeys.splice(i, 1);
			updateWch();
			
			setKeyState(e.keyCode, false);
		}
		
		private static function updateWch():void 
		{
			
			var s:String = "";
			
			for (var i:int = 0; i < _presedKeys.length; i++) 
			{
				s += _presedKeys[i].code+" ("+String.fromCharCode(_presedKeys[i].code)+")"+", ";
			}
			
			wch("ZvrKeyboard", "pressed keys", s);
			
		}
		
		private static function setKeyState(code:uint, state:Boolean):void
		{
			var k:ZvrKey = keys[code];
			
			if (!k) 
			{
				k = new ZvrKey(code, registerKey);
			}
			
			keySetter[k](state);
			
			if (state)
			{
				addToDownKeys(k);
			}
			else
			{
				validateKeysSequences(k);
			}
			
		}
		
		private static function registerKey(key:ZvrKey, setPressed:Function):void
		{
			keySetter[key] = setPressed;
			keys[key.code] = key;
		}
		
		private static function addToDownKeys(k:ZvrKey):void
		{
			downKeys.push(k);
		}
		
		private static function removefromDownKeys(k:ZvrKey):void
		{
			var i:int = downKeys.indexOf(k);
			if (i == -1) return;
			downKeys.splice(i, 1);
		}
		
		private static function updateDownKeysSignature():void
		{
			downKeys.sortOn("code", Array.NUMERIC);
			downKeysSignature = downKeys.join("|");
		}
		
		private static function validateKeysSequences(k:ZvrKey):void
		{
			for (var i:int = 0; i < keySequences.length; i++) 
			{
				var s:ZvrKeySequence = keySequences[i];
				if (s.validate(k)) s.callback.call();
			}
		}
		
		public static function addKeySequenceCallback(callback:Function, ... rest):ZvrKeySequence
		{
			var sq:ZvrKeySequence = new ZvrKeySequence(rest, callback);
			var s:Array = new Array();
			keySequences.push(sq);
			return sq;
		}
		
		public static function removeKeySequenceCallback(callback:Function, ... rest):void
		{
			var valid:Array = new Array();
			for (var i:int = 0; i < keySequences.length; i++) 
			{
				var sq:ZvrKeySequence = keySequences[i];
				if (!(equals(rest, sq.sequence) && sq.callback.callback == callback)) valid.push(sq); else tr("found and removed");
			}
			keySequences = valid;
		}
		
		/**
		 * 
		 * @param	callback function wchich will be called after detecting shorctut.
		 * @param	rest keys of shortcut
		 * @return  ZvrKeyShortcut instance
		 */
		
		public static function addKeyShortcuts(callback:Function, ... rest):ZvrKeyShortcut
		{
			var ks:ZvrKeyShortcut = new ZvrKeyShortcut(rest, callback);
			keyShortcuts.push(ks);
			return ks;
		}
		
		public static function removeKeyShortcuts(callback:Function, ... rest):void
		{
			var valid:Array = new Array();
			for (var i:int = 0; i < keyShortcuts.length; i++) 
			{
				var ks:ZvrKeyShortcut = keyShortcuts[i];
				if (!(equals(rest, ks.sequence) && ks.callback.callback == callback))
				{
					valid.push(ks); 
				}
				else
				{
					ks.destroy();
				}
			}
			keyShortcuts = valid;
		}
		
	}

}