package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.core.Container;
	import com.genome2d.textures.GTexture;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class BackgroudContainer extends Container
	{
		
		public function BackgroudContainer() 
		{
			super(new BackgroudContainerSkin());
		}
		
		public function set texture(t:GTexture):void
		{
			setStyle(ImageStyle.IMAGE, t);
		}
	}

}