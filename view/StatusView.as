package view{
	
	import flash.display.Sprite;

	import model.*;
	import flash.events.Event;
	import flash.text.*;

	
public class StatusView extends Sprite{
	private var _model:SpielfigurModel;
	private var id: String;
	
	private var f1:TextFormat;
	private var f2:TextFormat;
	
	private var id_label:TextField;
	private var health_label:TextField;
	private var life_label:TextField;
	private var punkte_label:TextField;
	
	private var id_anz:TextField;
	private var health_anz:TextField;
	private var life_anz:TextField;
	private var punkte_anz:TextField;
	
	
	public function StatusView(m:SpielfigurModel, gx:int, gy:int){
			_model=m;
			this.name="stat_"+_model.id;
			this.id=_model.id;
			
			f1 = new TextFormat("Verdana", 15, 0xFFFFFF,1);
			f2 = new TextFormat("Verdana", 13, 0xFFFF00,0);
			id_label = createTextField(10, 10, f1);
			id_anz = createTextField(40, 12, f2);
			health_label = createTextField(10, 35, f1);
			health_anz = createTextField(70, 37, f2);
			life_label = createTextField(10, 60, f1);
			life_anz = createTextField(75, 62, f2);
			punkte_label = createTextField(10,85, f1);
			punkte_anz = createTextField(75,87, f2);
			
			this.x=gx;
			this.y=gy;
			
			id_label.text = "ID:";
			health_label.text ="Health";
			life_label.text ="Leben";
			punkte_label.text ="Punkte";
			this.addChild(id_label);
			this.addChild(health_label);
			this.addChild(life_label);
			this.addChild(punkte_label);
			
			this.addChild(id_anz);
			this.addChild(health_anz);
			this.addChild(life_anz);
			this.addChild(punkte_anz);
			this.update(null);

			
			// sobald das zugehörige Model ein Dispatchevent DISPLAY auslöst
			// greift sich das StatusView die Werte vom Model und erneuert die Anzeige
			_model.addEventListener(SpielfigurModel.DISPLAY,update);

		}
		
		private function update(e:Event):void{
			id_anz.text = _model.id;
			if (_model.energie>=0){
				health_anz.text =""+ _model.energie;
				}else{ health_anz.text = "0";}
			life_anz.text = ""+ _model.leben;
			punkte_anz.text = "" +_model.punkte;
		}
		
		public function getmodel():SpielfigurModel{
			return _model;
		}
		
		
		private function createTextField(x:Number, y:Number, textf:TextFormat):TextField {
            var result:TextField = new TextField();
            result.x = x;
            result.y = y;

            addChild(result);
			result.defaultTextFormat = textf;
			return result;
        }

		
}}