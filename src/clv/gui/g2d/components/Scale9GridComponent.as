package clv.gui.g2d.components 
{
	import clv.gui.core.Component;
	import com.genome2d.textures.GTexture;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Scale9GridComponent extends Component
	{
		private var _grid:Scale9GridSkin;
		
		public function Scale9GridComponent() 
		{
			_grid = new Scale9GridSkin();
			super(_grid);
		}
		public function get gridX1():Number 
		{
			return _grid.sprite.gridX1;
		}
		
		public function set gridX1(value:Number):void 
		{
			_grid.sprite.gridX1 = value;
		}
		
		public function get gridX2():Number 
		{
			return _grid.sprite.gridX2;
		}
		
		public function set gridX2(value:Number):void 
		{
			_grid.sprite.gridX2 = value;
		}
		
		public function get gridY1():Number 
		{
			return _grid.sprite.gridY1;
		}
		
		public function set gridY1(value:Number):void 
		{
			_grid.sprite.gridY1 = value;
		}
		
		public function get gridY2():Number 
		{
			return _grid.sprite.gridY2;
		}
		
		public function set gridY2(value:Number):void 
		{
			_grid.sprite.gridY2 = value;
		}
		
		public function get texture():GTexture 
		{
			return _grid.sprite.texture;
		}
		
		public function set texture(value:GTexture):void 
		{
			_grid.sprite.texture = value;
		}
		
	}

}