package zvr.zvrTools
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrMath
	{
		
		// center of circle described by three points
		static public function cc3p(p1:Point, p2:Point, p3:Point):ZvrPoint
		{
			var cc:ZvrPoint
			
			var s:Number = 0.5 * ((p2.x - p3.x) * (p1.x - p3.x) - (p2.y - p3.y) * (p3.y - p1.y));
			var sUnder:Number = (p1.x - p2.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p1.x - p3.x);
			
			if (sUnder != 0)
			{
				s = s / sUnder;
				cc = new ZvrPoint();
				cc.x = 0.5 * (p1.x + p2.x) + s * (p2.y - p1.y);
				cc.y = 0.5 * (p1.y + p2.y) + s * (p1.x - p2.x);
			}
			return cc;
		}
		
		static public function smoothTrans(a:Number, b:Number, c:Number):Number
		{
			return a - (a - b) * c;
		}
		
		static public function smoothTransStep(from:Number, to:Number, smooth:Number, step:Number, limit:Number = 0.0001):Number
		{
			if (Math.abs(from - to) < limit) return to;
			return step == 1 ? from - (from  - to ) * smooth : from - (from  - to ) * smoothIn(smooth, step);
			
			//var r:Number = step == 1 ? from - (from  - to ) * smooth : from - (from  - to ) * smoothIn(smooth, step);
			
			//return Math.round(r * limit) / (1/limit);
		}
		
		static public function smoothIn(smooth:Number, step:Number):Number
		{
			if (smooth == 0) return 0;
			smooth = 1 - smooth;
			return 1 - (((((1 - Math.pow(smooth, step + 1)) / (1 - smooth))) - (((1 - Math.pow(smooth, step)) / (1 - smooth)))));
		}
		
		static public function linearTrans(value:Number, to:Number, maxStep:Number):Number
		{
			to =  to - value > maxStep ? value + maxStep : to;
			to =  to - value < -maxStep ? value - maxStep : to;
			return to;
		}
		
		static public function lineIntersection(line1Point1:Point, line1Point2:Point, line2Point1:Point, line2Point2:Point, secondLineIsSegment:Boolean = false):Point
		{
			
			var k1:Number = (line1Point2.y - line1Point1.y) / (line1Point2.x - line1Point1.x);
			var k2:Number = (line2Point2.y - line2Point1.y) / (line2Point2.x - line2Point1.x);
			
			if (k1 == k2)
			{
				return null;
			}
			
			var x:Number;
			var y:Number;
			
			if (!isFinite(k1))
			{
				
				x = line1Point1.x;
				
				var m2:Number = line2Point1.y - k2 * line2Point1.x;
				
				y = k2 * x + m2;
			}
			
			else if (!isFinite(k2))
			{
				var m1:Number = line1Point1.y - k1 * line1Point1.x;
				
				x = line2Point1.x;
				y = k1 * x + m1;
			}
			
			else
			{
				m1 = line1Point1.y - k1 * line1Point1.x;
				m2 = line2Point1.y - k2 * line2Point1.x;
				x = (m1 - m2) / (k2 - k1);
				y = k1 * x + m1;
			}
			
			if (secondLineIsSegment)
			{
				if (Math.pow(x -  line2Point2.x, 2) + Math.pow(y -  line2Point2.y, 2) > Math.pow( line2Point1.x -  line2Point2.x, 2) + Math.pow( line2Point1.y -  line2Point2.y, 2))
				{
					return null;
				}
				if (Math.pow(x -  line2Point1.x, 2) + Math.pow(y -  line2Point1.y, 2) > Math.pow( line2Point1.x -  line2Point2.x, 2) + Math.pow( line2Point1.y -  line2Point2.y, 2))
				{
					return null;
				}
			}
			
			return new Point(x, y);
		}
		
		public static function lineRectangleIntersects(linePoint1:Point, linePoint2:Point, box1:Point, box2:Point):Array
		{
			var arr:Array = [];
			var intersection:Point;
			
			intersection = lineIntersection(linePoint1, linePoint2, box1, new Point(box2.x, box1.y), true);
			if (intersection)
				arr.push(intersection);
			
			intersection = lineIntersection(linePoint1, linePoint2, box1, new Point(box1.x, box2.y), true);
			if (intersection)
				arr.push(intersection);
			
			intersection = lineIntersection(linePoint1, linePoint2, box2, new Point(box2.x, box1.y), true);
			if (intersection)
				arr.push(intersection);
			
			intersection = lineIntersection(linePoint1, linePoint2, box2, new Point(box1.x, box2.y), true);
			if (intersection)
				arr.push(intersection);
			
			return arr;
		}
		
		public static function lineIntersectLine( line1Point1:Point,  line1Point2:Point,  line2Point1:Point,  line2Point2:Point, as_seg:Boolean = true):Point
		{
			var ip:Point;
			var a1:Number;
			var a2:Number;
			var b1:Number;
			var b2:Number;
			var c1:Number;
			var c2:Number;
			
			a1 =  line1Point2.y -  line1Point1.y;
			b1 =  line1Point1.x -  line1Point2.x;
			c1 =  line1Point2.x *  line1Point1.y -  line1Point1.x *  line1Point2.y;
			a2 =  line2Point2.y -  line2Point1.y;
			b2 =  line2Point1.x -  line2Point2.x;
			c2 =  line2Point2.x *  line2Point1.y -  line2Point1.x *  line2Point2.y;
			
			var denom:Number = a1 * b2 - a2 * b1;
			if (denom == 0)
			{
				return null;
			}
			ip = new Point();
			ip.x = (b1 * c2 - b2 * c1) / denom;
			ip.y = (a2 * c1 - a1 * c2) / denom;
			
			//---------------------------------------------------
			//Do checks to see if intersection to endpoints
			//distance is longer than actual Segments.
			//Return null if it is with any.
			//---------------------------------------------------
			/*if ( as_seg )
			{
				 var n0:Number, n1:Number, n2:Number, n3:Number, n4:Number, n5:Number, n6:Number, n7:Number, v0:Number, v1:Number, vr0:Number, vr1:Number;
				 n0 = ip.x – p_a1.x;
				 n1 = ip.y – p_a1.y;
				 v0 = p_a0.y – p_a1.y;
				 vr0 = b1 * b1 + v0 * v0;
				 if ( n0 * n0 + n1 * n1 > vr0 ) return null;
				 n2 = ip.x – p_a0.x;
				 n3 = ip.y – p_a0.y;
				 if ( n2 * n2 + n3 * n3 > vr0 ) return null;
				 n4 = ip.x – p_b1.x;
				 n5 = ip.y – p_b1.y;
				 v1 = p_b0.y – p_b1.y;
				 vr1 = b2 * b2 + v1 * v1;
				 if ( n4 * n4 + n5 * n5 > vr1 ) return null;
				 n6 = ip.x – p_b0.x;
				 n7 = ip.y – p_b0.y;
				 if ( n6 * n6 + n7 * n7 > vr1 ) return null;
			 }*/
			 
			 
			if (as_seg)
			{
				/*
				if (Math.pow(ip.x -  line1Point2.x, 2) + Math.pow(ip.y -  line1Point2.y, 2) > Math.pow( line1Point1.x -  line1Point2.x, 2) + Math.pow( line1Point1.y -  line1Point2.y, 2))
				{
					return null;
				}
				if (Math.pow(ip.x -  line1Point1.x, 2) + Math.pow(ip.y -  line1Point1.y, 2) > Math.pow( line1Point1.x -  line1Point2.x, 2) + Math.pow( line1Point1.y -  line1Point2.y, 2))
				{
					return null;
				}
				
				if (Math.pow(ip.x -  line2Point2.x, 2) + Math.pow(ip.y -  line2Point2.y, 2) > Math.pow( line2Point1.x -  line2Point2.x, 2) + Math.pow( line2Point1.y -  line2Point2.y, 2))
				{
					return null;
				}
				if (Math.pow(ip.x -  line2Point1.x, 2) + Math.pow(ip.y -  line2Point1.y, 2) > Math.pow( line2Point1.x -  line2Point2.x, 2) + Math.pow( line2Point1.y -  line2Point2.y, 2))
				{
					return null;
				}
				*/
			}
			
			
			return ip;
		}
		
		
		public static function cutAngle180(a:Number):Number
		{
			a = a > 180 ? ((a + 180) % 360) - 180 : a < -180 ? ((a - 180) % 360) + 180 : a == -180 ? 180 : a;
			
			return a;
		}
		
		public static function cutAngle360(a:Number):Number
		{
			
			a = a > 360 ? a % 360 : a < 0 ? ((a - 360) % 360) + 360 : a == 360 ? 0 : a;
			
			return a;
		}
		
		public static function logx(val:Number, base:Number = 10):Number
		{
			return Math.log(val) / Math.log(base);
		}
		
		public static function gcd(a:int, b:int):int
		{
			// Euclidean algorithm
			var t:int;
			while (b != 0){
				t = b;
				b = a % b;
				a = t;
			}
			return a;
		}

		public static function lcm(a:int, b:int):int
		{
			return (a * b / gcd(a, b));
		}

		public static function lcmm(args:Array):int
		{
			// Recursively iterate through pairs of arguments
			// i.e. lcm(args[0], lcm(args[1], lcm(args[2], args[3])))

			if(args.length == 2){
				return lcm(args[0], args[1]);
			} else {
				var arg0:int = args[0];
				args.shift();
				return lcm(arg0, lcmm(args));
			}
		}
		
		public static function roundCommonFracrion(v1:int, v2:int):Array
		{
			
			if (v1 == 0 && v2 == 1) return [0, 0]; 
			if (v1 == 0) return [0, 1];
			if (v2 == 0) return [1, 0];
			
			var a:Array = getFracrion(v1, v2);
			
			while ((a[0] < 1 || a[0] >= 10) && (a[1] < 1 || a[1] >= 10))
			{
				var vr1:int = a[0] / 2;
				var vr2:int = a[1] / 2;
				
				a = getFracrion(vr1, vr2);
				
			}
			
			if ((a[0] >= 10 && a[1] < 10))
			{
				a[0] = Math.round(a[0] / a[1]);
				a[1] = 1;
			}
			
			if ((a[1] >= 10 && a[0] < 10))
			{
				a[1] = Math.round(a[1] / a[0]);
				a[0] = 1;
			}
			
			if (isNaN(a[0]))
			{
				//trace("NAN ERROR 1");
				a[0] = 0;
			}
			
			if (isNaN(a[1]))
			{
				//trace("NAN ERROR 2");
				a[1] = 0;
			}
			
			return a;
		}
		
		private static function getFracrion(v1:int, v2:int):Array
		{
			var v:Number = v1 / v2;
			v = lcm(v1, v2);
			return [v / v2, v / v1];
		}
	}
}