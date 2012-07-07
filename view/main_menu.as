package view {
	import flash.display.*;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	public class main_menu extends MovieClip {
		private var main_class:screen_manager;
		private var _movie:MovieClip;
		
		public function main_menu(passed_class:screen_manager) {
			_movie = new mainmenu;
			main_class = passed_class;
			addChild (_movie);
			_movie.play_button.addEventListener(MouseEvent.CLICK, this.on_play_button_clicked);
			_movie.play2_button.addEventListener(MouseEvent.CLICK, this.on_play2_button_clicked);
			_movie.highscore_button.addEventListener(MouseEvent.CLICK, this.on_highscore_button_clicked);
		}
		
		public function on_play_button_clicked(event:MouseEvent) {
			main_class.startGame(1);
		}
		
		public function on_play2_button_clicked(event:MouseEvent) {
			main_class.startGame(2);
		}
		
		public function on_highscore_button_clicked(event:MouseEvent) {
			main_class.show_highscore_screen(null, 0);
		}
	}
}