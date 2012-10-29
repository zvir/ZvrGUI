package zvr.zvrND2D
{
	import de.nulldesign.nd2d.materials.AMaterial;
	import de.nulldesign.nd2d.geom.Face;
	import de.nulldesign.nd2d.geom.UV;
	import de.nulldesign.nd2d.geom.Vertex;
	import de.nulldesign.nd2d.materials.shader.ShaderCache;
	import de.nulldesign.nd2d.materials.Sprite2DMaterial;
	import de.nulldesign.nd2d.materials.texture.ASpriteSheetBase;
	import de.nulldesign.nd2d.materials.texture.Texture2D;
	import zvr.zvrKeyboard.ZvrKeyboard;
	
	import flash.display3D.Context3D;
	import flash.display3D.Context3DProgramType;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.textures.Texture;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author Zvir
	 */
	public class Sprite2DBitmapMaterial extends Sprite2DMaterial
	{
		
		private var _customWidth:Number;
		private var _customHeight:Number;
		
		private var _customX:Number;
		private var _customY:Number;
		
		public function Sprite2DBitmapMaterial()
		{
			drawCalls = 1;	
		}
		
		
		override protected function prepareForRender(context:Context3D):void
		{
			//super.prepareForRender(context);
			if(previousTintedState != nodeTinted) {
				shaderData = null;
				initProgram(context);
				previousTintedState = nodeTinted;
			}

			context.setProgram(shaderData.shader);
			context.setBlendFactors(blendMode.src, blendMode.dst);

			if(needUploadVertexBuffer) {
				needUploadVertexBuffer = false;
				vertexBuffer.uploadFromVector(mVertexBuffer, 0, mVertexBuffer.length / shaderData.numFloatsPerVertex);
			}
			
			var uvOffsetAndScale:Rectangle = new Rectangle(0.0, 0.0, 1.0, 1.0);
			
			
			var textureObj:Texture = texture.getTexture(context);
			
			if (spriteSheet)
			{
				
				uvOffsetAndScale = spriteSheet.getUVRectForFrame(texture.textureWidth, texture.textureHeight);
				
				var offset:Point = spriteSheet.getOffsetForFrame();
				
				clipSpaceMatrix.identity();
				clipSpaceMatrix.appendScale(spriteSheet.spriteWidth >> 1, spriteSheet.spriteHeight >> 1, 1.0);
				clipSpaceMatrix.appendTranslation(offset.x, offset.y, 0.0);
				clipSpaceMatrix.append(modelMatrix);
				clipSpaceMatrix.append(viewProjectionMatrix);
				
			}
			else
			{
				clipSpaceMatrix.identity();
				clipSpaceMatrix.appendScale((isNaN(_customWidth) ? texture.textureWidth : _customWidth) >> 1, (isNaN(_customHeight) ? texture.textureHeight : _customHeight) >> 1, 1.0);
				clipSpaceMatrix.appendTranslation((isNaN(_customX) ? 0 : _customX), (isNaN(_customY) ? 0 : _customY), 0.0);
				clipSpaceMatrix.append(modelMatrix);
				clipSpaceMatrix.append(viewProjectionMatrix);
			}
			
			context.setTextureAt(0, textureObj);
			context.setVertexBufferAt(0, vertexBuffer, 0, Context3DVertexBufferFormat.FLOAT_2); // vertex
			context.setVertexBufferAt(1, vertexBuffer, 2, Context3DVertexBufferFormat.FLOAT_2); // uv
			
			context.setProgramConstantsFromMatrix(Context3DProgramType.VERTEX, 0, clipSpaceMatrix, true);
			
			programConstVector[0] = uvOffsetAndScale.x + uvOffsetX;
			programConstVector[1] = uvOffsetAndScale.y + uvOffsetY;
			programConstVector[2] = uvOffsetAndScale.width * uvScaleX;
			programConstVector[3] = uvOffsetAndScale.height * uvScaleY;
			
			context.setProgramConstantsFromVector(Context3DProgramType.VERTEX, 4, programConstVector);
			
			if (nodeTinted)
			{
				
				var offsetFactor:Number = 1.0 / 255.0;
				
				programConstVector[0] = colorTransform.redMultiplier;
				programConstVector[1] = colorTransform.greenMultiplier;
				programConstVector[2] = colorTransform.blueMultiplier;
				programConstVector[3] = colorTransform.alphaMultiplier;
				
				context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, programConstVector);
				
				programConstVector[0] = colorTransform.redOffset * offsetFactor;
				programConstVector[1] = colorTransform.greenOffset * offsetFactor;
				programConstVector[2] = colorTransform.blueOffset * offsetFactor;
				programConstVector[3] = colorTransform.alphaOffset * offsetFactor;
				
				context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1, programConstVector);
			}
		}
		
		public function get customWidth():Number 
		{
			return _customWidth;
		}
		
		public function set customWidth(value:Number):void 
		{
			_customWidth = value;
		}
		
		public function get customHeight():Number 
		{
			return _customHeight;
		}
		
		public function set customHeight(value:Number):void 
		{
			_customHeight = value;
		}
		
		public function get customY():Number 
		{
			return _customY;
		}
		
		public function set customY(value:Number):void 
		{
			_customY = value;
		}
		
		public function get customX():Number 
		{
			return _customX;
		}
		
		public function set customX(value:Number):void 
		{
			_customX = value;
		}
		
	}

}