package zvr.zvrGUI.components.g2d 
{
	import clv.games.dribbler2.countries.Country;
	import clv.games.dribbler2.textures.ui.UITex;
	import flash.events.MouseEvent;
	import zvr.zvrGUI.core.custom.IZvrDataListItem;
	import zvr.zvrGUI.skins.g2d.ZvrG2DFNTStyle;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrG2DListItem extends ZvrG2DGroup implements IZvrDataListItem
	{
		
		private var _bg:ZvrG2DSprite;
		private var _label:ZvrG2DLabel;
		
		private var _next:IZvrDataListItem;
		private var _prev:IZvrDataListItem;
		private var _data:Country;
		
		public function ZvrG2DListItem() 
		{
			super();
			
			percentWidth = 100;
			height = 100;
			
			_bg = new ZvrG2DSprite(UITex.ButtonBGTxt);
			_bg.autoSizeToTexture = false;
			_bg.percentWidth = 100;
			_bg.percentHeight = 100;
			_bg.node.transform.color = 0xFFFFBF00;
			//_bg.node.transform.alpha = 0.7;
			addChild(_bg);
			
			_label = new ZvrG2DLabel(UITex.UNI_05_53_0_FONT);
			_label.setStyle(ZvrG2DFNTStyle.FONT_SIZE, 32);
			_label.setStyle(ZvrG2DFNTStyle.FONT_COLOR, 0x000000);
			addChild(_label);
			
			_label.y = -10;
			_label.x = 6;
			
		}
		
		public function setItemAfterPosition(listPostition:Number, itemPosition:Number):Boolean
		{
			
			var i:int = itemPosition as int;
			
			//if (i >= 0 && i < 3) height = 200; else height = 100;
			
			node.active = true;
			
			var h:Number = ((10 - Math.abs(itemPosition)) / 10); 
			
			if (h < 0.1) h = 0.1;
			
			height = 300 * h;
			
			if (prev) 
			{
				y = prev.bounds.bottom + 5;
			}
			else 
			{
				y = -(height + 5) * (listPostition - Math.floor(listPostition));
			}
			
			return bounds.bottom +5 < owner.childrenAreaHeight;
			
		}
		
		public function setItemBeforePosition(position:Number, itemPosition:int):Boolean 
		{
			var i:int = itemPosition as int;
			
			node.active = false;
			
			var h:Number = ((10 - Math.abs(itemPosition)) / 10); 
			
			if (h < 0.1) h = 0.1;
			
			height = 300 * h;
			
			if (next) 
			{
				y = next.y - bounds.height - 5;
			}
			
			return bounds.top > -owner.childrenAreaHeight;
		}
		
		public function getPercentScrol(v:Number):Number 
		{
			var p:Number = v / (bounds.height + 5);
			
			if (Math.abs(p) > 1)
			{
				if (p > 0 &&  next) p = next.getPercentScrol(v - (bounds.height + 5)) + 1;
				if (p < 0 &&  prev) 
				{
					p = prev.getPercentScrol(v + (bounds.height + 5)) - 1;
				}
			}
			
			return p;
		}
		
		/* INTERFACE zvr.zvrGUI.core.custom.IZvrDataListItem */
		
		public function getEnd():Number 
		{
			return owner.childrenAreaHeight - bounds.bottom - 5;
		}
		
		/* INTERFACE zvr.zvrGUI.core.custom.IZvrDataListItem */
		
		public function get next():IZvrDataListItem 
		{
			return _next;
		}
		
		public function set next(value:IZvrDataListItem):void 
		{
			_next = value;
		}
		
		public function get prev():IZvrDataListItem 
		{
			return _prev;
		}
		
		public function set prev(value:IZvrDataListItem):void 
		{
			_prev = value;
		}
		
		public function get data():Object 
		{
			return _label.text;
		}
		
		public function set data(data:Object):void 
		{
			if (!data)
			{
				visible = false;
				return;
			}
			
			visible = true;
			
			if (_data == data) return;
			
			_data = data  as Country;
			
			_label.text = _data.name.toUpperCase();
		}
		
	}

}