package {
	import flash.display.*;
	import flash.events.*;
	import model.*;
	import controller.*;
	import view.*;


	public class screen_manager extends MovieClip {
		private var main_menu_screen:MovieClip;
		private var play_screen:MovieClip;
		private var game_over_screen:MovieClip;
		private var highscore_screen:MovieClip;
	
		public function screen_manager() {
			show_main_menu();
		}


		public function show_main_menu() {
			main_menu_screen = new main_menu(this);
			if (highscore_screen) {
				removeChild(highscore_screen);
				highscore_screen = null;
			}
			else if(play_screen){
				removeChild(play_screen);
				play_screen = null;
			}
			addChild(main_menu_screen);
		}
		public function show_highscore_screen(nam:String, punkt:int) {
			highscore_screen = new highscore(this,nam,punkt);
			if (main_menu_screen) {
				removeChild(main_menu_screen);
				main_menu_screen = null;
			}
			if (game_over_screen) {
				removeChild(game_over_screen);
				game_over_screen = null;
			}
			addChild(highscore_screen);
		}
		public function show_game_over_screen(punkt:int) {
			game_over_screen = new game_over(this, punkt);
			trace(punkt);
			removeChild(play_screen);
			play_screen = null;
			addChild(game_over_screen);
			
		}
		public function startGame(playeranzahl:int) {
			play_screen = new game(this,playeranzahl);
			if (main_menu_screen) {
				removeChild(main_menu_screen);
				main_menu_screen = null;
			}
			if (highscore_screen) {
				removeChild(highscore_screen);
				highscore_screen = null;
			}
			if (game_over_screen) {
				removeChild(game_over_screen);
				game_over_screen = null;
			}
			addChild(play_screen);
		}
		
	}
}