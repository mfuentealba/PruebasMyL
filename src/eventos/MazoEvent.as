package eventos
{
	import flash.events.Event;
	
	import vo.MazoVO;

	public class MazoEvent extends Event
	{
		
		public const clase:String = 'MazoEvent';
		public static const OBTIENE_MAZO:String = 'obtieneMazoEvent';
		public var mazo:MazoVO;
		public var callback:Function;
		
		public function MazoEvent(type:String, _mazo:MazoVO)
		{
			super(type);
			this.mazo = _mazo;
		}
	}
}