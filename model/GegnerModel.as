package model{
	
	import flash.events.EventDispatcher;
	import flash.events.Event;
	import view.*;
	
	
	public class GegnerModel extends GenericModel{
		public static const UPDATE:String='update';
		public static const DISTROY:String='distroy';
		public static const SHOOT:String='shoot';
		private var sTime:int = 0;
		private var sLimit:int;
			
		public function GegnerModel( startx:int, starty:int, _bewx:int, _bewy:int, schad:int, eng:int, sL:int){
			super("enemy", 1, eng ,schad , 10, startx, starty, _bewx, _bewy);
			sLimit = sL;
		}

		public function fireweapon():GenericView{
			if(sTime < sLimit){
				sTime ++;
				return null;
			} else {
				var nB:BulletModel = new BulletModel (this,_schaden,this.x,this.y,0,(_bewegungspattern_y)-2);
				var newBullet:BulletView = new BulletView ( nB );
				sTime = 0;
				return newBullet;
				
			}
		}
		
		public function dropExtras():GenericView{
				var art_zahl = int(Math.random()*29+1);
				var Art;
				var wert = 10;
				if 		( (art_zahl == 1) || (art_zahl == 15) || (art_zahl== 23) ){ Art = "Punkte"; }
				else if	( (art_zahl == 2) || (art_zahl == 10) ){ Art= "Feuerkraft"; }
				else if ( art_zahl == 3){ Art = "Leben"; }
				
				if (Art == null){ return null; }
				var nEx:ExtraModel = new ExtraModel (Art,wert,this.x,this.y);
				var newExtra:ExtraView = new ExtraView ( nEx );
				return newExtra;
				
		}
		
		// überschreiben der getHit-Methode der Elternklasse
		// sobald der energielevel des schiffes nur noch 0% hat wird es zerstört
		override public function getHit(wert: int):Boolean{ 
			_energie -= wert;
			if(_energie <= 0){
				this.distroy();
				return true; 
			}
			return false;
		}

}}