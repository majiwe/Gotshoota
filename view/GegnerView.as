package view{
	import flash.display.*;
	import controller.Steuerung;
	import model.*;
	import view.*;
	import flash.events.*;
	
public class GegnerView extends GenericView{
	var temp:MovieClip;
	
	public function GegnerView(m:GegnerModel, s:Steuerung){
			super(m, s, (new Gegner), 0.4);
			if (m.schaden > 20){
				updateView(new Gegner2, 0.4);
			}
			this._model.addEventListener(GegnerModel.UPDATE, this.update);
			this._model.addEventListener(GegnerModel.DISTROY, this.distroy);
			this._movie.addEventListener(Event.ENTER_FRAME, this.eFrame);
			
			this.addEventListener(Event.REMOVED, this.removelistener);
		}
		
	override function removelistener(e:Event):void {
			this.dropExtra();
			this._model.removeEventListener(GegnerModel.UPDATE, this.update);
			this._model.removeEventListener(GegnerModel.DISTROY, this.distroy);
			this._movie.removeEventListener(Event.ENTER_FRAME,this.eFrame);
			
			this.removeEventListener(Event.REMOVED, this.removelistener);
	}
	
	//die funktionen die Aufgerufen werden sobald der Gegner zur Stage hinzugefügt wird
	override function eFrame(e:Event):void{
			shoot();
			//dropExtra();
			_model.changePos();
		}
		
		function shoot(){
			temp = GegnerModel(this._model).fireweapon();
			if (temp != null){
			_steuerung.addEnemyBullet(temp);}
		}
		function dropExtra(){
			temp = GegnerModel(this._model).dropExtras();
			if (temp != null){
			_steuerung.addExtra(temp);}
		}
}}