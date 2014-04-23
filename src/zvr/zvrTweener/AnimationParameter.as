package zvr.zvrTweener 
{
	/**
	 * ...
	 * @author Zvir
	 */
	public class AnimationParameter 
	{
		
		public var parameterName:String;
		public var startValue:*;
		public var endValue:*;
		public var currentValue:*;
		
		
		public function AnimationParameter(parameterName:String, startValue:*, endValue:*) 
		{
			this.parameterName = parameterName;
			this.startValue = startValue;
			this.endValue = endValue;
			this.currentValue = startValue;
		}		
		
	}

}