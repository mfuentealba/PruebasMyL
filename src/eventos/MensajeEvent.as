package eventos
{
	import flash.events.Event;
	
	import vo.PartidaVO;
	
	public class MensajeEvent extends Event
	{
		public static const MENSAJE_PUBLICO:String = 'mensajePublicoEvent';
		public static const MENSAJE_PRIVADO:String = 'mensajePrivadoEvent';
		
		
		
		public const clase:String = 'MensajeEvent';
		public var msg:String = '';
		
		public function MensajeEvent(type:String, _msg:String)
		{
			super(type);
			this.msg = _msg;
		}
	}
}