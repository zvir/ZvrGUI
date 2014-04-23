package clv.gui.core.display 
{
	
	/**
	 * ...
	 * @author Zvir Celavra
	 */
	public interface IContainerBody extends IComponentBody
	{
		function addElement(v:IComponentBody):void;
		function removeElement(v:IComponentBody):void;
		
		function getElementIndex(v:IComponentBody):int;
		function setElementIndex(v:IComponentBody, index:int):void;
	}
	
}