package model{
	import view.*;
	import flash.display.*;
	import flash.events.*; 
	
	public class BulletModel extends GenericModel{
		public static const UPDATE:String='update';
		public static const DISTROY:String='distroy';	
		private var _paren:GenericModel;
		
			
		public function BulletModel(paren:GenericModel, schad:int, startx:int, starty:int, bewx:int, bewy:int){
			super( "bullet",1,0,schad, 10, startx, starty, bewx, bewy);
			_paren = paren;
			
		}
		// Zusätliche Funktion für die Abfrage wer die Kugel abgeschossen hat
		public function getParent(): GenericModel {
			return _paren;
		}
								  
		// überschreiben der getHit-Methode der Elternklasse  
		override public function getHit(wert: int):Boolean{ 
			this.distroy();
			return true;
		}
		
	}
}