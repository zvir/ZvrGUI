package zvr.zvrND2D 
{
	import de.nulldesign.nd2d.display.Node2D;
	import de.nulldesign.nd2d.display.Sprite2D;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class TintResistandSprite2D extends Sprite2D 
	{
		
		public function TintResistandSprite2D(textureObject:Texture2D=null) 
		{
			super(textureObject);
			
		}
		
		override public function updateColors():void 
		{
			invalidateColors = false;
			
			if(hasPremultipliedAlphaTexture) {
				combinedColorTransform.redMultiplier = _colorTransform.redMultiplier * _alpha;
				combinedColorTransform.greenMultiplier = _colorTransform.greenMultiplier * _alpha;
				combinedColorTransform.blueMultiplier = _colorTransform.blueMultiplier * _alpha;
				combinedColorTransform.alphaMultiplier = _colorTransform.alphaMultiplier * _alpha;
			} else {
				combinedColorTransform.redMultiplier = _colorTransform.redMultiplier;
				combinedColorTransform.greenMultiplier = _colorTransform.greenMultiplier;
				combinedColorTransform.blueMultiplier = _colorTransform.blueMultiplier;
				combinedColorTransform.alphaMultiplier = _colorTransform.alphaMultiplier * _alpha;
			}

			combinedColorTransform.redOffset = _colorTransform.redOffset;
			combinedColorTransform.greenOffset = _colorTransform.greenOffset;
			combinedColorTransform.blueOffset = _colorTransform.blueOffset;
			combinedColorTransform.alphaOffset = _colorTransform.alphaOffset;
			
			/*if (parent)
			{
				combinedColorTransform.concat(parent.combinedColorTransform);
			}*/
			
			nodeIsTinted = (combinedColorTransform.redMultiplier != 1.0 ||
					combinedColorTransform.greenMultiplier != 1.0 ||
					combinedColorTransform.blueMultiplier != 1.0 ||
					combinedColorTransform.alphaMultiplier != 1.0 ||
					combinedColorTransform.redOffset != 0.0 ||
					combinedColorTransform.greenOffset != 0.0 ||
					combinedColorTransform.blueOffset != 0.0 ||
					combinedColorTransform.alphaOffset != 0.0);

			for each(var child:Node2D in children) {
				child.updateColors();
			}
			
			
		}
		
	}

}