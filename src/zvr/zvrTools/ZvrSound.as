package zvr.zvrTools 
{
	import flash.media.Sound;
	import flash.utils.ByteArray;
	import zvr.zvrSnd.ZvrWaveForm;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSound 
	{
		
		public static function getWaveForm(s:Sound, form:ZvrWaveForm = null, resolution:int = 1):ZvrWaveForm
		{
			
			if (!s) return null;
			
			var v:ZvrWaveForm = form ? form : new ZvrWaveForm();
			
			
			var b:ByteArray = new ByteArray();
			
			var extract:Number = Math.floor ((s.length / 1000) * 44100);
			
			var lng:Number = s.extract(b, extract, 0);
			
			if (lng == 0) return null;
			
			var left:Number;
			var right:Number;
			
			var l:Number;
			var r:Number;
			
			var mixMax:Number;
			var mixMin:Number;
			
			b.position = 0;
			
			var limit:int = 8 * resolution;
			
			while (b.bytesAvailable > limit)
			{
				
				var leftMin:Number = Number.MAX_VALUE;  
				var leftMax:Number = Number.MIN_VALUE;  
				var rightMin:Number = Number.MAX_VALUE; 
				var rightMax:Number = Number.MIN_VALUE; 
				
				for (var i:int = 0; i < resolution; i++) 
				{
					
					left = b.readFloat();
					right = b.readFloat();
					
					if (left < leftMin) leftMin = left;
					if (left > leftMax) leftMax = left;
					if (right < rightMin) rightMin = right;
					if (right > rightMax) rightMax = right;
					
				}
				

				mixMin = (leftMin + rightMin) / 2;
				mixMax = (rightMin + rightMax) / 2;
				
				v.leftMin.push(leftMin);
				v.leftMax.push(leftMax);
				v.rightMin.push(rightMin);
				v.rightMax.push(rightMax);
				v.mixMin.push(mixMin);
				v.mixMax.push(mixMax);
			}
			
			v.length = v.leftMin.length;
			
			return v;
			
		}
		
	}

}