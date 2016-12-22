package vo
{
	[Bindable]
	public class PartidaVO
	{
		public var id:Number;
		public var idPlayer1:Number;
		public var idPlayer2:Number;
		
		/*******************************************/
		public var Player1:String;
		public var Player2:String;
		public var rankingPlayer1:Number;
		public var rankingPlayer2:Number;
		public var apuesta:Number;
		public var mazoPlayer1:Number;
		public var mazoPlayer2:Number;
		public var oroPlayer1:Number;
		public var oroPlayer2:Number;
		
		public var turnoJuego:Number;
		
		/*******************************************/
		
		
		public var estado:String;
		public var resultado:String;
		public var detalle_fin:String;
		public var p1_conn:Boolean;
		public var p2_conn:Boolean;
		public var duracion:String;
		public var colorUsuario:String;
		public var turno:Boolean;
		public var arrMovimientos:Array = [];
		public var nuevaMovida:int;
		public var nroJugada:int = 1;
		public var nroTurno:int = 1;
		public var idOponente:String;
		public var tiempoOponente:String;		
		public var arrPiezaJaque:Array = [];
		public var azarYo:int = -1;
		public var azarEl:int = -1;
		public var azarGanador:int;
		public var relojIni:Boolean = false;
		public var idGanador:int;
		
		public function PartidaVO()
		{
		}
	}
}