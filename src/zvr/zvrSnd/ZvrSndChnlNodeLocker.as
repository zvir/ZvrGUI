package zvr.zvrSnd 
{
	import de.nulldesign.nd2d.display.Node2D;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Vector3D;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	/**
	 * ...
	 * @author Zvir
	 */
	public class ZvrSndChnlNodeLocker 
	{
		private var _sndChnl		:SoundChannel;
		private var _node			:Node2D;
		private var _scaleMax		:Number;
		private var _scaleMin		:Number;
		private var _volMax			:Number;
		private var _volMin			:Number;
		private var _point			:Point;
		private var _stopIfRemoved	:Boolean;
		private var _snd			:IZvrSnd;
		
		private var _active			:Boolean;
		
		public function ZvrSndChnlNodeLocker(snd:IZvrSnd, node:Node2D, point:Point = null, volMax:Number = 1, volMin:Number = 0, scaleMax:Number = 1, scaleMin:Number = 0, stopIfRemoved:Boolean = false):void
		{
			_snd = snd;
			_stopIfRemoved = stopIfRemoved;
			
			if (!snd) return;
			
			_sndChnl = _snd.play(0, 0, volMax);
			
			if (!_sndChnl) return;
			
			_active = true;
			
			_point = point ? point : new Point();
			_volMin = volMin;
			_volMax = volMax;
			_scaleMin = scaleMin;
			_scaleMax = scaleMax;
			_node = node;
			
			if (node.stage)
			{
				_sndChnl.addEventListener(Event.SOUND_COMPLETE, soundComplete);
				node.stage.addEventListener(Event.ENTER_FRAME, enterFrame);
				node.addEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
				enterFrame(null);
			}
			else
			{
				dispose();
			}
			
		}
		
		private function removedFromStage(e:Event):void 
		{
			_node.stage.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			if (_stopIfRemoved) _sndChnl.stop();
			
			dispose();
		}
		
		private function enterFrame(e:Event):void 
		{
			if (!_node || !_node.stage )
			{
				trace("ZvrSndChnlNodeLocker ERROR", _node, (_node ? _node.stage : ""));
				e.target.removeEventListener(Event.ENTER_FRAME, enterFrame);
				dispose();
				return;
			}
			
			var s:Number = _node.worldModelMatrix.deltaTransformVector(Vector3D.X_AXIS).length;
			//trace(s.toFixed(3));
			
			if (s > _scaleMax) s = _scaleMax;
			if (s < _scaleMin) s = _scaleMin;
			
			var v:Number = (s - _scaleMin) / (_scaleMax - _scaleMin) * (_volMax - _volMin) + _volMin; 
			
			var p:Point = _node.localToGlobal(_point);
			var pn:Number = (p.x / _node.stage.stageWidth - 0.5)  * 2;
			
			var s2:Number = 1 - Math.abs(_node.stage.stageWidth * 0.5 - p.x) / (_node.stage.stageWidth);
			
			if (s2 < 0.1) s2 = 0.1;
			if (s2 > 1) s2 = 1;
			
			v *= s2;
			var st:SoundTransform = new SoundTransform();
			st.volume = v * _snd.globalVolume;
			st.pan = pn;
			
			_sndChnl.soundTransform = st;
			
		}
		
		private function soundComplete(e:Event):void 
		{
			dispose();
		}
		
		public function dispose():void
		{
			if (_sndChnl) 	_sndChnl.removeEventListener(Event.SOUND_COMPLETE, soundComplete);
			if (_node) 		_node.removeEventListener(Event.REMOVED_FROM_STAGE, removedFromStage);
			
			if (_node && _node.stage) _node.stage.removeEventListener(Event.ENTER_FRAME, enterFrame);
			
			_node = null;
			_sndChnl = null;
			
			
		}
		
		public function get active():Boolean 
		{
			return _active;
		}
		
	}

}