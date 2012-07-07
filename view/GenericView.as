package view {
	
	import flash.display.*;
	import controller.Steuerung;
	import model.*;
	import view.*;
	import flash.events.Event;
	
	public class GenericView extends MovieClip{
		var _model:GenericModel;
		var _steuerung:Steuerung;
		var _movie:MovieClip;
		
		public function GenericView(m:GenericModel, s:Steuerung, mov:MovieClip, scale:Number){
			_model=m;
			_steuerung=s;
			this.setmovie(mov, scale);
			this.x=_model.x;
			this.y=_model.y;
			addChild(_movie);
		}
		private function setmovie(mov:MovieClip, scale:Number):void{
			_movie= mov;
			_movie.name= _model.id;
			_movie.x=_movie.y=0;
			_movie.scaleX=_movie.scaleY=scale;
			
		}
		function updateView(gv:MovieClip,scale:Number){
			removeChild(_movie);
			this.setmovie(gv, scale);
			addChild(_movie);
			//this.setmovie(m, mov, _movie.scaleX);
		}
		function eFrame(e:Event):void{
			_model.changePos();
		}
		function update(e:Event):void{
			this.x=_model.x;
			this.y=_model.y;
			}
		function distroy(e:Event):void {
				 removelistener(e);
		}
		function removelistener(e:Event):void { 
		 }
		public function get model():GenericModel{ 
			return _model; 
		}
		public function get steuerung():Steuerung{ 
			return _steuerung; 
		}
		
	}}