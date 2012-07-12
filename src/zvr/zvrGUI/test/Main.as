package zvr.zvrGUI.test
{
	
	import adobe.utils.CustomActions;
	import away3d.test.Panel;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormatAlign;
	import flash.utils.clearTimeout;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	import net.hires.debug.Stats;
	import utils.color.toHexString;
	import zvr.zvrComps.zvrTool.ZvrTool;
	import zvr.zvrGUI.components.minimalDark.ButtonMD;
	import zvr.zvrGUI.components.minimalDark.LabelMD;
	import zvr.zvrGUI.components.minimalDark.LinearChartMD;
	import zvr.zvrGUI.components.minimalDark.PanelMD;
	import zvr.zvrGUI.components.minimalDark.ScrollerMD;
	import zvr.zvrGUI.components.minimalDark.ToggleButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowMD;
	import zvr.zvrGUI.components.minimalDark.WindowOptionsButtonMD;
	import zvr.zvrGUI.components.minimalDark.WindowStackItemMD;
	import zvr.zvrGUI.components.minimalDark.WindowStackMD;
	import zvr.zvrGUI.components.minimalDark.WindowTitleMD;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrAutoSize;
	import zvr.zvrGUI.core.ZvrBitmap;
	import zvr.zvrGUI.core.ZvrGroup;
	import zvr.zvrGUI.events.ZvrContainerEvent;
	import zvr.zvrGUI.events.ZvrComponentEvent;
	import zvr.zvrGUI.events.ZvrStateChangeEvent;
	import zvr.zvrGUI.layouts.ZvrAlignment;
	import zvr.zvrGUI.layouts.ZvrButtonLayout;
	import zvr.zvrGUI.layouts.ZvrHorizontalAlignment;
	import zvr.zvrGUI.layouts.ZvrVerticalLayout;
	import zvr.zvrGUI.layouts.ZvrHorizontalLayout;
	import zvr.zvrGUI.skins.zvrMinimalDark.TextureFillsMD;
	import zvr.zvrGUI.skins.ZvrStyles;
	import zvr.zvrGUI.vo.charts.Chart;
	import zvr.zvrKeyboard.ZvrKeyboard;
	import zvr.ZvrTools.ZvrCompilationDate;
	
	/**
	 * ...
	 * @author Michał Zwieruho "Zvir"
	 */
	
	// core:
	// TODO: DEBUG VIEW OF LAYOUTING AND EVERYTHING GOING ON WITH COMPONENT!
	// TODO: COMPLEX TEST APLICATION
	// TODO: INITIALIZATION // MASS CHANGE MODE DURING CREATION/SETUP (INCLUDING LAYOUTS);
	// CSS
	// TODO: styles values to component protperties // DONE but there is conflict between clasic vales not overriding styles 
	// TODO: intros and autros
	// TODO: think of transitions
	// TODO: delegateState heierarchy?
	
	// Componentes
	// TODO: Input (lable in / outside input, autocompletition, validation, deafult value)
	// TODO: Icon on Button
	// TODO: checkBox/swich
	// TODO: radiogroup
	// TODO: textField
	// TODO: Button with shourtcut
	// TODO: Behaviors
	// TODO: label text cut (with...)
	
	public class Main extends Sprite
	{
		private var chart:LinearChartMD;
		private var k:int = 0;
		private var mem:Chart;
		private var testChart:Chart;
		private var fps:Chart;
		private var ct:int;
		private var window3:WindowMD;
		
		private var _delItv:int;
		private var _ws:WindowStackMD;
		
		[Embed(source = "../../../../assets/windowTitleOptions/close.png")]
		private var _close:Class;
		private var _closeBD:BitmapData = Bitmap(new _close()).bitmapData;
		
		public function Main():void
		{
			//wch("ZvrComponent", "comps created", 0);
			//wch("ZvrComponent", "comps on stage", 0);
			
			trc(this, "Main Created");
			
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			trc(this, "init");
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
			
			/*var toggleButton:ButtonMD = new ButtonMD();
			toggleButton.label.text = "ZvrTool TestTestTest TestTestTest TestTestTest";
			toggleButton.x = 10;
			toggleButton.y = 10;
			addChild(toggleButton);
			trace("aaaaaaa", toggleButton.label.independentBounds.height);
			trace("aaaaaaa", toggleButton.bounds.height);
			trace("aaaaaaa", toggleButton.contentRect.height);
			
			return;
			*/
			
			var tool:ZvrTool = new ZvrTool();
			tool.setDocumentClass(this);
			addChild(tool);
			
			
			tgr("Test 0").setFunction(tgrTest).setParams("test 0", 1234);
			tgr("Test 1").setFunction(tgrTest).setParams("test 2", 1234);
			tgr("Test 2").setFunction(tgrTest).setParams("test 3", 1234);
			tgr("Test 3").setFunction(tgrTest).setParams("test 4", 1234);
			tgr("Test 4").setFunction(tgrToogleTest).setToggle(true);
			tgr("Test 4").setFunction(tgrToogleTest).setToggle(true);
			tgr("Test 5").setFunction(tgrToogleTest2);
			
			var p:PanelMD = new PanelMD();
			addChild(p);
			p.scroller.name = "testPanel";
			p.width = 200;
			p.height = 300;
			p.x = 400;
			p.y = 250;
			
			p.setLayout(ZvrVerticalLayout);
			
			var l:LabelMD;
			
			l = new LabelMD();
			l.text = "autoSize";
			l.labelAutoSize = true;
			p.addChild(l);
			
			l = new LabelMD();
			l.text = "width 350 left";
			l.width = 350;
			l.align = TextFormatAlign.LEFT;
			l.labelAutoSize = false;
			p.addChild(l);
			
			l = new LabelMD();
			l.text = "width 350 right";
			l.width = 350;
			l.align = TextFormatAlign.RIGHT;
			l.labelAutoSize = false;
			p.addChild(l);
			
			l = new LabelMD();
			l.text = "width 350 center";
			l.width = 350;
			l.labelAutoSize = false;
			l.align = TextFormatAlign.CENTER;
			p.addChild(l);
			
			l = new LabelMD();
			l.text = "Implicit coercion of a value of type Class to an unrelated type Number.";
			l.width = 150;
			l.labelAutoSize = false;
			l.cutLabel = true;
			p.addChild(l);
			
			
			var g:ZvrGroup = new ZvrGroup();
			g.setLayout(ZvrHorizontalLayout);
			g.left = 10;
			g.right = 10;
			g.autoSize = ZvrAutoSize.CONTENT_HEIGHT;
			p.addChild(g);
			
			var icon:ZvrBitmap = new ZvrBitmap();
			icon.verticalCenter = 0;
			icon.left = 3;
			icon.setStyle(ZvrStyles.COLOR_ALPHA, 0);
			icon.setStyle(ZvrStyles.BITMAP, TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_WHITE));
			g.addChild(icon);
			
			l = new LabelMD();
			l.text = "left right 0";
			l.left = 0;
			l.right = 0;
			l.labelAutoSize = false;
			g.addChild(l);
			
			var b:ButtonMD;
			
			b = new ButtonMD();
			b.name = "TestButton";
			b.label.text = "Test Button"
			
			p.addChild(b);
			
			b = new ButtonMD();
			b.name = "manual";
			b.label.text = "Test Button H C M";
			//b.width = 150;
			//b.height = 50;
			//b.autoSize = ZvrAutoSize.MANUAL;
			p.addChild(b);
			
			b = new ButtonMD();
			b.name = "manual2";
			b.label.text = "";
			b.buttonLayout.alignment = ZvrAlignment.VERTICAL
			b.width = 150;
			b.height = 50;
			b.autoSize = ZvrAutoSize.MANUAL;
			
			b.addEventListener(MouseEvent.CLICK, buttonClick);
			
			p.addChild(b);
			
			
			var tb:ToggleButtonMD = new ToggleButtonMD();
			
			p.addChild(tb);
			tb.label.text = tb.currentStates.join(", ");
			tb.addEventListener(ZvrStateChangeEvent.CHANGE, tbStateChange);
			tb.autoSize = ZvrAutoSize.MANUAL;
			tb.width = 150;
			ZvrButtonLayout(tb.layout).horizontalAlign = ZvrHorizontalAlignment.CENTER;
			tr(b.width, b.contentPadding.left, b.contentPadding.right);
			
			//createTextfield();
			
			
			
			/*var w:TestDelegate = new TestDelegate();
			
			addChild(w);*/
			
			/*
			var p:PanelMD = new PanelMD();
			addChild(p);
			
			var s:ScrollerMD = new ScrollerMD();
			addChild(s);
			
			p.setLayout(ZvrHorizontalLayout);
			p.addChild(new PanelMD);
			p.addChild(new PanelMD);
			p.addChild(new PanelMD);
			p.addChild(new PanelMD);
			s.autoSize = ZvrAutoSize.CONTENT;*/
			//return;
			
			var t:String = "Nulla ultrices sollicitudin nisl quis pellentesque."
			
			
			
			trc(this, "test muliline", "", t);
			trc(this, "test muliline", "", t);
			
			/*_ws = new WindowStackMD();
			_ws.x = 50;
			_ws.y = 50;
			
			addChild(_ws);
			
			ZvrKeyboard.P.addPressedCallback(changeViewStack).setArgs(1);
			ZvrKeyboard.P.addPressingCallback(changeViewStack).setArgs(1);
			ZvrKeyboard.O.addPressedCallback(changeViewStack).setArgs(-1);
			ZvrKeyboard.O.addPressingCallback(changeViewStack).setArgs(-1);
			ZvrKeyboard.L.addPressedCallback(addViewStack);
			ZvrKeyboard.K.addPressedCallback(removeViewStack);*/
			
			//var w:WindowMD = new WindowMD();
			//addChild(w);
			//w.width = 200;
			
			addEventListener(Event.ENTER_FRAME, enterFrame);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			ZvrKeyboard.init(stage);
			
			ZvrKeyboard.addKeySequenceCallback(sqTest, ZvrKeyboard.Z, ZvrKeyboard.V, ZvrKeyboard.R).setTimeOut(500);
			
			ZvrKeyboard.addKeySequenceCallback(sqTest2, ZvrKeyboard.Q, ZvrKeyboard.W, ZvrKeyboard.E);
			
			ZvrKeyboard.addKeyShortcuts(sequenceCallback, ZvrKeyboard.CTRL, ZvrKeyboard.Y).setCallbackOnPressing(true).callback.setArgs("fuck");
			
			ZvrKeyboard.T.addPressedCallback(Tpressed);
			ZvrKeyboard.T.addPressingCallback(Tpressing);
			ZvrKeyboard.T.addReleasedCallback(Treleased);
			
			for (var i:int = 0; i < 50; i++) 
			{
				trc(this, "test", "", Math.random(), getTimer());
			}
			
			
			
		}
		
		private function tgrToogleTest2():void 
		{
			tr("tgrToogleTest2");
		}
		
		private function tgrToogleTest(value:Boolean):void 
		{
			tr("tgrToogleTest", value);
		}
		
		private function tgrTest(s:String, n:Number):void 
		{
			tr(s, n);
		}
		
		private function tbStateChange(e:ZvrStateChangeEvent):void 
		{
			ToggleButtonMD(e.component).label.text = e.currentStates.join(", ");
		}
		
		private function buttonClick(e:MouseEvent):void 
		{
			/*ButtonMD(e.target).contentPadding.top = ButtonMD(e.target).contentPadding.top == 10 ? 0 : 10;
			ButtonMD(e.target).contentPadding.left = ButtonMD(e.target).contentPadding.left == 10 ? 0 : 10;
			ButtonMD(e.target).contentPadding.right = ButtonMD(e.target).contentPadding.right == 10 ? 0 : 10; 
			ButtonMD(e.target).contentPadding.bottom = ButtonMD(e.target).contentPadding.bottom == 10 ? 0 : 10;*/
			
			tr("----------------");
			ButtonMD(e.target).enterMassChangeMode();
			if (ButtonMD(e.target).icon.bitmap)
			{
				tr("> icon change");
			ButtonMD(e.target).icon.bitmap = 
				ButtonMD(e.target).icon.bitmap.width != 64 ? 
					TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_64) : TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_32)
			}
			else
			{
				tr("> icon change");
				ButtonMD(e.target).icon.bitmap = TextureFillsMD.getBitmapData(TextureFillsMD.CELAVRA_LOGO_16)
			}
			
			//ButtonMD(e.target).icon.setStyle(ZvrStyles.COLOR, 0xff0000);
			tr("> autoSize");
			ButtonMD(e.target).autoSize = ButtonMD(e.target).autoSize == ZvrAutoSize.CONTENT ? ZvrAutoSize.MANUAL : ZvrAutoSize.CONTENT;
			
			if (ButtonMD(e.target).autoSize == ZvrAutoSize.MANUAL)
			{
				tr("> width");
				ButtonMD(e.target).width = 150;
				tr("> height");
				ButtonMD(e.target).height = 100;
			}
			else
			{
				tr("> width");
				ButtonMD(e.target).width = 155;
				tr("> height");
				ButtonMD(e.target).height = 105;
			}
			tr("> label");
			ButtonMD(e.target).label.text = ButtonMD(e.target).label.text == "" ? "V C M" : "";
			tr("> exitMassChangeMode");
			ButtonMD(e.target).exitMassChangeMode();
		}
		
		private function removeViewStack():void
		{
			_ws.removeView(_ws.currentView);
		}
		
		private function addViewStack():void
		{
			var b:WindowStackItemMD;
			b = new WindowStackItemMD();
			b.title.text = "Tab " + _ws.viewsNum;
			
			var bt:ButtonMD
			bt = new ButtonMD()
			bt.label.text = "test  " + getTimer();
			bt.left = 10;
			bt.top = 10;
			b.addChild(bt);
			
			_ws.addView(b);
		}
		
		private function changeViewStack(delta:int):void
		{
			tr("changeViewStack");
			_ws.selectedIndex += delta;
		}
		
		private function sequenceCallback(s:String):void
		{
			tr("sequenceCallback", s);
		}
		
		private function Treleased():void
		{
			tr("Treleased");
		}
		
		private function Tpressing():void
		{
			tr("Tpressing");
		}
		
		private function Tpressed():void
		{
			tr("Tpressed");
		}
		
		private function sqTest():void
		{
			tr("ZVR !!");
			//ZvrKeyboard.removeKeySequenceCallback(sqTest, ZvrKeyboard.Z, ZvrKeyboard.V, ZvrKeyboard.R);
		}
		
		private function sqTest2():void
		{
			tr("sqTest !!");
		}
		
		private function mouseMove(e:MouseEvent):void
		{
			//trc(this, "update", "mouseMove", "mouseX", mouseX, "mouseY", mouseY);
			
			wch(this, "mouseX", mouseX);
			wch(this, "mouseY", mouseY);
			
			//clearTimeout(_delItv);
			//_delItv = setTimeout(deleteWath, 1000);
		
		}
		
		private function deleteWath():void
		{
			wch(this, "mouseX", mouseX, true);
			wch(this, "mouseY", mouseY, true);
		}
		
		private function enterFrame(e:Event):void
		{
			/*if (Math.random() < 0.01)
			{
				//trc(this, "test message", "", getTimer(), getTimer(), getTimer());
			}
			
			if (Math.random() < 0.1)
			{
				var t:String = "Nulla ultrices sollicitudin nisl quis pellentesque. Mauris lorem libero, porta a ullamcorper pharetra, tempus vitae est. Duis eu egestas dolor. Nunc ac massa felis. Suspendisse ultrices metus mi, et vehicula lorem. Sed at risus in nisl luctus ultrices id nec velit. Cras odio tortor, sodales in eleifend ac, semper ut tortor. Sed placerat, metus vitae rhoncus dictum, enim dolor fermentum sapien, eget commodo sapien libero quis tellus. Sed gravida, neque vitae mollis condimentum, ante nisl vehicula nisl, accumsan ultrices dolor est pellentesque dolor. Donec tincidunt, magna nec accumsan fermentum, lectus sapien scelerisque est, dignissim iaculis quam nisl et lacus. Cras iaculis imperdiet consectetur. Ut neque mi, dictum et scelerisque convallis, dictum at dolor. Aliquam erat volutpat. Integer risus sapien, tincidunt vitae viverra at, sagittis varius lacus. Etiam a pulvinar lectus. Curabitur porttitor aliquet metus, non sagittis elit posuere sit amet."
				
					//tr("test "+t.substr(0, 500), "!!!");
			}*/
		
			wch("this", "focus", stage.focus);
		}
		
		private function resized(e:ZvrComponentEvent):void
		{
			//trace(ZvrContainer(e.component).getElementAt(0)); 
			//trace(ZvrContainer(e.component).getElementAt(0).bounds.x, ZvrContainer(e.component).getElementAt(0).bounds.x); 
		}
		
		private function contentSizeChanged(e:ZvrContainerEvent):void
		{
			//trace(e.cointainer.contentRect, e.cointainer.bounds);
		}
		
		private function testClick(e:MouseEvent):void
		{
			//trace(e.currentTarget);
			// e.currentTarget.height = 100;
		}
		
		private function createTextfield():void
		{
			var sp:Sprite = new Sprite();
			sp.buttonMode = true;
			var tf:TextField = new TextField();
			sp.x = Math.random()*500;
			sp.y = Math.random()*500;
			sp.addChild(tf);
			tf.text = "test test";
			tf.type = TextFieldType.INPUT;
			tf.background = true;
			tf.selectable = true;
			tf.border = true;
			sp.doubleClickEnabled = true;
			sp.addEventListener(MouseEvent.DOUBLE_CLICK, doubleClick);
			addChild(sp);
			sp.graphics.beginFill(0x00ff00);
			sp.graphics.drawRect(0, 110, 100, 20);
			sp.graphics.endFill();
			sp.addEventListener(FocusEvent.FOCUS_IN, focusIn);
			sp.addEventListener(FocusEvent.FOCUS_OUT, focusOut);
			
		}
		
		private function focusOut(e:FocusEvent):void 
		{
			tr("focus out");
		}
		
		private function focusIn(e:FocusEvent):void 
		{
			tr("focus in");
		}
		
		private function doubleClick(e:MouseEvent):void 
		{
			removeChild(e.currentTarget as DisplayObject);
			
			InteractiveObject(e.target).removeEventListener(FocusEvent.FOCUS_IN, focusIn);
			InteractiveObject(e.target).removeEventListener(FocusEvent.FOCUS_OUT, focusOut);
			
			tr(stage.focus);
			
			createTextfield();
		}
		
	}

}