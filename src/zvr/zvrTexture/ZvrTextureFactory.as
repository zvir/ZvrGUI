package zvr.zvrTexture 
{
	import flash.display.BitmapData;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTextureFactory 
	{
		private var _bitmapClass:Class;
		private var _bitmapData:BitmapData;
		
		public function ZvrTextureFactory(bitmapClass:Class) 
		{
			_bitmapClass = bitmapClass;
		}
		
		public function get bitmapData():BitmapData
		{
			
			if (!_bitmapData)
			{
				_bitmapData = new _bitmapClass().bitmapData;
			}
			
			return _bitmapData;
		}
		
	}

}