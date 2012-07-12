package zvr.zvrGUI.behaviors 
{
		/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrBehaviors 
	{
		
		public static const DRAGABLE		:String = "Dragable"
		public static const BUTTON			:String = "Button"
		public static const BRING_TO_FRONT	:String = "BringToFront"
		
		public static function get(name:String):ZvrBehavior
		{
			switch (name) 
			{
				case DRAGABLE: return new ZvrDragable(); break;
				case BUTTON: return new ZvrButtonBehavior(); break;
				case BRING_TO_FRONT: return new ZvrBringToFrontBehavior(); break;
			}
			
			return null;
		}
		
	}

}