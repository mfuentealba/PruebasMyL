package servicios
{
	
	
	
	import clasesInternas.Mazo;
	
	import componentes.clases.ConexionSocket;
	import componentes.graficos.PopupMensaje;
	
	import eventos.CartasEvent;
	import eventos.EfectosEvent;
	import eventos.MazoEvent;
	import eventos.MovimientoEvent;
	import eventos.PartidaEvent;
	import eventos.SesionEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Application;
	
	import vo.MazoVO;
	
	public class DelegadoNode extends EventDispatcher
	{
		
		
		protected var dbAsyncToken:AsyncToken;
		
		private var cache:ArrayCollection;
		
		public static const MOCK_ASYNC_TIME:int = 100;
		
		private var lastId:int;
		
		private static var delegado:DelegadoNode;
		private var connNode:ConexionSocket = Modelo.getInstance().conexion;
		private var _callbackRecep:Function;
		
		public static function getInstance():DelegadoNode
		{
			if ( delegado== null ){
				delegado = new DelegadoNode();
				
			}			
			return delegado;
		}
		
		public function DelegadoNode()
		{
			if(delegado){
				throw new Error("Singleton... use getInstance()");
				
			} 
			
			delegado = this;
			init();
		}
		
		private function init():void
		{
			
			/*****CREA EL DIRECTORIO QUE NECESITO PARA LA BASE****/
			connNode.callbackRecep = this.callbackRecep;
			
		}
		
		public function consultaSesion(data:SesionEvent, callback:Function):void{
			if(connNode._xmlSocket.connected){
				connNode.envia('LR|' + data.user + '|' + data.pass + '|', callback);	
			} else {
				connNode.ini();
				if(!connNode._xmlSocket.connected){
					Modelo.getInstance().conexionAct = connNode._xmlSocket.connected 
				} else {
					connNode.envia('LR|' + data.user + '|' + data.pass + '|', callback);
				}
			}
			
		}
		
		public function creaPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('CP|' + data.idJugador + '|' + data.opcion + '|' + data.tiempo + '|', callback);
		}
		
		public function generaPartida(data:PartidaEvent, callback:Function):void{
			connNode.envia('GP|' + data.partida.id + '|' + data.partida.idPlayer1 + '|' + data.partida.duracion + '|' + MazoVO(Modelo.getInstance().jugador.objMazos[Modelo.getInstance().jugador.mazoActivo]).oroInicialCarta, callback);
		}
		
		public function buscaPartidasTodas(data:PartidaEvent, callback:Function):void{
			connNode.envia('TP|' + data.idJugador + '|' + data.opcion + '|' + data.tiempo + '|', callback);
		}
		
		public function azar(data:PartidaEvent):void{
			connNode.envia('AZ|' + data.partida.azarYo + '|');
		}
		
		public function configTurno(data:PartidaEvent):void{
			var modelApp:Modelo = Modelo.getInstance();
			connNode.envia('CT|' + !data.partida.turno + '|' + modelApp.duelo.fase + '|');
		}
		
		public function finJuego(data:PartidaEvent):void{
			
			connNode.envia('FIN|');
		}
		
		public function ejecutaMovimiento(data:MovimientoEvent, callback:Function):void{
			connNode.envia('EM|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|', callback);			
		}
		
		public function cambiaFase(data:MovimientoEvent):void{
			if(data.movimientoVO.movimiento){
				connNode.envia('CF|Def|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
			} else {
				connNode.envia('CF|');	
			}
						
		}
		
		public function defensaDefinida(data:MovimientoEvent):void{
			connNode.envia('DD|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		public function guerraTalismanes(data:MovimientoEvent):void{
			connNode.envia('GT|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		public function destruyeCarta(data:MovimientoEvent):void{
			connNode.envia('DESTRUYE_CARTA|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		public function destierraCarta(data:MovimientoEvent):void{
			connNode.envia('DESTIERRA_CARTA|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		
		public function moverCartas(data:MovimientoEvent):void{
			connNode.envia('MOVER_CARTAS|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		public function efectoCarta(data:MovimientoEvent):void{
			connNode.envia('EFECTO_CARTA|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		public function enviaPartida(data:MovimientoEvent):void{
			connNode.envia('ENVIA_PARTIDA|' + data.movimientoVO.idPartida + '|' + data.movimientoVO.nroJugada + '|' + data.movimientoVO.fase + '|' + '   |' +  data.movimientoVO.movimiento + '|' +  data.movimientoVO.tiempo + '|' + Modelo.getInstance().sesion.id + '|' + data.movimientoVO.turno + '|');
		}
		
		
		public function obtenerMazoResponse(data:MazoEvent, callback:Function):void{
			connNode.envia('OM|' + data.mazo.id + '|', data.callback);
		}
		
		public function traeCartas(data:CartasEvent, callback:Function):void{
			connNode.envia('TC|' + '|', callback);
		}
		
		public function botaCartas(data:EfectosEvent):void{
			connNode.envia('BOTA_CARTAS|' + data.efectoVO.intensidad + '|');
		}
		
		/*public function moverCartas(data:EfectosEvent):void{
			connNode.envia('MOVER_CARTAS|' + data.efectoVO.envio + '|');
		}*/
		
		public function get callbackRecep():Function
		{
			return _callbackRecep;
		}
		
		public function set callbackRecep(value:Function):void
		{
			_callbackRecep = value;
			this.connNode.callbackRecep = value;
		}
		
		
	}
}