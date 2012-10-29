package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPntMath 
	{
		static private const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		static private const DEGREES_TO_RADIANS:Number = Math.PI / 180;
		
		public static function angle(p1:ZvrPnt, p2:ZvrPnt = null):Number
		{
			
			var angle:Number;
			
			if (p2 == null)
			{
				angle = Math.atan2(p1.x, p1.y) * RADIANS_TO_DEGREES;
			}
			else
			{
				angle = Math.atan2(p2.x - p1.x, -1 * (p2.y - p1.y)) * RADIANS_TO_DEGREES;
			}
			
			return angle < 0 ? angle + 360 : angle;
		}
		
		
		
		public static function angle3(p1:ZvrPnt, p2:ZvrPnt, p3:ZvrPnt):Number
		{
			var ang:Number;
			
			var a:Number = distance(p1, p3);
			var b:Number = distance(p1, p2);
			var c:Number = distance(p2, p3);
			
			ang = Math.acos((a * a + b * b - c * c) / (2 * a * b));
			
			return ang * RADIANS_TO_DEGREES;
			
		}
		
		public static function distance(p1:ZvrPnt, p2:ZvrPnt):Number
		{
			return Math.sqrt((p2.x -p1.x) * (p2.x -p1.x) + (p2.y -p1.y) * (p2.y -p1.y));
		}
		
		public function distacneToLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt):Number
		{
			var a:Number = p.x - lineZvrPnt1.x;
			var b:Number = p.y - lineZvrPnt1.y;
			var c:Number = lineZvrPnt2.x - lineZvrPnt1.x;
			var d:Number = lineZvrPnt2.y - lineZvrPnt1.y;
			
			return Math.abs(a * d - c * b) / Math.sqrt(c * c + d * d);
		}
		
		public static function setBetween(p:ZvrPnt, p1:ZvrPnt, p2:ZvrPnt, between:Number):void
		{
			p.x = p1.x + between * (p2.x - p1.x);
			p.y = p1.y + between * (p2.y - p1.y);
		}
		
		public static function length(p:ZvrPnt):Number
		{
			return Math.sqrt(p.x * p.x + p.y * p.y);
		}
		
		public static function getClosestPointOnLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt, segment:Boolean = false):ZvrPnt
		{
			
			var tx:Number;
			var ty:Number;
			
			var xDelta:Number = lineZvrPnt2.x - lineZvrPnt1.x;
			var yDelta:Number = lineZvrPnt2.y - lineZvrPnt1.y;
			
			if ((xDelta == 0) && (yDelta == 0))
			{
				// lineZvrPnt1 and lineZvrPnt2 cannot be the same ZvrPnt
				lineZvrPnt2.x += 1;
				lineZvrPnt2.y += 1;
				xDelta = 1;
				yDelta = 1;
			}
			
			var u:Number = ((p.x - lineZvrPnt1.x) * xDelta + (p.y - lineZvrPnt1.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta);
			
			tx = lineZvrPnt1.x + u * xDelta;
			ty = lineZvrPnt1.y + u * yDelta;
			
			if (segment)
			{
				if (u < 0)
				{
					tx = lineZvrPnt1.x;
					ty = lineZvrPnt1.y;
				}
				else if (u > 1)
				{
					tx = lineZvrPnt2.x;
					ty = lineZvrPnt2.y;
				} 
			}
			
			return new ZvrPnt(tx, ty);
		}
		
		public static function distacneToLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt):Number
		{
			
			var c:Number = lineZvrPnt2.x - lineZvrPnt1.x;
			var d:Number = lineZvrPnt2.y - lineZvrPnt1.y;
			
			var e:Number = (p.x - lineZvrPnt1.x) * (p.y - lineZvrPnt1.y) - c * (p.y - lineZvrPnt1.y);
			return ((e < 0)? -e : e) / Math.sqrt(c * c + d * d);
		}
		
		public static function smoothTrans(p:ZvrPnt, toX:Number, toY:Number, smoothing:Number):void
		{
			p.x = interpolateValue(p.x, toX, smoothing);
			p.y = interpolateValue(p.y, toY, smoothing);
		}
		
		public static function rotate(p:ZvrPnt, a:Number):void
		{
			var length:Number = Math.sqrt(p.x * p.x + p.y * p.y);
			var ang:Number = angle(p);
			p.x = 0;
			p.y = 0;
			polar(p, length, a + ang);
		}
		
		public static function polar(p:ZvrPnt, radius:Number, angle:Number):void
		{
			angle *= DEGREES_TO_RADIANS;
			p.x += radius * Math.cos(angle);
			p.y += radius * Math.sin(angle);
		}
		
		public static function getPolar(radius:Number, angle:Number):ZvrPnt
		{
			var p:ZvrPnt = new ZvrPnt();
			angle *= DEGREES_TO_RADIANS;
			p.x = radius * Math.cos(angle);
			p.y = radius * Math.sin(angle);
			return p;
		}
		
		private static function interpolateValue(a:Number, b:Number, c:Number):Number
		{
			return a - (a - b) * c;
		}
		
		public static function add(p1:ZvrPnt, p2:ZvrPnt):ZvrPnt
		{
			return new ZvrPnt(p1.x + p2.x, p1.y + p2.y);
		}
		
		public static function addTo(p1:ZvrPnt, p2:ZvrPnt):void
		{
			p1.x += p2.x
			p1.y += p2.y;
		}
		
		public static function subtract(p1:ZvrPnt, p2:ZvrPnt):ZvrPnt
		{
			return new ZvrPnt(p1.x - p2.x, p1.y - p2.y);
		}
		
		public static function subtractFrom(p1:ZvrPnt, p2:ZvrPnt):void
		{
			p1.x -= p2.x
			p1.y -= p2.y;
		}
		
		static public function cicleCenterFrom3Points(p:ZvrPnt, p1:ZvrPnt, p2:ZvrPnt, p3:ZvrPnt):ZvrPnt
		{
			
			var s:Number = 0.5 * ((p2.x - p3.x) * (p1.x - p3.x) - (p2.y - p3.y) * (p3.y - p1.y));
			var sUnder:Number = (p1.x - p2.x) * (p3.y - p1.y) - (p2.y - p1.y) * (p1.x - p3.x);
			
			if(sUnder != 0)
			{
				s = s / sUnder;
				p.x = 0.5 * (p1.x + p2.x) + s * (p2.y - p1.y);
				p.y = 0.5 * (p1.y + p2.y) + s * (p1.x - p2.x);
				return p;
			}
			return p;
		}
		
		static public function lineIntersection(line1Point1:ZvrPnt, line1Point2:ZvrPnt, line2Point1:ZvrPnt, line2Point2:ZvrPnt, secondLineIsSegment:Boolean = false):ZvrPnt
		{
			
			var k1:Number = (line1Point2.y-line1Point1.y) / (line1Point2.x-line1Point1.x);
			var k2:Number = (line2Point2.y - line2Point1.y) / (line2Point2.x - line2Point1.x);
			
			if ( k1 == k2 )
			{
				return null;
			}
			
			var x:Number;
			var y:Number;

			if( !isFinite(k1) )
			{

				x = line1Point1.x;

				var m2:Number = line2Point1.y - k2 * line2Point1.x;

				y = k2 * x + m2;
			}

			else if( !isFinite(k2) )
			{
				var m1:Number = line1Point1.y - k1 * line1Point1.x;
				
				x = line2Point1.x;
				y = k1 * x + m1;
			}

			else
			{
				m1 = line1Point1.y - k1 * line1Point1.x;
				m2 = line2Point1.y - k2 * line2Point1.x;
				x = (m1-m2) / (k2-k1);
				y = k1 * x + m1;
			}
			
			return new ZvrPnt(x, y);
		}
		
		public static function equal(p1:ZvrPnt, p2:ZvrPnt):Boolean
		{
			return p1.x == p2.x && p1.y == p2.y;
		}
	}

}