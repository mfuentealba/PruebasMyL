package eventos
{
	import flash.events.Event;
	
	import vo.EfectoVO;

	public class EfectosEvent extends Event
	{
		
		public const clase:String = 'EfectosEvent';
		public static const BOTA_CARTAS:String = 'botaCartasEvent';
		public static const MOVER_CARTAS:String = 'moverCartasEvent';
		public var efectoVO:EfectoVO;
		
		public function EfectosEvent(type:String, _efectoVO:EfectoVO = null)
		{
			super(type);
			efectoVO = _efectoVO;
		}
	}
}