package eventos
{
	import flash.events.Event;
	
	public class SeleccionEvent extends Event
	{
		public static const SELECT:String = "select"

		public function SeleccionEvent()
		{
			super(SELECT);
		}
	}
}