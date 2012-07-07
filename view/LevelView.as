package view{
	
	import flash.display.*;
	import model.*;
	import flash.events.Event;
	
public class LevelView extends Sprite{
	var _movie:MovieClip;
	var _model:LevelModel;
	
	var b1:Sprite  = new mc_jpeg_bg1();
	var b2:Sprite  = new mc_jpeg_bg2();
	var b3:Sprite  = new mc_jpeg_bg3();
	var b4:Sprite  = new mc_jpeg_bg4();
	var b5:Sprite  = new mc_jpeg_bg5();
	
	var bg1=b1;
	var bg2=b2;
	
	var currentBG = bg1;

	
	public function LevelView(){
		
			_movie=new MovieClip();
			_movie.name='level_mc';
			addChild(_movie);
			_movie.x=_movie.y=0;
			_movie.scaleX=_movie.scaleY=0.1
			bg1.y = 0;
			bg1.x = 240;
			bg2.y = bg1.y - bg1.height;
			bg2.x = 240;

			addChild(bg1);
			addChild(bg2);
			
			addEventListener(Event.ENTER_FRAME, scroll);
		}



// Wie der Name der Funktion vermuten lässt  wird in dieser Funktion der Background durchgescrollt
function scroll(evt:Event):void {
	
    bg1.y += 10;
    bg2.y += 10;
    
    if(currentBG.y > currentBG.height) {
        if(currentBG == bg1) {
            bg1.y = bg2.y - bg2.height;
 			
            currentBG = bg2;
			//sichern der Position und entfernen des MovieClips
			var temp1 = bg1.y;
			var temp2 = bg1.x;
			removeChild(bg1);
			// Hier wird der entladene MovieClip überschrieben
				if      (""+bg1 == "[object mc_jpeg_bg1]"){ bg1 = b3;}
				else if (""+bg1 == "[object mc_jpeg_bg2]"){ bg1 = b4;}
				else if (""+bg1 == "[object mc_jpeg_bg3]"){ bg1 = b5;}
				else if (""+bg1 == "[object mc_jpeg_bg4]"){ bg1 = b1;}
				else if (""+bg1 == "[object mc_jpeg_bg5]"){ bg1 = b2;}

			// und anschliessend mit alter Position wieder eingefügt
			bg1.y= temp1;
			bg1.x =temp2;
			addChild(bg1);	

        } else {
            bg2.y = bg1.y - bg1.height;
     
			currentBG = bg1;
			temp1 = bg2.y;
			temp2 = bg2.x;
			removeChild(bg2);
				if      (""+bg2 == "[object mc_jpeg_bg1]"){ bg2 = b3;}
				else if (""+bg2 == "[object mc_jpeg_bg2]"){ bg2 = b4;}
				else if (""+bg2 == "[object mc_jpeg_bg3]"){ bg2 = b5;}
				else if (""+bg2 == "[object mc_jpeg_bg4]"){ bg2 = b1;}
				else if (""+bg2 == "[object mc_jpeg_bg5]"){ bg2 = b2;}
			bg2.y = temp1;
			bg2.x = temp2;
			addChild(bg2);
        }
    }

}
}}

