package view{
	import flash.display.Sprite;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.*;
	
	public class highscore extends MovieClip{
		private var username:String="";
		private var points:uint=0;
		private var xml:XML = new XML();
		private var myRequest:URLRequest=new URLRequest("xml/highscore.xml?");
		private var loader:URLLoader = new URLLoader();
		private var main_class:screen_manager;
		private var _movie:MovieClip;

		public function dataLoaded(e:Event):void {
		xml=XML(e.currentTarget.data);
		checkHighscore();
		}
		
		public function highscore(passed_class:screen_manager, spielername:String, punkte:int) {
		_movie = new highscore_screen;
		addChild(_movie);
		if (spielername==null || punkte==0){
			displayHighscore();
			trace("NULL or 0 IN ENTRY: "+spielername+"   "+punkte);
			displayHighscore()
			}
			else{
				username=spielername;
				points=punkte;
				checkHighscore();
			}
			loader.load(myRequest);
			loader.addEventListener(Event.COMPLETE,dataLoaded);
			
			main_class = passed_class;
			_movie.back_button.addEventListener(MouseEvent.CLICK, on_back_button_clicked);
		}
		public function on_back_button_clicked(event:MouseEvent) {
			main_class.show_main_menu();
		}
		
		public function checkHighscore():void {
			var newHighScore:Boolean=false;
			var scoreIndex:uint;
			for (var i:uint=0; i<xml.score.length(); i++) {
				if (points>Number(xml.score[i].@points)) {
					newHighScore=true;
					scoreIndex=i;
					break;
				}
			}
			if (newHighScore==true) {
				for (i=xml.score.length()-1; i>scoreIndex; i--) {
					xml.score[i].@name=xml.score[i-1].@name;
					xml.score[i].@points=xml.score[i-1].@points;
				}
				xml.score[scoreIndex].@name=username;
				xml.score[scoreIndex].@points=points;
				var myRequest:URLRequest=new URLRequest("php/save_xml_original.php?");
				var myLoader:URLLoader = new URLLoader();
				var myVars:URLVariables = new URLVariables();
				myVars.xmlString=xml.toString();
				myRequest.data=myVars;
				myRequest.method=URLRequestMethod.POST;
				myLoader.load(myRequest);
				myLoader.addEventListener(Event.COMPLETE,completeHandler);
				myLoader.addEventListener(IOErrorEvent.IO_ERROR,ioErrorHandler);
				myLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR,securityHandler);
			} else {
				displayHighscore();
				
				
			}
		}
		public function ioErrorHandler(e:IOErrorEvent):void {
			trace("IO-ERROR");
		}
		public function securityHandler(e:SecurityErrorEvent):void {
			trace("Security-Error");
		}
		public function completeHandler(e:Event):void {
			displayHighscore();
		}
		public function displayHighscore():void {
			for (var i:uint=0; i<xml.score.length(); i++) {
				this["player"+i].text=xml.score[i].@name;
				this["points"+i].text=xml.score[i].@points;
			}
		}
	}
}