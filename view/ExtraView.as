package view{
	
	import flash.display.*;
	import controller.Steuerung;
	import model.*;
	import flash.events.*;
	
public class ExtraView extends GenericView{
	public function ExtraView(m:ExtraModel){
		super(m, null, new Extra_Generic, 0.4)
		if(_model.id =="Feuerkraft") { updateView( new Extra_Feuerkraft, 0.4);}
		else if(_model.id =="Punkte") { updateView( new Extra_Punkte, 0.4);}
		else if(_model.id =="Leben") { updateView( new Extra_Leben, 0.4);}
	}	
		
	override function removelistener(e:Event):void {
	}
		
	}
}