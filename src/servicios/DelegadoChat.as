package servicios
{
	
	
	
	import clasesInternas.Mazo;
	
	import componentes.clases.ConexionSocket;
	import componentes.graficos.PopupMensaje;
	
	import eventos.CartasEvent;
	import eventos.MazoEvent;
	import eventos.MensajeEvent;
	import eventos.MovimientoEvent;
	import eventos.PartidaEvent;
	import eventos.SesionEvent;
	
	import flash.events.EventDispatcher;
	import flash.net.Responder;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.managers.PopUpManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	import spark.components.Application;
	
	public class DelegadoChat extends EventDispatcher
	{
		
		
		protected var dbAsyncToken:AsyncToken;
		
		private var cache:ArrayCollection;
		
		public static const MOCK_ASYNC_TIME:int = 100;
		
		private var lastId:int;
		
		private static var delegado:DelegadoChat;
		private var connNode:ConexionSocket = Modelo.getInstance().conexionChat;
		private var _callbackRecep:Function;
		
		
		public static function getInstance():DelegadoChat
		{
			if ( delegado== null ){
				delegado = new DelegadoChat();
				
			}			
			return delegado;
		}
		
		public function DelegadoChat()
		{
			if(delegado){
				throw new Error("Singleton... use getInstance()");
				
			} 
			
			delegado = this;
			init();
		}
		
		private function init():void
		{
			
			connNode.callbackRecep = this.callbackRecep;
			
		}
		
				
		public function chatPublico(data:MensajeEvent, callback:Function):void{
			connNode.envia('MP|' + Modelo.getInstance().sesion.user + '>' + data.msg + '|', callback);
		}
		
		
		
		public function get callbackRecep():Function
		{
			return _callbackRecep;
		}
		
		public function set callbackRecep(value:Function):void
		{
			_callbackRecep = value;
			this.connNode.callbackRecep = value;
		}
		
		
	}
}