package model{
	import view.*;
	import flash.display.*;
	import flash.events.*; 
	
	public class ExtraModel extends GenericModel{

		var _wert:int;
		
			
		public function ExtraModel(Art:String, Wert:int, startx:int, starty:int){
			super( Art, 1, 0, 0, 0, startx, starty, 0, 0);
			_wert = Wert;
			
		}
		public function get wert():int {
			return _wert;
		}
		// überschreiben der getHit-Methode der Elternklasse  
		override public function getHit(wert: int):Boolean{ 
			this.distroy();
			return true;
		}
		
	}
}