package clasesInternas
{
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	
	import vo.MazoVO;
	
	public class Mazo
	{
		public var arrMazoEnJuego:Array;
		public var mazoVO:MazoVO;
		[Bindable] private var modelApp:Modelo = Modelo.getInstance();
		
		public function Mazo()
		{
			
		}
		
		
		public function barajar():void{
			var aleatorio:int;
			/*arrCartas = new ArrayCollection();
			arrCartas.source = [{dat:1}, {dat:2}, {dat:3}, {dat:4}, {dat:5}];*/
			arrMazoEnJuego = [];
			trace('[');
			//var arrMula:Array = [29,12,34,26,27,5,33,15,33,4,21,10,30,16,33,23,9,17,20,10,23,24,16,3,4,15,2,4,7,0,12,5,8,13,5,11,6,3,1,4,1,5,3,3,3,0,0,0];
			var arrMula:Array = [12,46,17,22,12,20,2,15,24,29,5,13,9,30,25,29,8,23,15,17,22,1,3,7,12,7,12,0,14,16,5,14,15,0,10,2,6,2,8,4,5,1,4,4,0,0,1,0];//trae ataque de dragón
//			var arrMula:Array = [16,2,10,34,4,37,3,27,16,34,9,34,15,5,9,3,17,5,28,23,12,7,22,6,15,13,2,1,9,8,0,1,11,0,2,12,4,2,5,0,7,6,1,3,0,1,0,0]
			
			mazoVO.arrCartas = new ArrayCollection();
			for(i = 0; i < modelApp.partidaView.zonaCastilloPropia.numElements; i++){
				mazoVO.arrCartas.addItem(modelApp.partidaView.zonaCastilloPropia.getElementAt(i));	
			}
			var i:int = 0;
			while(mazoVO.arrCartas.length > 1){
				aleatorio = Math.floor(Math.random()*(mazoVO.arrCartas.length - 1));
				trace(aleatorio + ',');
				aleatorio = arrMula[i++];
				var obj:Object = mazoVO.arrCartas.getItemAt(mazoVO.arrCartas.length - 1);
				mazoVO.arrCartas.setItemAt(mazoVO.arrCartas.getItemAt(aleatorio), mazoVO.arrCartas.length - 1);
				mazoVO.arrCartas.setItemAt(obj, aleatorio);
				arrMazoEnJuego.push(mazoVO.arrCartas.source.pop());
				mazoVO.arrCartas.setItemAt(obj, aleatorio);
			}
			trace(']');
			arrMazoEnJuego.push(mazoVO.arrCartas.source.pop());
			mazoVO.arrCartas = new ArrayCollection(arrMazoEnJuego);
		}
		
		public function robo(cant:int = 8):ArrayCollection{
			//this.barajar();
			var arrMano:Array = [];
			for(var i:int = 0; i < cant && arrMazoEnJuego.length > 0; i++){
				arrMano.push(arrMazoEnJuego.pop());	
			}
			var a:ArrayCollection = new ArrayCollection(arrMano);
			return a;
		}
		
		public function fnOroInicial():void{
			mazoVO = modelApp.jugador.objMazos[modelApp.jugador.mazoActivo];
			/*for(var i:int = 0; i < modelApp.partidaView.zonaCastilloPropia.numElements; i++){
				if(Carta(modelApp.partidaView.zonaCastilloPropia.getElementAt(i)).idUnico == mazoVO.oroInicial){
					Carta(modelApp.partidaView.zonaCastilloPropia.getElementAt(i)).accion = 'zonaOroPropia';
					Carta(modelApp.partidaView.zonaCastilloPropia.getElementAt(i)).fnAccion('zonaOroPropia');
					break;
				}
			}*/
			
		}
	}
}