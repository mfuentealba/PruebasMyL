package eventos
{
	import flash.events.Event;
	
	public class SesionEvent extends Event
	{
		public static const INICIA_SESION:String = 'iniciaSesionEvent';
		public static const FIN_SESION:String = 'finSesionEvent';
		
		public var user:String;
		public var pass:String;
		public var callback:Function;
		public const clase:String = 'SesionEvent';
		
		public function SesionEvent(type:String, _user:String, _pass:String)
		{
			super(type);
			this.user = _user;
			this.pass = _pass;
		}
	}
}