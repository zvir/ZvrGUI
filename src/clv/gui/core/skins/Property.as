package clv.gui.core.skins 
{
	import clv.gui.core.IComponent;
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public class Property 
	{
		public var component:IComponent;
		public var property:String;
		
		public function Property(component:IComponent, property:String)
		{
			this.component = component;
			this.property = property;
		}
	}

}