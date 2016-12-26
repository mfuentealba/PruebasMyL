package eventos
{
	import flash.events.Event;
	
	public class CartasEvent extends Event
	{
		public static const TRAE_CARTAS:String = 'traeCartasEvent';
		
		public const clase:String = 'CartasEvent';
		
		public function CartasEvent(type:String)
		{
			super(type);
		}
	}
}