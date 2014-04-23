package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.common.styles.ImageStyleCrop;
	import clv.gui.core.behaviors.IPointerComponent;
	import clv.gui.core.Component;
	import clv.gui.core.Pointer;
	import clv.gui.core.skins.Skin;
	import clv.gui.g2d.display.IG2DPointerComponent;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class SpriteComponent extends Component implements IG2DPointerComponent
	{
		private var spriteSkin:SpriteComponetnSkin;
		
		private var _node:GNode;
		
		private var _pointer:Pointer = new Pointer();
		
		public function SpriteComponent() 
		{
			spriteSkin = new SpriteComponetnSkin();
			super(spriteSkin);
			_node = spriteSkin.skinNode;
		}
		
		public function setCoropFill():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.FILL);
		}
		
		public function setCoropNoScale():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.NO_SCALE);
		}
		
		public function setCoropInside():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.INSIDE);
		}
		
		public function setCoropOutside():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.OUTSIDE);
		}
		
		public function get pointer():Pointer 
		{
			return _pointer;
		}
		
		public function set texture(t:GTexture):void
		{
			setStyle(ImageStyle.IMAGE, t);
		}
		
		public function get node():GNode
		{
			return _node;
		}
		
	}

}