package view{
	import flash.display.*;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	public class game_over extends MovieClip {
		public var main_class:screen_manager;
		private var _myName:String;
		private var _myPunkte:int;
		private var _movie:MovieClip;
		
		public function game_over(passed_class:screen_manager, punkt:int) {
			main_class = passed_class;
			_movie = new gameover_screen;
			addChild(_movie);
			_myPunkte = punkt;
			_movie.enter_highscore_button.addEventListener(MouseEvent.CLICK, enter_highscore_button_clicked);
		}
		
		public function enter_highscore_button_clicked(event:MouseEvent) {
			_myName = _movie.name_txt.text;
			main_class.show_highscore_screen(_myName,_myPunkte);
		}
	
		public function get myName():String{
			return _myName;
		}
		
	}
}