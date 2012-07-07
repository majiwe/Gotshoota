package model{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import view.*;
	import model.*;
	
	
	public class GenericModel extends EventDispatcher{
		public static const UPDATE:String='update';
		public static const DISTROY:String='distroy';		
		var _id:String;
		var _leben:int;
		var _energie:int;
		var _schaden:int;
		var _bewegungspattern_x: int; 
		var _bewegungspattern_y: int;
		var _punkte:int;
		var _x:int;
		var _y:int;
		
		public function GenericModel( id:String, life:int, eng:int,schad:int, punk:int, startx:int, starty:int, _bewx:int, _bewy:int ){
			_id =id;
			_leben=life;
			_energie = eng;
			_punkte = punk;
			_schaden = schad;
			_bewegungspattern_y = _bewy;
			_bewegungspattern_x = _bewx;
			_x = startx;
			_y = starty; 
		}
		
		public function get id():String{
			return _id;
		}
		
		//Methode um abzufragen ob man getroffen und zerstört wurde
		public function getHit(wert: int):Boolean{ 
			this.distroy();
			return true;
		}
		
		//Abfrage nach der Anzahl der Leben und der Energie
		public function get leben():int{ return _leben; }
		public function get energie( ):int{ return _energie; }
		
		//Abfrage nach der Feuerkraft
		public function get schaden():int{ return _schaden; }		
		
		
		public function setPunkte(wert: int ):void{ _punkte = _punkte + wert;}
		public function get punkte( ):int{ return _punkte; }
		

		// Abfrage der Koordinaten
		public function get x():Number{	return _x; }
		public function get y():Number{	return _y; }
		
		/* Funktionen um die Position zu verändern
		 * bei jeder Änderung wird ein Event ausgelöst,
		 * damit die Statusanzeige erneuert wird
		 */
		public function changePos():void{
			this._x -= _bewegungspattern_x;
			this._y -= _bewegungspattern_y;
			dispatchEvent(new Event(UPDATE));
		}
		public function set x(newX:Number):void{
			_x=newX;
			dispatchEvent(new Event(UPDATE));
		}
		public function set y(newY:Number):void{
			_y=newY;
			dispatchEvent(new Event(UPDATE));
		}

		function distroy(){
			dispatchEvent(new Event(DISTROY));
		}}}