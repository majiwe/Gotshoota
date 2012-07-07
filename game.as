package {
	import flash.display.*;
	import flash.events.*;
	import model.*;
	import controller.*;
	import view.*;

		
	public class game extends MovieClip {	
		private var main_class:screen_manager;
		private var _stage:MovieClip;
		
		private var _levelView:LevelView;

		private var _spielfigur1:SpielfigurView;
		private var _spieler1:SpielfigurModel;

		private var _spielfigur2:SpielfigurView;
		private var _spieler2:SpielfigurModel;
		
		private var _spielercontrol:Steuerung;
		private var _spielercontrol2:Steuerung;
		
		private var _p1stats:StatusView;
		private var _p2stats:StatusView;
		
		private var enemyEnergie:int = 10;
		private var enemySchaden:int = 5;
		private var enemyTime:int = 0;
		private var enemyLimit:int = 200;
		private var level_count:int = 1;
		private var shootLimit:int = 150;

		private var enemies:Array = new Array;
        private var bullets:Array = new Array;
		public var players:Array = new Array;
		private var enemybullets:Array = new Array;
		private var extras:Array = new Array;
		
		public function game(passed_class:screen_manager, playeranzahl:int) :void {
			main_class = passed_class;
			_stage = main_class;
			_levelView=new LevelView();
			addChild(_levelView);
		
			//setzen unserer Playersteuerung
			
			_spielercontrol=Steuerung.getInstance();	
			_spielercontrol2=Steuerung.getInstance();	
			_spielercontrol.defineClass(this);
			_spielercontrol.setTimer(60000);
			
			_spieler1=new SpielfigurModel("Player1",340, 320);
			_spielfigur1=new SpielfigurView(_spieler1);
			_spielercontrol.addPlayer(_spielfigur1);
			_p1stats = new StatusView(_spieler1,5,10);
			addChild(_p1stats);
			
			if (playeranzahl == 2){
				_spieler2=new SpielfigurModel("Player2",140, 320);
				_spielfigur2=new SpielfigurView(_spieler2);
				_spielercontrol2.addPlayer(_spielfigur2);
				_p2stats = new StatusView(_spieler2,300,10);
				addChild(_p2stats);
			}
		
		this._stage.stage.addEventListener(KeyboardEvent.KEY_DOWN, _spielercontrol.checkKeysDown);
		this._stage.stage.addEventListener(KeyboardEvent.KEY_UP,_spielercontrol.checkKeysUp);
		this.addEventListener(Event.ENTER_FRAME, this.eFrame);
		}

		// Alle Funktionen die dann mit jedem Frame ausgeführt werden, 
		// sobald der game-screen zum Main-Screen der Flashanwendung hinzugefügt wurde
		private function eFrame(e:Event){
			addEnemy(e);
			_spielercontrol.extracollision(extras, players);
			_spielercontrol.collision(bullets, enemies);
			_spielercontrol.collision(enemies, players);
			_spielercontrol.collision(enemybullets, players);
			_spielercontrol.eFrame(e);
			cleanStage(enemies); 
			cleanStage(bullets);
			cleanStage(enemybullets);
		}
		
		//unsere Funktion damit wir das Spiel abbrechen und zum Mainscreen zurückkehren
		public function backtomain(){
			removelistener();
			main_class.show_main_menu();
		}
		//unsere Funktion damit wir das Spiel beenden und das Highscore aktivieren und ihm den höchsten Punktestand übergeben
		public function gameOver(punkte:int) {
			removelistener();
			main_class.show_game_over_screen(punkte);
		}
		
		function removelistener(){
			_spielercontrol.killTimer();	
			this.removeEventListener(Event.ENTER_FRAME, this.eFrame);	
			this._stage.stage.removeEventListener(KeyboardEvent.KEY_DOWN, _spielercontrol.checkKeysDown);
			this._stage.stage.removeEventListener(KeyboardEvent.KEY_UP,_spielercontrol.checkKeysUp);
			enemies = null;
			bullets = null;
			players = null;
			_spielercontrol= Steuerung.killInstance();			
		}
		
		// hier wird das Level und die Schwierigkeit erhöht
		public function levelincrease(e:Event):void {
			if(enemyLimit > 30){ 
				enemyLimit -= 10; 
				enemySchaden += 5;
				enemyEnergie +=10;
				shootLimit -= 10;
				level_count++;
				trace("LEVEL: "+level_count);
			}
		
		}
		
		// Funktion um unsere Gegner auf die Stage und unser zuhörige Array hinzuzufügen
		public function addEnemy(e:Event) {
			if(enemyTime < enemyLimit){
				enemyTime ++;
			} else {
		
			var nE_y = -10;
			var nE_x = int(Math.random()*(stage.stageWidth));
			var nE_by = int(Math.random()*2)-2;
			var nE_bx = 0;
			var nE_schad = int(Math.random()*enemySchaden)*5;
			var nE_eneg = int(Math.random()*enemyEnergie)*5;
			var nE_cL = shootLimit;
			
			var newEnemy = new GegnerModel(nE_x, nE_y,nE_bx,nE_by, nE_schad,nE_eneg, nE_cL);
			var newEnemyView = new GegnerView( newEnemy, _spielercontrol );
			enemies.push(newEnemyView);
			this.addChild(newEnemyView);
			enemyTime = 0;
			}
		}
		// Funktion um die Spieler- und Gegnerbullets auf die Stage und die dazuhörigen Arrays hinzuzufügen
		public function addPlayerBullet(bullet:GenericView){
				this.addChild(bullet);
				bullets.push(bullet);
		}
		public function addEnemyBullet(bullet:GenericView){
				this.addChild(bullet);
				enemybullets.push(bullet);
		}
		public function addExtra(extra:GenericView){
				this.addChild(extra);
				extras.push(extra);
		}
		
		// funktionen um Objekte die die sichtbare Stage verlassen haben zu entfernen
		public function cleanStage(elements:Array )         {             
			for(var i = elements.length-1; i > 0 ; i--) {                 
			  	if((elements[i].y < -50) || (elements[i].y > 700)){                     
			  		this.removeElement(i, elements);
				}                             
			else if((elements[i].x < 0) || (elements[i].x > 480)) {
					this.removeElement(i, elements);
				}             
			}        
		}
		
		// funktionen um die Spieler von der Stage und dem Array zu nehmen
		// wird über Steuerung  und dann die Funktion gameOver ausgelöst
		public function removePlayer(p:SpielfigurView):void {
			var index = players.indexOf(p); trace ("index: "+index);
			if (index) {
				if(p.parent){
					this.removeChild(p);
				}
				players.splice(index,1);
			}
		}
		
		// generische Funktion um Elemente von der Stage und ihren Arrays zu nehmen
		public function removeElement(ind:int, a:Array):void {
				this.removeChild(a[ind]);
				a.splice(ind,1);	
		}

}}