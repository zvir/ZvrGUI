package zvr.zvrTweener 
{
	import flash.geom.Point;
	import org.sephiroth.path.QuadraticBezierSegment;
	import zvr.zvrTools.ZvrPntMath;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrTween
	{
		
		
		
		internal static const MANUAL	:int = 0;
		internal static const FRAME		:int = 1;
		internal static const TIME		:int = 2;
		internal static const TO_UPDATE	:int = 3;
		
		internal var stepMultiplayer:Number = 1;
		
		internal var onComplete:Vector.<Function> = new Vector.<Function>();
		internal var onCompleteOnce:Vector.<Function> = new Vector.<Function>();
		
		internal var fadeIn:Number;
		internal var fadeOut:Number;
		
		internal var fadeInValue:Number;
		internal var fadeOutValue:Number;
		
		internal var fadeInDuration:Number;
		internal var fadeOutDuration:Number;
		
		internal var current:Number;
		
		internal var to:Number;
		internal var from:Number;
		
		internal var distance:Number;
		internal var distanceTween:Number;
		
		internal var bezier:ZvrBezier;
		
		internal var property:Object;
		internal var scope:Object;
		internal var propertyName:String;
		
		internal var setter:ZvrTweenManager;
		
		internal var disposeAfterComplete:Boolean = true;
		
		internal var updateMode:int = 0;
		
		internal var dynamicDuration:Boolean = false;
		
		internal var durationMultiplayer:Number = 1;
		
		internal var minDuration:Number;
		
		public function ZvrTween(scope:Object=null, property:Object=null, fadeIn:Number = 10, fadeOut:Number = 10)
		{
			
			setter = new ZvrTweenManager(this);
			
			trace("NEW TWEEN!");
			
			this.property = property;
			this.scope = scope;
			
			for (var name:String in property) 
			{
				if (name == "onComplete")
				{
					onComplete.push(property[name]);
				}
				else
				{
					propertyName = name;
					from = scope[propertyName];
					var t:Number = property[name];
				}
			}
			
			bezier = new ZvrBezier(new Point(), new Point(), new Point(), new Point());
			
			this.fadeOut = fadeOut;
			this.fadeIn = fadeIn;
			
			current = 0;
			
			setTo(t);
			
		}
		
		public function updateProperty(property:Object):void 
		{
			for (var name:String in property) 
			{
				if (name == "onComplete")
				{
					onComplete = property[name];
				}
				else
				{
					propertyName = name;
					from = scope[propertyName];
					setTo(property[name]);
				}
			}
			
			/*if (updateMode == TO_UPDATE)
			{
				step();
			}*/
			
		}
		
		internal function step(iteration:Number = 1):void
		{
			if (current > distanceTween)
			{
				if (scope[propertyName] != to)
				{
					resetTween();
				}
				else
				{
					return;
				}
			}
			
			current += (iteration * stepMultiplayer);
			
			if (current > distanceTween)
			{
				complete();
			}
			else
			{
				scope[propertyName] = bezier.getYForX(current);
			}
		}
		
		private function complete():void
		{
			scope[propertyName] = to;
				
			for (var i:int = 0; i < onComplete.length; i++) 
			{
				onComplete[i]();
			}
			
			var f:Function = onCompleteOnce.pop();
			
			while (f != null)
			{
				f();
				f = onCompleteOnce.pop();
			}
			
			if (disposeAfterComplete)
			{
				//ZvrTweener.disposeTween(this);
			}
		}
		
		public function setTo(value:Number):void 
		{
			
			/*if (updateMode == TO_UPDATE)
			{
				step(1);
			}*/
			
			/*if (value == scope[propertyName])
			{
				return;
			}*/
			
			if (value == to)
			{
				return;
			}
			
			to = value;
			
			resetTween();
			
		}
		
		public function resetTween():void 
		{
			
			
		
			
			var newTween:Boolean = current < distanceTween;
			
			from = scope[propertyName];
			
			if (dynamicDuration)
			{
				distance = Math.abs(to - from);
			}
			else
			{
				distance = fadeIn + fadeOut;
			}
			
			distance *= durationMultiplayer;
			
			if (!isNaN(minDuration) && distance < minDuration) distance = minDuration; 
			
			distanceTween = Math.abs(distance);
			
			fadeIn = isNaN(fadeInValue) ? Math.abs(distance) * fadeInDuration : fadeInValue;
			fadeOut =  isNaN(fadeOutValue) ? Math.abs(distance) * fadeOutDuration : fadeOutValue;
			
			if (distanceTween < fadeIn ||  distanceTween < fadeOut) distanceTween = Math.max(fadeIn,fadeOut);
			
			distanceTween += current;
			
			
			
			
			if (newTween)
			{
				var a:Array = sliceBezier(bezier.getPercentForX(current));
				
				bezier.b.x = a[4];
				bezier.b.y = a[5];	
				
				if (bezier.b.x - current > distanceTween - current)
				{
					//distanceTween += bezier.b.x - distanceTween;
				}
				
				
			}
			else
			{
				bezier.b.x = current + fadeIn;
				bezier.b.y = from;
			}
			
			bezier.a.x = current;
			bezier.a.y = from;
			bezier.c.x = distanceTween - fadeOut;
			bezier.c.y = to;
			bezier.d.x = distanceTween;
			bezier.d.y = to;
		}
		
		
		
		public function update(e:Number):void 
		{
			
			if (updateMode == FRAME)
			{
				step();
			}
			else if (updateMode == TIME)
			{
				step(e/16);
			}
			
		}
		
		private function sliceBezier(t:Number):Array
		{
			t = 1 - t;
			
			
			var x4:Number = bezier.a.x // px1;
			var y4:Number = bezier.a.y // py1;
			var x3:Number = bezier.b.x // mx1;
			var y3:Number = bezier.b.y // my1;
			var x2:Number = bezier.c.x // mx2;
			var y2:Number = bezier.c.y // my2;
			var x1:Number = bezier.d.x // px2;
			var y1:Number = bezier.d.y // py2;
			
			
			

			var x12:Number = (x2 - x1) * t + x1;
			var y12:Number = (y2 - y1) * t + y1;

			var x23:Number = (x3 - x2) * t + x2;
			var y23:Number = (y3 - y2) * t + y2;

			var x34:Number = (x4 - x3) * t + x3;
			var y34:Number = (y4 - y3) * t + y3;

			var x123:Number = (x23 - x12) * t + x12
			var y123:Number = (y23 - y12) * t + y12;

			var x234:Number = (x34 - x23) * t + x23;
			var y234:Number = (y34 - y23) * t + y23;

			var x1234:Number = (x234 - x123) * t + x123;
			var y1234:Number = (y234 - y123) * t + y123;

			return [x1, y1, x12, y12, x123, y123, x1234, y1234];
		
		}
		
		
		/////////////// TESTS
		
		public function get control():Point
		{
			var p:Number = bezier.getPercentForX(current);
			
			if (p >= 1) return new Point();
			
			var a:Array = sliceBezier(p)
			
			var sx:Number = a[6];
			var sy:Number = a[7];

			var mx1:Number = a[4];
			var my1:Number = a[5];
			
			return new Point((mx1),  (my1));
			
		
		}
		
		public function get control2():Point
		{
			var p:Number = bezier.getPercentForX(current);
			
			if (p >= 1) return new Point();
			
			var a:Array = sliceBezier(p)
			
			var mx2:Number = a[2];
			var my2:Number = a[3];
			
			var mx1:Number = a[4];
			var my1:Number = a[5];
			
			return new Point((mx2),  (my2));
			
		}
		
		public function get slicedBiezer():ZvrBezier
		{
			
			var p:Number = bezier.getPercentForX(current);
			
			var a:Array = sliceBezier(p);
			
			return new ZvrBezier(
						new Point(a[6], a[7]),
						new Point(a[4], a[5]),
						new Point(a[2], a[3]),
						new Point(a[0], a[1])
						);
			
			
		}
		
		public function get c():Number 
		{
			return current;
		}
		
		public function get b():ZvrBezier 
		{
			return bezier;
		}
		
		public function get d():Number 
		{
			return distanceTween;
		}
		
	}

}