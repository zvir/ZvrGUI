package clv.gui.core 
{
	import clv.gui.core.display.IContainerBody;
	import org.osflash.signals.Signal;
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface ICointainer 
	{
		
		function getChildIndex(child:IComponent):int;
		function addChild(child:IComponent):void;
		function removeChild(child:IComponent):void;
		
		function get onContentSizeChange():Signal;
		
		function get childrenBody():IContainerBody;
	}
	
}