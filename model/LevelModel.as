package model{
import flash.events.EventDispatcher;
	import flash.events.Event;
	
	
	public class LevelModel extends EventDispatcher{
		public static const UPDATE:String='update';
		private var _x:int =0;
		private var _y:int = 0;
		
		public function LevelModel(){			
		}
		public function get x():Number{
			return _x;
		}
		public function set x(newX:Number):void{
			
			_x=newX;
			dispatchEvent(new Event(LevelModel.UPDATE))
		}
		
		public function get y():Number{
			return _y;
		}
		public function set y(newY:Number):void{
			_y=newY;
			dispatchEvent(new Event(LevelModel.UPDATE))
		}
	}}