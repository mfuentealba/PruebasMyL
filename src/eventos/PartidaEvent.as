package eventos
{
	import flash.events.Event;
	
	import vo.PartidaVO;
	
	public class PartidaEvent extends Event
	{
		public static const CREA_PARTIDA:String = 'creaPartidaEvent';
		public static const GENERA_PARTIDA:String = 'generaPartidaEvent';
		public static const BUSCA_PARTIDAS_TODAS:String = 'buscaPartidaTodasEvent';
		public static const AZAR:String = 'azarEvent';
		public static const CONFIGURA_TURNO:String = 'configTurnoEvent';
		public static const FIN_JUEGO:String = 'finJuegoEvent';
		
		public var opcion:String;
		public var idJugador:Number;
		public var tiempo:String;
		
		public const clase:String = 'PartidaEvent';
		public var partida:PartidaVO = new PartidaVO();
		
		public function PartidaEvent(type:String, _id:Number, _opt:String, _tiempo:String, _partida:PartidaVO = null)
		{
			super(type);
			this.idJugador = _id;
			this.opcion = _opt;
			this.tiempo = _tiempo;
			this.partida = _partida;
		}
	}
}