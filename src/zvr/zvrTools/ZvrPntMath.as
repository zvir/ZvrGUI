package zvr.zvrTools 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrPntMath 
	{
		//[Inline]
		
		static private const RADIANS_TO_DEGREES:Number = 180 / Math.PI;
		//[Inline]
		static private const DEGREES_TO_RADIANS:Number = Math.PI / 180;
		
		[Inline]
		public static function angle(p1:ZvrPnt):Number
		{
			var angle:Number = Math.atan2(p1.x, -p1.y) * RADIANS_TO_DEGREES;
			return angle < 0 ? angle + 360 : angle;
		}
		
		[Inline]
		public static function angle2(p1:ZvrPnt, p2:ZvrPnt):Number
		{
			var angle:Number = Math.atan2(p2.x - p1.x, -1 * (p2.y - p1.y)) * RADIANS_TO_DEGREES;			
			return angle < 0 ? angle + 360 : angle;
		}
		
		[Inline]
		public static function angle3(p1:ZvrPnt, p2:ZvrPnt, p3:ZvrPnt):Number
		{
			var ang:Number;
			
			var a:Number = distance(p1, p3);
			var b:Number = distance(p1, p2);
			var c:Number = distance(p2, p3);
			
			ang = Math.acos((a * a + b * b - c * c) / (2 * a * b));
			
			return ang * RADIANS_TO_DEGREES;
			
		}
		
		[Inline]
		public static function distance(p1:ZvrPnt, p2:ZvrPnt):Number
		{
			return Math.sqrt((p2.x -p1.x) * (p2.x -p1.x) + (p2.y -p1.y) * (p2.y -p1.y));
		}
		
		[Inline]
		public function distacneToLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt):Number
		{
			var a:Number = p.x - lineZvrPnt1.x;
			var b:Number = p.y - lineZvrPnt1.y;
			var c:Number = lineZvrPnt2.x - lineZvrPnt1.x;
			var d:Number = lineZvrPnt2.y - lineZvrPnt1.y;
			
			return Math.abs(a * d - c * b) / Math.sqrt(c * c + d * d);
		}
		
		[Inline]
		public static function setBetween(p:ZvrPnt, p1:ZvrPnt, p2:ZvrPnt, between:Number):ZvrPnt
		{
			p.x = p1.x + between * (p2.x - p1.x);
			p.y = p1.y + between * (p2.y - p1.y);
			return p;
		}
		
		[Inline]
		public static function length(p:ZvrPnt):Number
		{
			return Math.sqrt(p.x * p.x + p.y * p.y);
		}
		
		[Inline]
		public static function getClosestPointOnLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt, segment:Boolean):ZvrPnt
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
		
		[Inline]
		public static function distacneToLine(p:ZvrPnt, lineZvrPnt1:ZvrPnt, lineZvrPnt2:ZvrPnt):Number
		{
			
			var c:Number = lineZvrPnt2.x - lineZvrPnt1.x;
			var d:Number = lineZvrPnt2.y - lineZvrPnt1.y;
			
			var e:Number = (p.x - lineZvrPnt1.x) * (p.y - lineZvrPnt1.y) - c * (p.y - lineZvrPnt1.y);
			return ((e < 0)? -e : e) / Math.sqrt(c * c + d * d);
		}
		
		[Inline]
		public static function smoothTrans(p:ZvrPnt, toX:Number, toY:Number, smoothing:Number):void
		{
			p.x = interpolateValue(p.x, toX, smoothing);
			p.y = interpolateValue(p.y, toY, smoothing);
		}
		
		[Inline]
		public static function rotate(p:ZvrPnt, a:Number):void
		{
			var length:Number = Math.sqrt(p.x * p.x + p.y * p.y);
			var ang:Number = angle(p);
			p.x = 0;
			p.y = 0;
			polar(p, length, a + ang);
		}
		
		[Inline]
		public static function polar(p:ZvrPnt, radius:Number, angle:Number):void
		{
			angle *= DEGREES_TO_RADIANS;
			p.x += radius * Math.cos(angle);
			p.y += radius * Math.sin(angle);
		}
		
		[Inline]
		public static function setPolar(p:ZvrPnt, radius:Number, angle:Number):void
		{
			angle *= DEGREES_TO_RADIANS;
			p.x = radius * Math.cos(angle);
			p.y = radius * Math.sin(angle);
		}
		
		[Inline]
		public static function getPolar(radius:Number, angle:Number):ZvrPnt
		{
			var p:ZvrPnt = new ZvrPnt();
			angle *= DEGREES_TO_RADIANS;
			p.x = radius * Math.cos(angle);
			p.y = radius * Math.sin(angle);
			return p;
		}
		
		[Inline]
		private static function interpolateValue(a:Number, b:Number, c:Number):Number
		{
			return a - (a - b) * c;
		}
		
		[Inline]
		public static function add(p1:ZvrPnt, p2:ZvrPnt):ZvrPnt
		{
			return new ZvrPnt(p1.x + p2.x, p1.y + p2.y);
		}
		
		[Inline]
		public static function addTo(p1:ZvrPnt, p2:ZvrPnt):void
		{
			p1.x += p2.x
			p1.y += p2.y;
		}
		
		[Inline]
		public static function subtract(p1:ZvrPnt, p2:ZvrPnt):ZvrPnt
		{
			return new ZvrPnt(p1.x - p2.x, p1.y - p2.y);
		}
		
		[Inline]
		public static function subtractFrom(p1:ZvrPnt, p2:ZvrPnt):void
		{
			p1.x -= p2.x
			p1.y -= p2.y;
		}
		
		[Inline]
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
		
		[Inline]
		static public function lineIntersection(line1Point1:ZvrPnt, line1Point2:ZvrPnt, line2Point1:ZvrPnt, line2Point2:ZvrPnt, secondLineIsSegment:Boolean):ZvrPnt
		{
			
			var k1:Number = (line1Point2.y - line1Point1.y) / (line1Point2.x - line1Point1.x);
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
		
		static public function lineIntersectLine(A:ZvrPnt, B:ZvrPnt, E:ZvrPnt, F:ZvrPnt, as_seg:Boolean = true):ZvrPnt
		{
			var ip:ZvrPnt;
			var a1:Number;
			var a2:Number;
			var b1:Number;
			var b2:Number;
			var c1:Number;
			var c2:Number;
		 
			a1= B.y-A.y;
			b1= A.x-B.x;
			c1= B.x*A.y - A.x*B.y;
			a2= F.y-E.y;
			b2= E.x-F.x;
			c2= F.x*E.y - E.x*F.y;
		 
			var denom:Number=a1*b2 - a2*b1;
			if (denom == 0) {
				return null;
			}
			ip=new ZvrPnt();
			ip.x=(b1*c2 - b2*c1)/denom;
			ip.y=(a2*c1 - a1*c2)/denom;
		 
			//---------------------------------------------------
			//Do checks to see if intersection to endpoints
			//distance is longer than actual Segments.
			//Return null if it is with any.
			//---------------------------------------------------
			if(as_seg){
				if(Math.pow(ip.x - B.x, 2) + Math.pow(ip.y - B.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
				{
				   return null;
				}
				if(Math.pow(ip.x - A.x, 2) + Math.pow(ip.y - A.y, 2) > Math.pow(A.x - B.x, 2) + Math.pow(A.y - B.y, 2))
				{
				   return null;
				}
		 
				if(Math.pow(ip.x - F.x, 2) + Math.pow(ip.y - F.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
				{
				   return null;
				}
				if(Math.pow(ip.x - E.x, 2) + Math.pow(ip.y - E.y, 2) > Math.pow(E.x - F.x, 2) + Math.pow(E.y - F.y, 2))
				{
				   return null;
				}
			}
			return ip;
		}

		[Inline]
		public static function equal(p1:ZvrPnt, p2:ZvrPnt):Boolean
		{
			return p1.x == p2.x && p1.y == p2.y;
		}
		
		[Inline]
		public static function normalize(p:ZvrPnt):void
		{
			var l:Number = length(p);
			
			if ( l == 1.0  || l == 0.0 ) return;
			
			//l = 1.0 / Math.sqrt(l);
			
			p.x /= l;
			p.y /= l;
			
		}
		////[Inline]
		static public function divideSegmentByLenghth(p1:ZvrPnt, p2:ZvrPnt, number:Number):Array 
		{
			var d:Number = distance(p1, p2);
			if (d == 0) return [p1];
			var angle:Number =  Math.atan2(p2.x - p1.x, -1 * (p2.y - p1.y));
			var np:int = d / number;
			var px:Number = number * Math.cos(angle + 1.57079632679489);
			var py:Number = number * Math.sin(angle + 1.57079632679489);
			var r:Array = [];
			var p:ZvrPnt = new ZvrPnt(p2.x, p2.y);
			for (var i:int = 0; i < np; i++) 
			{
				r.push(p);
				p.x += px;
				p.y += py;
				p = new ZvrPnt(p.x, p.y);
			}
			return r;
		}
	}

}