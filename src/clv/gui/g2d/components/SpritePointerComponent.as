package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.common.styles.ImageStyleCrop;
	import clv.gui.core.behaviors.IPointerComponent;
	import clv.gui.core.Component;
	import clv.gui.core.Pointer;
	import clv.gui.core.skins.Skin;
	import clv.gui.g2d.display.G2DPointerComponent;
	import clv.gui.g2d.display.IG2DPointerComponent;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SpritePointerComponent extends SpriteComponent implements IG2DPointerComponent
	{

		private var _pointerComponent:G2DPointerComponent;
		private var _pointer:Pointer;
		
		public function SpritePointerComponent() 
		{
			super();
			
			_pointer = new Pointer();
			_pointerComponent = G2DPointerComponent.addTo(this);
			
			node.mouseEnabled = true;
		}
		
		public function get pointer():Pointer 
		{
			return _pointer;
		}
		
	}

}