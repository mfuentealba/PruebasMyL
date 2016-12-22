package modelo
{
	import clasesInternas.Duelo;
	
	import componentes.clases.ConexionSocket;
	import componentes.graficos.BloqueoEspera;
	import componentes.graficos.Reloj;
	
	import flash.utils.Timer;
	
	import mx.collections.ArrayCollection;
	
	import spark.components.Application;
	
	import views.PartidaView;
	
	import vo.JugadorVO;
	import vo.MovimientoVO;
	import vo.PartidaVO;
	import vo.SesionVO;
	
	
	[Bindable]
	public class Modelo
	{
		private static var modelLocator:Modelo;
		public var block:BloqueoEspera = new BloqueoEspera();
		public var bloqueo:Boolean = false;
		public var conexionAct:Boolean;
		public var timer:Timer = new Timer(10000, 0); 
		public var activeTimer:Boolean = false;
		//public var jugador:Jugador = new Jugador();
		public var sesion:SesionVO;
		public var partida:PartidaVO;
		public var fnInicioPartida:Function;
		public var arrTiempo:ArrayCollection = new ArrayCollection([{id: 1, duracion: '5:00'}, {id: 2, duracion: '10:00'}, {id: 3, duracion: '3:00'}, {id: 4, duracion: '20:00'}]);
		public var flagInicioPartida:Boolean = false;
		public var arrPartidas:ArrayCollection = new ArrayCollection();
		public var azar:Boolean = true;
		public var azarResultado:Boolean;
		public var jugador:JugadorVO = new JugadorVO();
		public var jugadorOponente:JugadorVO = new JugadorVO();
		public var arrCartas:ArrayCollection = new ArrayCollection();
		public var fnInfo:Function;
		public var fnDeselecciona:Function;
		public var fnBuscaCarta2:Function;
		public var fnGeneraGCartas:Function;
		public var fnAddArma:Function;
		public var timeOponente:Reloj;
		public var timeUsuario:Reloj;
		public var duelo:Duelo;
		public var switchCambioFase:Boolean;
		public var popAtaque:int = 0;
		public var fnPasaTalisman:Function;
		public var fnQuitaPopupGuerra:Function;
		public var fnFinPartida:Function;
		public var fnBotaCartas:Function;
		public var dispIngresoJuego:Function;
		public var indexCartaSearch:int;
		public var pasaTalisman:int;
		public var DDirecto:int;
		public var fnBuscaCartaConArma:Function;
		public var strCartaSearch:String;
		public var turnoOficial:Boolean;
		public var partidaView:PartidaView;
		public var go:Boolean = false;
		public var efecto:int;
		
		//public var movimientoEntranteVO:MovimientoVO = new MovimientoVO();
		
		
		public var conexion:ConexionSocket = new ConexionSocket();
		public var conexionChat:ConexionSocket = new ConexionSocket();
		public var chatPublico:String = '';
		
		[Embed(source="assets/listGastos/ok.png")]
		public var cancelados:Class;
		
		[Embed(source="assets/listGastos/pendiente.png")]
		public var pendiente:Class;
		
		
		[Embed(source="assets/userNull.png")]
		public var userNull:Class;
		[Embed(source="assets/coins.png")]
		public var coins:Class;
		[Embed(source="assets/Paz.png")]
		public var paz:Class;
		public var xcord:Number;
		public var ycord:Number;
		/*		arrTipoIngreso.addItem({id: 1, nombre: 'Efectivo'}); 
		arrTipoIngreso.addItem({id: 2, nombre: 'Cheque al Día'}); 
		arrTipoIngreso.addItem({id: 3, nombre: 'Cheque a Fecha'}); 
		arrTipoIngreso.addItem({id: 4, nombre: 'Transferencia'});*/
		
		public var str:String = '<';
		
		
		public static function getInstance():Modelo
		{
			if ( modelLocator == null ){
				modelLocator = new Modelo();
			}
			
			return modelLocator;
		}
		
		public function Modelo()
		{
			if(modelLocator){
				throw new Error("Singleton... use getInstance()");
			} 
			modelLocator = this;
		}
		
		
	}
}