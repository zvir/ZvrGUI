package zvr.zvrGUI.components.minimalDark 
{
	import zvr.zvrGUI.core.ZvrGroup;
	/**
	 * ...
	 * @author Zvir
	 */
	public class PropertyValue extends ZvrGroup
	{
		
		public var property:LabelMD = new LabelMD();
		public var value:LabelMD = new LabelMD();
		
		public function PropertyValue() 
		{
			super();
			
			property.labelAutoSize = false;
			property.width = 100;
			property.height = 15;
			
			value.labelAutoSize = false;
			value.width = 100;
			value.height = 15;
			value.x = 100;
			
			width = 200;
			height = 15;
			
			addChild(property);
			addChild(value);
			
			
		}
		
	}

}