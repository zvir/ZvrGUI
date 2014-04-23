package zvr.zvrGUI.components.nd2d 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.geom.Rectangle;
	import zvr.zvrGUI.core.custom.ZvrContainerBase;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrND2DContainer extends ZvrContainerBase implements IZvrND2DComponent
	{
		
		public function ZvrND2DContainer(skinClass:Class, bodyClass:Class)
		{
			_maskingEnabled = false;
			super(skinClass, bodyClass);
			_maskingEnabled = false;
			
			if (_skin.shell)
			{
				node.setChildIndex(_skin.shell as Node2D, node.numChildren -1);
			}
			
		}
		
		override protected function updateMask():void 
		{
			super.updateMask();
			
			var c:Node2D = contents as Node2D;
			
			if (!_maskingEnabled) return;
			c.scrollRect = new Rectangle(
				-contents.x + contentPadding.left,
				-contents.y + contentPadding.top,
				(bounds.width - contentPadding.left - contentPadding.right), 
				(bounds.height - contentPadding.top - contentPadding.bottom)
				);
		}
		
		override public function set maskingEnabled(value:Boolean):void 
		{
			super.maskingEnabled = value;
			
			if (!node) return;
			var c:Node2D = contents as Node2D;
			if (value)
			{
				c.scrollRect = new Rectangle(
				-contents.x, 
				-contents.y, 
				(bounds.width - contentPadding.left - contentPadding.right), 
				(bounds.height - contentPadding.top - contentPadding.bottom)
				);
			}
			else
			{
				c.scrollRect = null;
				
			}
		}
		
		public function get node():Node2D
		{
			return Node2D(body);
		}
		
	}

}