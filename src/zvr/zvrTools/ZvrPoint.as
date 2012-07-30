package zvr.zvrTools 
{
	import flash.geom.Point;
		
	/**
	 * ...
	 * @author	Michal Zwieruho "ZVIR"
	 * @www		www.zvir.pl
	 * @email	michal@zvir.pl
	 */
	
	public class ZvrPoint extends Point
	{
		
		public function ZvrPoint(x:Number = 0, y:Number = 0)
		{
			super(x, y);
		}
		
		public function distance(point:Point):Number
		{
			return Point.distance(this, point);
		}
		
		public function rotate(angle:Number):ZvrPoint
		{
			var p:Point = Point.polar(length, (angle) * Math.PI / 180);
			x = p.x;
			y = p.y;
			return this;
		}
		
		public function angle(point:Point = null):Number
		{
			
			if (point == null) point = new Point();
			
			var angle:Number = Math.atan2(point.x - x, -1 * (point.y - y)) / Math.PI * 180;
			
			
           // var angle:Number = Math.atan((point.y - y)/( point.x - x)) * (180 / Math.PI);
           //return angle;
           return angle < 0 ? angle + 360 : angle;
		}
		
		public function angle3(point1:ZvrPoint, point2:ZvrPoint):Number
		{
			
			var ang:Number;
			var a:Number = distance(point2);
			var b:Number = distance(point1);
			var c:Number = point1.distance(point2);
			
			ang = Math.acos((a * a + b * b - c * c) / (2 * a * b));
			
			return ang / Math.PI * 180;
			
		}
		
		public function setBetween(point:Point, between:Number):ZvrPoint
		{
			x = x + between * (point.x - x);
			y = y + between * (point.y - y);
			return this;
		}
		
		public function clonePoint():ZvrPoint
		{
			return new ZvrPoint(x, y);
		}
		
		public function smoothTrans(fromPoint:Point, smoothing:Number):ZvrPoint
		{
			x = interpolateValue(x, fromPoint.x, smoothing);
			y = interpolateValue(y, fromPoint.y, smoothing);
			return this;
		}
		
		public function distacneToLine(linePoint1:Point, linePoint2:Point):Number
		{
			
			/*//var :Number shortest_distance(var :Number point_x, var :Number point_y, var :Number linePoint1.x, var :Number linePoint1.y, var :Number linePoint2.x, var :Number linePoint2.y
			// find the slope
			
			var slope_of_line:Number = (linePoint1.y - linePoint2.y) / (linePoint1.x - linePoint2.x);

			// find the perpendicular slope
			var  perpendicular_slope:Number = (linePoint1.x - linePoint2.x) / (linePoint1.y - linePoint2.y) * -1;

			// find the y_intercept of line BC
			var  y_intercept:Number = slope_of_line * linePoint2.x - linePoint2.y;

			// find the y_intercept of line AX
			var  new_line_y_intercept:Number = perpendicular_slope * - 1 * x - y;

			// get the x_coordinate of point X
			// equation of BC is    y = slope_of_line * x + y_intercept;
			// equation of AX is    y = perpendicular_slope * x + new_line_y_intercept;
			//   perpendicular_slope * x + new_line_y_intercept == slope_of_line * x + y_intercept;
			//   perpendicular_slope * x == slope_of_line * x + y_intercept - new_line_y_intercept;
			//   (perpendicular_slope - slope_of_line) * x == (y_intercept - new_line_y_intercept);
			
			var  intersect:ZvrPoint = new ZvrPoint();
			intersect.x = (y_intercept - new_line_y_intercept) / (perpendicular_slope - slope_of_line);

			// get the y_coordinate of point X
			intersect.y = slope_of_line * intersect.x + y_intercept;

			// measure the distance between A and X
			
			trace(slope_of_line, perpendicular_slope, y_intercept, new_line_y_intercept, intersect);
			
			return intersect.distance(this.clone());
			
			*/
			
			var a:Number = x - linePoint1.x;
			var b:Number = y - linePoint1.y;
			var c:Number = linePoint2.x - linePoint1.x;
			var d:Number = linePoint2.y - linePoint1.y;
			
			return Math.abs(a * d - c * b) / Math.sqrt(c * c + d * d);
			
		}
		
		
		public function getClosestPointOnLine(p1:Point, p2:Point, segment:Boolean = false):Point
		{
			
			var p3:Point = clonePoint();
			
			var xDelta:Number = p2.x - p1.x;
			var yDelta:Number = p2.y - p1.y;
			
			if ((xDelta == 0) && (yDelta == 0)) {
				// p1 and p2 cannot be the same point
				p2.x += 1;
				p2.y += 1;
				xDelta = 1;
				yDelta = 1;
			}
			
			var u:Number = ((p3.x - p1.x) * xDelta + (p3.y - p1.y) * yDelta) / (xDelta * xDelta + yDelta * yDelta);
			
			var closestPoint:Point = new Point(p1.x + u * xDelta, p1.y + u * yDelta);
			
			if (segment) {
				if (u < 0)
				{
					closestPoint = new Point(p1.x, p1.y);
				} else if (u > 1)
				{
					closestPoint = new Point(p2.x, p2.y);
				} 
			}
			
			return closestPoint;
			//Point.distance(closestPoint, new Point(p3.x, p3.y));

		}
		
		
		private function interpolateValue(a:Number, b:Number, c:Number):Number
		{
			var d:Number = a - (a - b) * c;
			return d;
		}
		
		public static function createFromPoint(point:Point):ZvrPoint
		{
			return new ZvrPoint(point.x, point.y);
		}
		
		
	}

}