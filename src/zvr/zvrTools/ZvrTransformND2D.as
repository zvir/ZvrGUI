package zvr.zvrTools 
{
	import de.nulldesign.nd2d.display.Node2D;
	import fl.motion.MatrixTransformer;
	import flash.geom.Matrix;
	import flash.geom.Matrix3D;
	import flash.geom.Vector3D;
		

	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrTransformND2D
	{
		
		static public function scaleAroundPointDeltaNode2D(displayObject:Node2D, scaleXDelta:Number, scaleYDelta:Number,  x:Number, y:Number):void
		{
			var m:Matrix = displayObject.localMatrix2D;
			
			m.tx -= x;
			m.ty -= y;
			m.scale(scaleXDelta, scaleYDelta);
			m.tx += x;
			m.ty += y;
			
			displayObject.localMatrix2D = m;
			
		}
		
		static public function rotateAroundExternalPointNode2D(displayObject:Node2D, rotationBy:Number, x:Number, y:Number):void
		{
			var m:Matrix = displayObject.localMatrix2D;
			MatrixTransformer.rotateAroundExternalPoint(m, x, y, rotationBy);
			displayObject.localMatrix2D = m;
		}
		
		static public function addChildWithoutGlobalTransformND2D(child:Node2D, parent:Node2D):void
		{
			var childMatrix:Matrix3D = child.worldModelMatrix.clone();
			var parentMatrix:Matrix3D  = parent.worldModelMatrix.clone();
			parentMatrix.invert();
			childMatrix.append(parentMatrix);
			if (child.parent) child.parent.removeChild(child);
			parent.addChild(child);
			child.localMatrix = childMatrix;
		}
		
		static public function mutliTransfrom(displayObject:Node2D, tx:Number, ty:Number, px:Number, py:Number, dr:Number, sd:Number):void 
		{
			if (displayObject.invalidateMatrix) displayObject.updateLocalMatrix();
			
			var m3d:Matrix3D = displayObject.localModelMatrix;
			
			m3d.appendTranslation( - px, -py, 0);
			m3d.appendScale( sd, sd, 1);
			m3d.appendRotation(dr, Vector3D.Z_AXIS);
			m3d.appendTranslation(px + tx, py + ty, 0);
			displayObject.myMatrixChanged = true;
			
			displayObject.updateTransformationFromMatrix();
			
		}
		

	}

}