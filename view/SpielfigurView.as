package view{
	
	import flash.display.Sprite;

	import model.SpielfigurModel;
	import flash.events.Event;
	
public class SpielfigurView extends GenericView{

	public function SpielfigurView(m:SpielfigurModel){
			super(m, null, new Player1, 0.25);
			if (m.id == "Player2"){
				updateView(new Player2,0.25);
			}
			this._model.addEventListener(SpielfigurModel.UPDATE,update);
			this._model.addEventListener(SpielfigurModel.DISTROY,distroy);
			this._movie.addEventListener(Event.ENTER_FRAME, this.eFrame);
			
			this.addEventListener(Event.REMOVED, this.removelistener);
		}
		
	override function eFrame (e:Event):void {
			setVisibility();
			SpielfigurModel(this._model).countd();
		}
		
	override function removelistener(e:Event):void {
			this._model.removeEventListener(SpielfigurModel.UPDATE,update);
			this._model.removeEventListener(SpielfigurModel.DISTROY,distroy);
			this._movie.removeEventListener(Event.ENTER_FRAME, this.eFrame);
			
			this.removeEventListener(Event.REMOVED, this.removelistener);
		
		}
		
		//funktion die immer prüft ob eine hitprotect gesetzt wird, falls ja wird die sichtbarkeit des spielers auf 50% gesetzt
		function setVisibility():void {
			if ( SpielfigurModel(this._model).protect_on() == true ) { this._movie.alpha = 0.5; }
			else { this._movie.alpha = 1; }}
}}
