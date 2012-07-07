package controller{

	import flash.display.*;
	import flash.ui.Keyboard;
	import model.*;
	import view.*;
	import flash.events.*;
	import flash.utils.Timer;
	
public class Steuerung{
		
      private static var instance:Steuerung;
      private static var allowInstantiation:Boolean;
      
	 private var main_class:game;
	 private var _p1:SpielfigurView;
	 private var _p2:SpielfigurView;
		
	 private var _levelTimer:Timer;
	 private var _delay:int;
	 private var _reruns:int;
		
	 private var playerCont;
		
	 private var p1leftDown:Boolean = false;
	 private var p1upDown:Boolean = false;
	 private var p1rightDown:Boolean = false;
	 private var p1downDown:Boolean = false;
	 private var p1Time:int = 0;
	 private var p1shootAllow:Boolean = true;
		
	 private var p2leftDown:Boolean = false;
	 private var p2upDown:Boolean = false;
	 private var p2rightDown:Boolean = false;
	 private var p2downDown:Boolean = false;
	 private var p2Time:int = 0;
	 private var p2shootAllow:Boolean = true;
		
	 private var mainSpeed:int = 5;
	 private var cLimit:int = 20;
	 private var playeranz =0;
	 private var hspunkte:Array = new Array(2);
	  
      public static function getInstance():Steuerung {
         if (instance == null) {
            allowInstantiation = true;
            instance = new Steuerung(new SteuerungPrivat());
            allowInstantiation = false;
          }
         return instance;
       }
	   public static function killInstance():Steuerung {
		  if (instance != null) {
            allowInstantiation = false;
            instance = null;
            allowInstantiation = true;
          }
         return instance;
	   }

		public function Steuerung(se:SteuerungPrivat){
		}

		public function defineClass(passed_class:game){
			main_class = passed_class;
			playerCont = main_class.players;
		}
	
	public function setTimer(delay: int):void{
		_levelTimer = new Timer (delay);
		_levelTimer.start();
		_levelTimer.addEventListener(TimerEvent.TIMER, main_class.levelincrease);

	}
	public function killTimer():void {
		_levelTimer.stop();
		_levelTimer.removeEventListener(TimerEvent.TIMER, main_class.levelincrease);
	}
		
	 public function moveChar(e:Event):void{
		 
	if(p1leftDown){
		_p1.model.x -= mainSpeed;
	}
	if(p1upDown){
		_p1.model.y -= mainSpeed;
	}
	if(p1rightDown){
		_p1.model.x += mainSpeed;
	}
	if(p1downDown){
		_p1.model.y += mainSpeed;
	}

	if(_p1.model.x >= 480){
		_p1.model.x -= mainSpeed;
	}
	if(_p1.model.y >= 640){
		_p1.model.y -= mainSpeed;
	}
	if(_p1.model.x <= 0){
		_p1.model.x += mainSpeed;
	}
	if(_p1.model.y <= 0){
		_p1.model.y += mainSpeed;
	}	
	if(p1Time < cLimit){
		p1Time ++;
	} else {
		p1shootAllow = true;
		p1Time = 0;
	}
	
	if(_p2){
	if(p2leftDown){
		_p2.model.x -= mainSpeed;
	}
	if(p2upDown){
		_p2.model.y -= mainSpeed;
	}
	if(p2rightDown){
		_p2.model.x += mainSpeed;
	}
	if(p2downDown){
		_p2.model.y += mainSpeed;
	}

	if(_p2.model.x >= 480){
		_p2.model.x -= mainSpeed;
	}
	if(_p2.model.y >= 640){
		_p2.model.y -= mainSpeed;
	}
	if(_p2.model.x <= 0){
		_p2.model.x += mainSpeed;
	}
	if(_p2.model.y <= 0){
		_p2.model.y += mainSpeed;
	}
	if(p2Time < cLimit){
		p2Time ++;
	} else {
		p2shootAllow = true;
		p2Time = 0;
	}}
	
}
// sobald die nötige Taste gedrückt wird, wird der boolean für den player und die richtung auf false gesetzt 
public function checkKeysDown(event:KeyboardEvent):void{
	if(event.keyCode == 27){
		main_class.backtomain();
	}	
	if(event.keyCode == 37 ){
		p1leftDown = true;
	}
	if(event.keyCode == 38 ){
		p1upDown = true;
	}
	if(event.keyCode == 39){
		p1rightDown = true;
	}
	if(event.keyCode == 40 ){
		p1downDown = true;
	}
	// unserer Schutzschild- und Feuerbutton wenn wir uns im Einzelspielermodus befinden
	if(!_p2){
	if(event.keyCode == 32 && p1shootAllow){
		p1shootAllow = false;
		var temp = SpielfigurModel(_p1.model).fireweapon();
		main_class.addPlayerBullet(temp);
		temp = null;
	}
	if(event.keyCode == 17){
		SpielfigurModel(_p1.model).schutzschild();
	}

	}
	
	// Dieser Teil wird aufgerufen, wenn wir uns im zweispielermodus befinden
	else if(_p2) {
		if(event.keyCode == 13 && p1shootAllow){
			p1shootAllow = false;
			var temp = SpielfigurModel(_p1.model).fireweapon();
			main_class.addPlayerBullet(temp);
			temp = null;
		}
	if(event.keyCode == 8){
		SpielfigurModel(_p1.model).schutzschild();
	}	
	
	if( event.keyCode == 65){
		p2leftDown = true;
	}
	if( event.keyCode == 87){
		p2upDown = true;
	}
	if( event.keyCode == 68){
		p2rightDown = true;
	}
	if( event.keyCode == 83){
		p2downDown = true;
	}
	if(event.keyCode == 32 && p2shootAllow){
		p2shootAllow = false;
		var temp2 = SpielfigurModel(_p2.model).fireweapon();
		main_class.addPlayerBullet(temp2);
		temp2 = null;
	}
	if(event.keyCode == 17){
		SpielfigurModel(_p2.model).schutzschild();
	}	
	}

}

// sobald die nötige Taste losgelassen wird, wird der boolean für den player und die richtung auf false gesetzt 
public function checkKeysUp(event:KeyboardEvent):void{
	
	if(event.keyCode == 37 ){
		p1leftDown = false;
	}
	if(event.keyCode == 38 ){
		p1upDown = false;
	}
	if(event.keyCode == 39 ){
		p1rightDown = false;
	}
	if(event.keyCode == 40 ){
		p1downDown = false;
	}
	if(_p2) {
	if(event.keyCode == 65){
		p2leftDown = false;
	}
	if(event.keyCode == 87){
		p2upDown = false;
	}
	if(event.keyCode == 68){
		p2rightDown = false;
	}
	if(event.keyCode == 83){
		p2downDown = false;
	}}
}


	public function addPlayer(playa:SpielfigurView):void {
		if (playeranz== 0){	
			_p1 = playa;
			playerCont.push(_p1);
			main_class.addChild(_p1);
			playeranz++;
			_p1.model.addEventListener(SpielfigurModel.DISTROY,playerdied);
			trace(playeranz);
		}else if (playeranz == 1){
			_p2 = playa;
			playerCont.push(_p2);
			main_class.addChild(_p2);
			playeranz++;
			_p2.model.addEventListener(SpielfigurModel.DISTROY,playerdied);
			trace(playeranz);
		}
	}
	
	public function eFrame(e:Event){
			moveChar(e);
		}
	
	public function addEnemyBullet(bullet:Object){
		main_class.addEnemyBullet(GenericView(bullet));
	}
	public function addExtra(extra:Object){
		main_class.addExtra(GenericView(extra));
	}

	public function extracollision(a1:Array,a2:Array) {
		for(var i:int = a2.length-1; (i >= 0); i--){
			for(var j:int =  a1.length-1; j >= 0; j--){
			var ec = a1[j];
			var ec2 = a2[i];
			
			if ((ec != null) && (ec2 != null)){
			if (ec2.hitTestObject(ec)){ 
				var Art = ec.model.id;
				var Wert = ec.model.wert;
				main_class.removeElement(j, a1);
				ec2.model.pickupExtra( Art,Wert);
			}}
		}}
	}
	public function collision(a1:Array,a2:Array) {
		for(var i:int = a2.length-1; (i >= 0); i--){
			for(var j:int =  a1.length-1; j >= 0; j--){
			var s = a1[j];
			var s2 = a2[i];

		if ((s != null) && (s2 != null)){
			
			var s_schaden =  s.model.schaden;
			var s2_schaden =  s2.model.schaden;
			if(s == "[object BulletView]"){
				var s_parent = s.model.getParent();
			}			
			if (s2.hitTestPoint(s.x, s.y, true)){ 
				if(s.model.getHit(s2_schaden) == true){
					if(s2.model.getHit(s_schaden) == true){
						if(s2.parent){
							main_class.removeElement(i, a2);
							if(s_parent){
								s_parent.setPunkte(s2.model.punkte);
							}
						}
					}
					if(s.parent){
						main_class.removeElement(j, a1);
					}
				}
			}
				s=s2=s_schaden=s2_schaden=s_parent= null;
			} 
		}}
	}
	
	// diese Methode wird aufgerufen, wenn einer der Spieler "stirbt"
	public function playerdied (e:Event){
		if(SpielfigurModel(e.target).id == "Player2"){
			hspunkte[1] = SpielfigurModel(e.target).punkte;
			main_class.removePlayer(_p2);
		}else if (SpielfigurModel(e.target).id == "Player1"){
			hspunkte[0] = SpielfigurModel(e.target).punkte;
			main_class.removePlayer(_p1);
		}
		
		if(playerCont.length==1){
			if(hspunkte[0]>=hspunkte[1]){
				main_class.gameOver(hspunkte[0]); }
			else { main_class.gameOver(hspunkte[0]);}	
		}
	}

}}
internal class SteuerungPrivat {}
