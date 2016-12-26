package eventos
{
	import flash.events.Event;
	
	import vo.MovimientoVO;
	
	public class MovimientoEvent extends Event
	{
		public static const EJECUTA_MOVIMIENTO:String = 'ejecutaMovimientoEvent';
		public static const CAMBIA_FASE:String = 'cambiaFaseEvent';
		public static const DEFENSA_DEFINIDA:String = 'defensaDefinidaEvent';
		public static const GUERRA_TALISMANES:String = 'guerraTalismanesEvent';
		public static const DESTRUYE_CARTA:String = 'destruyeCartaEvent';
		public static const DESTIERRA_CARTA:String = 'destierraCartaEvent';
		public static const MOVER_CARTA:String = 'moverCartaEvent';
		public static const ENVIA_PARTIDA:String = 'enviaPartidaEvent';
		public static const EFECTO_CARTA:String = 'efectoCartaEvent';
		
		
		public const clase:String = 'MovimientoEvent';
		public var movimientoVO:MovimientoVO = new MovimientoVO();
		public var callback:Function;
		public var turno:String;
		
		public function MovimientoEvent(type:String, _movimiento:MovimientoVO, _turno:String = '')
		{
			super(type);
			if(_movimiento){
				this.movimientoVO.movimiento = _movimiento.movimiento;
				this.movimientoVO.idPartida = _movimiento.idPartida;
				this.movimientoVO.tiempo = _movimiento.tiempo;
				this.movimientoVO.idOponente = _movimiento.idOponente;
				this.movimientoVO.nroJugada = _movimiento.nroJugada;
				this.movimientoVO.fase = _movimiento.fase;
				this.movimientoVO.turno = _movimiento.turno;	
			} else {
				this.turno = _turno;
			}
			
		}
	}
}