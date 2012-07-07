package view{
	
	import flash.display.*;
	import controller.Steuerung;
	import model.*;
	import flash.events.*;
	
public class BulletView extends GenericView{
	public function BulletView(m:BulletModel){
		super(m, null, new BulletMovie, 0.4)
			this._model.addEventListener(BulletModel.UPDATE, this.update);
			this._model.addEventListener(BulletModel.DISTROY, this.distroy);
			//_movie.addEventListener(Event.ADDED, beginClass);
			this._movie.addEventListener(Event.ENTER_FRAME, this.eFrame);
			this.addEventListener(Event.REMOVED, this.removelistener);
		}	
		
	override function removelistener(e:Event):void {
		this.removeEventListener(Event.REMOVED, this.removelistener);
		this._movie.removeEventListener(Event.ENTER_FRAME, this.eFrame);
		this._model.removeEventListener(BulletModel.UPDATE, this.update);
		this._model.removeEventListener(BulletModel.DISTROY, this.distroy);
					
	}
		
	}
}