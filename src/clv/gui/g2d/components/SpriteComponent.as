package clv.gui.g2d.components 
{
	import clv.gui.common.styles.ImageStyle;
	import clv.gui.common.styles.ImageStyleCrop;
	import clv.gui.common.styles.ImageStyleSize;
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
	public class SpriteComponent extends Component
	{
		protected var spriteSkin:SpriteComponetnSkin;
		
		protected var _node:GNode;
		
		public function SpriteComponent() 
		{
			spriteSkin = new SpriteComponetnSkin();
			super(spriteSkin);
			_node = spriteSkin.skinNode;
		}
		
		public function setCropFill():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.FILL);
		}
		
		public function setCropNoScale():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.NO_SCALE);
		}
		
		public function setCropInside():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.INSIDE);
		}
		
		public function setCropOutside():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.OUTSIDE);
		}
		
		public function set texture(t:GTexture):void
		{
			setStyle(ImageStyle.IMAGE, t);
		}
		
		public function setIndependedSize():void
		{
			setStyle(ImageStyle.CROP, ImageStyleCrop.NO_SCALE);
			setStyle(ImageStyle.SIZE, ImageStyleSize.COMPONENT);
		}
		
		public function get node():GNode
		{
			return _node;
		}
		
		public function get alpha():Number 
		{
			return getStyle(ImageStyle.ALPHA);
		}
		
		public function set alpha(value:Number):void 
		{
			setStyle(ImageStyle.ALPHA, value);
		}
		
		public function get scale():Number 
		{
			return getStyle(ImageStyle.ALPHA);
		}
		
		public function set scale(value:Number):void 
		{
			setStyle(ImageStyle.SCALE, value);
		}
		
	}

}