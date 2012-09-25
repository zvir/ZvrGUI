package zvr.zvrTools 
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import fl.motion.MatrixTransformer;
	import flash.geom.Matrix3D;
	import flash.geom.Point;
		

	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTransform
	{
		
		static public function moveBy(displayObject:DisplayObject, vector:Point):void
		{
			var m:Matrix = displayObject.transform.matrix;
			m.translate(vector.x, vector.y);
			displayObject.transform.matrix = m;
		}
		
		static public function scaleAroundPoint(displayObject:DisplayObject, scaleX:Number, scaleY:Number,  x:Number, y:Number):void
		{
			var m:Matrix = displayObject.transform.matrix;
			
			scaleX /= displayObject.scaleX;
			scaleY /= displayObject.scaleY;
			
			m.tx -= x;
			m.ty -= y;
			m.scale(scaleX, scaleY);
			m.tx += x;
			m.ty += y;
			
			displayObject.transform.matrix = m;
			
		}
		
		static public function scaleAroundPointDelta(displayObject:DisplayObject, scaleXDelta:Number, scaleYDelta:Number,  x:Number, y:Number):void
		{
			var m:Matrix = displayObject.transform.matrix;
			
			/*m.tx -= x;
			m.ty -= y;*/
			m.translate( -x, -y);
			m.scale(scaleXDelta, scaleYDelta);
			m.translate(x, y);
			/*m.tx += x;
			m.ty += y;*/
			
			displayObject.transform.matrix = m;
			
		}
		
		static public function rotateAroundExternalPoint(displayObject:DisplayObject, rotationBy:Number, x:Number, y:Number):void
		{
			var m:Matrix = displayObject.transform.matrix;
			MatrixTransformer.rotateAroundExternalPoint(m, x, y, rotationBy);
			displayObject.transform.matrix = m;
		}
		
		static public function addChildWithoutGlobalTransform(child:DisplayObject, parent:DisplayObjectContainer):void
		{
			
			var childMatrix:Matrix = child.transform.concatenatedMatrix;
			var parentMatrix:Matrix  = parent.transform.concatenatedMatrix;
			parentMatrix.invert();
			childMatrix.concat(parentMatrix);
			parent.addChild(child);
			child.transform.matrix = childMatrix;
			
		}
		
		static public function unTint(displayObject:DisplayObject):void
		{
			displayObject.transform.colorTransform = new ColorTransform();
		}
		
		static public function tint(displayObject:DisplayObject, color:uint, value:Number = 1):void
		{
			var ctMul:Number = (1 - value);
			var ctRedOff:Number = Math.round(value * ((color >> 16 ) & 0xFF));
			var ctGreenOff:Number = Math.round(value * ((color >> 8) & 0xFF ));
			var ctBlueOff:Number = Math.round(value * (color & 0xFF ));
			var ct:ColorTransform = new ColorTransform(ctMul, ctMul, ctMul, 1, ctRedOff, ctGreenOff, ctBlueOff, 0);
			displayObject.transform.colorTransform = ct;
		}
		
		static public function skew(target:DisplayObject, x:Number, y:Number):void
		{
			var m:Matrix = new Matrix();
			m.b = y * Math.PI / 180;
			m.c = x * Math.PI / 180;
			m.concat(target.transform.matrix);
			target.transform.matrix = m;
		}
	}

}