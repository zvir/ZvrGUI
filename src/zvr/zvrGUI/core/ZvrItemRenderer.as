package zvr.zvrGUI.core 
{
	import flash.events.MouseEvent;
	import zvr.zvrGUI.behaviors.ZvrSelectable;
	import zvr.zvrGUI.events.ZvrItemRendererEvent;
	import zvr.zvrGUI.events.ZvrSelectedEvent;
	
	/**
	 * @author	Michał Zwieruho "Zvir"
	 * @www	www.zvir.pl, www.celavra.pl
	 * @email	michal@zvir.pl
	 */
	
	 [Event(name="dataChange",    type="zvr.zvrGUI.events.ZvrItemRendererEvent")]
	 [Event(name="selectedChange",    type="zvr.zvrGUI.events.ZvrSelectedEvent")]
	 
	public class ZvrItemRenderer extends ZvrContainer
	{
		
		protected var _index:int;
		protected var _data:Object;
		protected var _dataContainer:ZvrDataContainer;
		
		protected var _selectableBehavior:ZvrSelectable;
		
		public function ZvrItemRenderer(skin:Class) 
		{
			super(skin);
			_selectableBehavior = new ZvrSelectable();
			behaviors.addBehavior(_selectableBehavior);
		}
		
		override protected function defineStates():void 
		{
			_states.define(ZvrStates.SELECTED);
		}
		
		public function set data(value:Object):void
		{
			if (_data == value) return;
			_data = value;
			_dispatchEvent(ZvrItemRendererEvent.DATA_CHANGE);
		}		
		
		public function get data():Object 
		{
			return _data;
		}
		
		public function get dataContainer():ZvrDataContainer 
		{
			return _dataContainer;
		}
		
		public function set dataContainer(value:ZvrDataContainer):void 
		{
			_dataContainer = value;
		}
		
		override public function addState(state:String):void 
		{
			var s:Boolean = checkState(ZvrStates.SELECTED);
			
			super.addState(state);
			
			if (state == ZvrStates.SELECTED && s != checkState(ZvrStates.SELECTED))
			{
				dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, this, !s));
			}
		}
		
		override public function removeState(state:String):void 
		{
			var s:Boolean = checkState(ZvrStates.SELECTED);
			
			super.removeState(state);
			
			if (state == ZvrStates.SELECTED && s != checkState(ZvrStates.SELECTED))
			{
				dispatchEvent(new ZvrSelectedEvent(ZvrSelectedEvent.SELECTED_CHANGE, this, !s));
			}
		}
		
		public function set selected(v:Boolean):void
		{
			tr("set selected", v);
			if (v)
				addState(ZvrStates.SELECTED);
			else
				removeState(ZvrStates.SELECTED);
		}
		
		public function get selected():Boolean
		{
			return checkState(ZvrStates.SELECTED);
		}
		
		public function get index():int 
		{
			return _index;
		}
		
		public function set index(value:int):void 
		{
			_index = value;
		}
		
		private function _dispatchEvent(type:String):void
		{
			dispatchEvent(new ZvrItemRendererEvent(type, this));
		}
		
		public function setup(virtual:ZvrVirtualItemRenderer):void
		{
			if (virtual.selected)
				super.addState(ZvrStates.SELECTED);
			else
				super.removeState(ZvrStates.SELECTED);
				
			data = virtual.data;
			index = virtual.index;
		}
		
	}

}