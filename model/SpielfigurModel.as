package model{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import model.*;
	import view.*;
	
	
	public class SpielfigurModel extends GenericModel{
		public static const UPDATE:String='update';
		public static const DISTROY:String='distroy';
		public static const DISPLAY:String='display';
		private var _bomben: int; 
		private var _schutzschild:int;
		private var hitprotect = 0;
		
		public function SpielfigurModel(id:String, startx:int, starty:int){
			super( id, 3, 100,10, 0, startx, starty, 0, 0);
			_bomben=0;
			_schutzschild=0;		
		}
		
		//methoden für Bomben, zwar noch nicht verwendet aber schon eingebaut für später
		public function set bombs(wert: int):void{ _bomben = _bomben+wert; }
		public function get bombs( ):int{ return _bomben; }
		
		// erhöhen und abfragen der Leben
		public function add_lifes( ):void{  _leben += 1; dispatchEvent(new Event(DISPLAY));}
		
		// überschreiben der SetPunkte, da sie auch für uns ein Update der Statusanzeige auslösen soll
		override public function setPunkte(wert: int ):void{ _punkte = _punkte + wert; dispatchEvent(new Event(DISPLAY)); }
		public function clear_points( ):void{ _punkte = 0; }
		
		public function setFeuerkraft(wert: int) :void { _schaden = _schaden + wert;}

		
		
		/*  Methode zum aktivieren des Hitprotect (Schutzschild), hält 200 Frames (also ca 4 sek) und kann nur aktiviert werden
		 *  wenn nicht schon eine Protection durch einen Hit oder durch ein gerade verlorenes Leben aktiv ist.
		 *  Funktioniert nur alle 7500 Frames (damit es nicht übermässig verwendet wird) 
		 */
		public function schutzschild( ):void{ if (_schutzschild==0) { _schutzschild = 7500; hitprotect= 200; }}
		// Abfrage ob eine Hitprotection an ist
		public function protect_on():Boolean { if(hitprotect>0){return true;} return false;}
		
		// herunterrechnen der schutzschildblockade und der Hitprotection
		public function countd ():void {
			if(hitprotect>0){ hitprotect--; }
			if (_schutzschild >0){ _schutzschild--;}
		}
		
		public function pickupExtra(extra:String, wert:int):void{ 
		
			if 		(extra == "Punkte"){  this.setPunkte(wert); }
			else if (extra == "Feuerkraft"){ this.setFeuerkraft(wert); }
			else if (extra == "Leben"){ this.add_lifes(); }
		}
		//methode um die Waffe abzufeuern
		public function fireweapon():GenericView{
				var nB:BulletModel = new BulletModel (this,_schaden, this.x,this.y,0,5);
				var newBullet:BulletView = new BulletView ( nB );
				return newBullet;
		}

		/* überschriebene Hit-Methode, solange getroffen wird der schaden von der Energie abgezogen.
		 * ist die Energie zu niedrig wird ein Leben abgezogen. Sobald kein leben mehr übrig bleibt 
		 * wird ein distroy-Event ausgelöst
		 */
		override public function getHit(wert: int):Boolean{ 				
			if (hitprotect==0){
				_energie = _energie - wert;
				hitprotect = 25;
				// dispatchEvent, damit der Statusscreen seine Werte updaten kann
				dispatchEvent(new Event(DISPLAY));
				if (this._energie <=0){
					_leben = _leben-1;
					if (this._leben == 0){
						this.distroy();
						return true;
						
						
						
					}else{
						hitprotect = 75;
						_energie = 100;
						// dispatchEvent, damit der Statusscreen seine Werte updaten kann
						dispatchEvent(new Event(DISPLAY));
						return false;
					}
				}}
				return false;
		}
		override function distroy(){
			dispatchEvent(new Event(DISTROY));
		}
	}
}