package zvr.zvrLocalization 
{
	import be.boulevart.air.utils.ScreenManager;
	import com.blackmoon.theFew.view.utils.Loc;
	import de.nulldesign.nd2d.display.Node2D;
	import flash.display.NativeWindow;
	import flash.display.NativeWindowInitOptions;
	import flash.display.NativeWindowRenderMode;
	import flash.display.NativeWindowSystemChrome;
	import flash.display.Screen;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	import flash.utils.setTimeout;
	import zvr.zvrGUI.behaviors.ZvrDragable;
	import zvr.zvrGUI.behaviors.ZvrResizable;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.TextAreaMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.components.nd2d.ZvrND2DLabel;
	import zvr.zvrGUI.core.relays.ZvrSwitchGroup;
	import zvr.zvrGUI.core.ZvrApplication;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.core.ZvrScroll;
	import zvr.zvrGUI.events.ZvrLabelEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.LabelMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextAreaMDSkin;
	import zvr.zvrGUI.skins.zvrMinimalDarkFonts.MDFonts;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrKeyboard.ZvrKeyboard;
	import zvr.zvrLocalization.editElements.ItemsList;
	import zvr.zvrLocalization.phase.ZvrLocPhrase;
	import zvr.zvrLocalization.phase.ZvrLocTemplate;
	import zvr.zvrLocalization.ZvrLocItem;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrLocEdit 
	{
		
		private static function initialize():Boolean
		{
			
			app = new ZvrApplication();
			
			itemsList = new WindowMD();
			itemsList.title.text = "Items in Phrase";
			itemsList.right = 0;
			itemsList.width = 250;
			
			itemsList.top = 0;
			itemsList.bottom = 110;
			//itemsList.verticalCenter = 0;
			//itemsList.horizontalCenter = 0;
			itemsList.options.visible = false;
			
			itemsList.panel.scroller.customScroll = true;
			
			itemsListData = new ItemsList(itemsList.panel.scroller.verticalScroll, itemsList.panel.scroller.horizontalScroll);
			itemsListData.percentWidth = 100;
			itemsListData.percentHeight = 100;
			itemsList.addChild(itemsListData);
			
			editBox = new WindowMD();
			editBox.title.text = "ZvrLocalization Edid App v1.0";
			editBox.left = 0;
			editBox.right = 260;
			editBox.top = 0;
			editBox.bottom = 110;
			//editBox.verticalCenter = 0;
			//editBox.horizontalCenter = 0;
			editBox.options.visible = false;
			
			
			_textArea = new TextAreaMD();
			_textArea.scroll = editBox.panel.scroller;
			_textArea.top = 17;
			_textArea.bottom = 0;
			_textArea.percentWidth = 100;
			_textArea.wrap = true;
			_textArea.editable = true;
			_textArea.text = "TEST";
			_textArea.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Monaco);
			_textArea.setStyle(ZvrStyles.LABEL_FONT_SIZE, 16);
			
			editBox.panel.scroller.verticalScroll.boundsSnap = true;
			editBox.panel.scroller.verticalScroll.snapPrority = ZvrScroll.MAX;
			
			editBox.addChild(_textArea);
			editBox.panel.scroller.behaviors.getBehavior("DragScrolable").enabled = false;
			
			prewiev = new WindowMD();
			prewiev.title.text = "Phrase prewiev";
			prewiev.left = 0;
			prewiev.right = 0;
			prewiev.bottom = 0;
			prewiev.height = 100;
			prewiev.options.visible = false;
			
			prewievTextArea = new TextAreaMD();
			prewievTextArea.scroll = prewiev.panel.scroller;
			prewievTextArea.top = 0;
			prewievTextArea.bottom = 0;
			prewievTextArea.percentWidth = 100;
			prewievTextArea.wrap = true;
			//prewievTextArea.editable = true;
			prewievTextArea.text = "TEST";
			prewievTextArea.setStyle(ZvrStyles.LABEL_FONT, MDFonts.Monaco);
			prewievTextArea.setStyle(ZvrStyles.LABEL_FONT_SIZE, 16);
			
			prewiev.panel.scroller.verticalScroll.boundsSnap = true;
			prewiev.panel.scroller.verticalScroll.snapPrority = ZvrScroll.MAX;
			prewiev.panel.scroller.behaviors.getBehavior("DragScrolable").enabled = false;
			
			prewiev.addChild(prewievTextArea);
			
			app.addChild(editBox);
			app.addChild(itemsList);
			app.addChild(prewiev);
			
			
			var options:ZvrGroup = new ZvrGroup();
			options.percentWidth = 100;
			options.setLayout(ZvrHorizontalLayout);
			ZvrHorizontalLayout(options.layout).gap = 1;
			options.height = 17;
			
			var button:ButtonMD
			button = new ButtonMD();
			button.contentPadding.padding = 0;
			button.addEventListener(MouseEvent.CLICK, saveClick);
			button.label.text = "SAVE";
			options.addChild(button);
			
			//var button:ButtonMD
			button = new ButtonMD();
			button.contentPadding.padding = 0;
			button.addEventListener(MouseEvent.CLICK, upperCaseClick);
			button.label.text = "UPPER CASE";
			options.addChild(button);
			
			//var button:ButtonMD
			button = new ButtonMD();
			button.contentPadding.padding = 0;
			button.addEventListener(MouseEvent.CLICK, lowerCaseClick);
			button.label.text = "LOWER CASE";
			options.addChild(button);
			
			/*button = new ButtonMD();
			button.contentPadding.padding = 0;
			button.addEventListener(MouseEvent.CLICK, closeClick);
			button.label.text = "CLOSE";
			options.addChild(button);*/
			
			editBox.addChild(options);
			
			
			var langs:ZvrSwitchGroup = new ZvrSwitchGroup();
			langs.right = 0;
			langs.setLayout(ZvrHorizontalLayout);
			langs.autoSize = ZvrAutoSize.CONTENT;
			
			for (var i:int = 0; i < Loc.loc.langsTypes.length; i++) 
			{
				var b:ToggleButtonMD = new ToggleButtonMD();
				b.label.text = Loc.loc.langsTypes[i];
				langs.addChild(b);
				
				if (i == Loc.loc.currentLang) b.selected = true;
				
			}
			
			langs.addEventListener(ZvrSelectedEvent.SELECTED_CHANGE, langSelectedChanged);
			
			editBox.addChild(langs);
			
			return true;
		}
		
		private static const init:Boolean = initialize();
		
		static private var editBox:WindowMD;
		static private var _textArea:TextAreaMD;
		static private var app:ZvrApplication;
		static private var _currentTemplate:ZvrLocTemplate;
		static private var _currentItems:Array;
		static private var _currentItem:int;
		
		static public var localization:ZvrLocalization;
		
		private static var _dict:Dictionary = new Dictionary();
		static private var _currentTarget:Object;
		static private var nw:NativeWindow;
		
		static private var itemsList:WindowMD;
		static private var itemsListData:ItemsList;
		static private var prewiev:WindowMD;
		static private var prewievTextArea:TextAreaMD;
		
		static private function langSelectedChanged(e:ZvrSelectedEvent):void 
		{
			if (e.selected) 
			{
				trace(ToggleButtonMD(e.component).label.text);
				Loc.loc.setLang(ToggleButtonMD(e.component).label.text);
				initEdit(_currentTarget);
			}
		}
		
		public static function add(object:Object, t:ZvrLocTemplate):void
		{
			if (object is ZvrND2DLabel)
			{
				addZvrND2DLabel(object as ZvrND2DLabel, t);
			}
		}
		
		private static function addZvrND2DLabel(zvrND2DLabel:ZvrND2DLabel, t:ZvrLocTemplate):void 
		{
			zvrND2DLabel.node.addEventListener(MouseEvent.CLICK, nd2dClick);
			zvrND2DLabel.node.mouseEnabled = true;
			_dict[zvrND2DLabel.node] = t;
		}
		
		private static function nd2dClick(e:MouseEvent):void 
		{
			ZvrKeyboard.CTRL.pressed && initEdit(e.currentTarget);
		}
		
		public static function editND2DLabel(label:ZvrND2DLabel):void
		{
			initEdit(label.node);
		}
		
		private static function initEdit(currentTarget:Object):void 
		{
			if (!nw)
			{
				var nwo:NativeWindowInitOptions = new NativeWindowInitOptions()
				nwo.maximizable = false;
				nwo.renderMode = NativeWindowRenderMode.DIRECT;
				nwo.systemChrome = NativeWindowSystemChrome.STANDARD;
				
				
				nw = new NativeWindow(nwo);
				nw.minSize = new Point(800, 400);
				nw.width = 800;
				nw.height = 400;
				nw.title = "ZvrLocalization Editor v1.0";
				nw.stage.color = 0x000000;
				
				nw.stage.scaleMode = StageScaleMode.NO_SCALE;
				nw.stage.align = StageAlign.TOP_LEFT;
				
				ScreenManager.openWindowCenteredOnMainScreen(nw);
				
				nw.stage.addChild(app);
				
				nw.activate();
				
				nw.addEventListener(Event.CLOSE, windowClose);
				
				nw.stage.addEventListener(Event.ENTER_FRAME, enterFrame);
				
				
			}
			
			nw.restore();
			nw.orderToFront();
			nw.activate();
			
			_currentTarget = currentTarget;
			_currentTemplate = _dict[currentTarget];
			_currentItems = localization.getItemsFromTemplate(_currentTemplate);
			
			itemsListData.update(_currentItems);
			
			itemsList.title.text = "Items in Phrase ("+_currentItems.length+")";
			
			currentItem = _currentItems[0];
			
			textChange();
			
		}
		
		static public function set currentItem(item:ZvrLocItem):void
		{
			var i:int = _currentItems.indexOf(item);
			
			if (i == -1) throw new Error("Error");
			
			_currentItem = i;
			
			editBox.status.text = "[" + _currentItems[_currentItem].currentText + "] " + _currentItems[_currentItem].name;
			
			_textArea.text = _currentItems[_currentItem].text;
		}
		
		static private function saveClick(e:MouseEvent):void 
		{
			var x:* = _currentItems[_currentItem].xml;
			x.parent().children()[x.childIndex()] = _textArea.text;
			_currentItems[_currentItem].contentItem.save();
			_currentItems[_currentItem].updateTFs();
			textChange();
			itemsListData.update(_currentItems);
		}
		
		
		static private function windowClose(e:Event):void 
		{
			nw.stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			nw.stage.removeChild(app);
			nw = null;
		}
		
		static private function enterFrame(e:Event):void 
		{
			nw.height ++;
			nw.stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		static private function textChange():void 
		{
			prewievTextArea.text = localization.getTemplateText(_currentTemplate);
		}
		
		static private function lowerCaseClick(v:MouseEvent):void 
		{
			var t:TextField = LabelMDSkin(_textArea.skin).textField;
			var b:int = t.selectionBeginIndex;
			var e:int = t.selectionEndIndex;
			
			if (b == 0 && e == 0)
			{
				_textArea.text = _textArea.text.toLowerCase();
			}
			else
			{
				var s:String = _textArea.text;
				_textArea.text = s.substring(0, b) + s.substring(b, e).toLowerCase() + s.substring(e);
			}
			
		}
		
		static private function upperCaseClick(v:MouseEvent):void 
		{
			var t:TextField = LabelMDSkin(_textArea.skin).textField;
			var b:int = t.selectionBeginIndex;
			var e:int = t.selectionEndIndex;	
			
			if (b == 0 && e == 0)
			{
				_textArea.text = _textArea.text.toUpperCase();
			}
			else
			{
				var s:String = _textArea.text;
				_textArea.text = s.substring(0, b) + s.substring(b, e).toUpperCase() + s.substring(e);
			}
		}
		
	}

}