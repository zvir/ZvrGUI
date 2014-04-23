package clv.gui.g2d.skinElements 
{
	import clv.gui.core.display.IComponentBody;
	import clv.gui.core.display.ISkinBody;
	import zvr.zvrG2D.FNTNode;
	import zvr.zvrG2D.G2DFont;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class FNTSkinBody extends FNTNode implements ISkinBody, IComponentBody
	{
		
		public function FNTSkinBody(font:G2DFont = null, p_name:String="") 
		{
			super(font, p_name);
		}

		public function set x(value:Number):void 
		{
			transform.x = value;
		}
		
		public function set y(value:Number):void 
		{
			transform.y = value;
		}
		
		public function set visible(value:Boolean):void 
		{
			visible = value;
		}
		
		public function get displayBody():* 
		{
			return this;
		}
		
	}

}