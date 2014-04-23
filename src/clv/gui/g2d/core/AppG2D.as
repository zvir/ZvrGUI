package clv.gui.g2d.core 
{
	import clv.gui.core.Application;
	import clv.gui.g2d.display.G2DGuiBody;
	import com.genome2d.context.stats.GStats;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TouchEvent;
	import flash.geom.Rectangle;
	import flash.ui.Multitouch;
	import flash.ui.MultitouchInputMode;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class AppG2D extends Application
	{
		
		public function AppG2D() 
		{
			super(new SkinAppG2D());
		}
		
		override public function update(cell:Rectangle):void 
		{
			super.update(cell);
			
			GStats.customStats = ["GUI: "+updates];
		}
		
	}

}