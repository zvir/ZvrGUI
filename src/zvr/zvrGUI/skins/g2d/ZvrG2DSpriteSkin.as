package zvr.zvrGUI.skins.g2d 
{
	import com.genome2d.components.renderables.GSprite;
	import com.genome2d.node.GNode;
	import com.genome2d.textures.GTexture;
	import zvr.zvrGUI.components.g2d.ZvrG2DBody;
	import zvr.zvrGUI.components.g2d.ZvrG2DComponent;
	import zvr.zvrGUI.skins.base.IZvrSkinLayer;
	import zvr.zvrGUI.skins.base.ZvrSkin;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DSpriteSkin extends ZvrSkin
	{
		private var _sprite:GSprite;
		private var _node:GNode;
		
		private var _autoSizeToTexture:Boolean = true;
		
		public function ZvrG2DSpriteSkin(component:ZvrG2DComponent, registration:Function) 
		{
			super(component, registration);
		}
		
		override protected function create():void 
		{
			_body =  new ZvrG2DBody() as IZvrSkinLayer;
			_node = _body as GNode;
			_sprite = _node.addComponent(GSprite) as GSprite;	
		}
		
		override protected function registerStyles():void 
		{
			super.registerStyles();
			
			registerStyle(ZvrG2DStyles.TEXTURE, setTexture);
			
		}
		
		private function setTexture():void 
		{
			_sprite.texture = getStyle(ZvrG2DStyles.TEXTURE);
			updateSizeToTexture();
		}
		
		private function updateSizeToTexture():void 
		{
			
			var g:GTexture = _sprite.texture;
			
			_node.transform.x = g.width / 2;
			_node.transform.y = g.height / 2;
			
			if (_autoSizeToTexture) updateComponentSize(g.width, g.height);
		}
		
		override protected function updateSize():void 
		{
			super.updateSize();
			
			if (_autoSizeToTexture) return;
			
			var g:GTexture = _sprite.texture;
			
			_node.transform.scaleX = componentWidth / g.width;
			_node.transform.scaleY = componentHeight / g.height;
			
			_node.transform.x = componentWidth / 2;
			_node.transform.y = componentHeight / 2;
			
		}
		
		public function get autoSizeToTexture():Boolean 
		{
			return _autoSizeToTexture;
		}
		
		public function set autoSizeToTexture(value:Boolean):void 
		{
			_autoSizeToTexture = value;
			updateSizeToTexture();
		}
		
		public function get sprite():GSprite 
		{
			return _sprite;
		}
		
		
		
	}

}