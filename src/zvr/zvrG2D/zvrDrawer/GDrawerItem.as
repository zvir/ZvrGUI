package zvr.zvrG2D.zvrDrawer 
{
	import com.genome2d.context.GBlendMode;
	import com.genome2d.textures.GTexture;
	/**
	 * ...
	 * @author Zvir
	 */
	public class GDrawerItem 
	{
		public var index:int;
		
		public var x:Number = 0.0;
		public var y:Number = 0.0;
		
		public var rotation:Number = 0.0;
		
		public var scaleX:Number= 1.0;
		public var scaleY:Number = 1.0;
		
		public var alpha:Number = 1;
		
		public var visible:Boolean = true;
		
		public var red:Number = 1;
		public var blue:Number = 1;
		public var green:Number = 1;
		
		public var blendMode:int = GBlendMode.NORMAL;
		
		public var texture:GTexture;
		
		public function GDrawerItem() 
		{
			
		}
		
	}

}