package servicios
{
	
	
	import flash.data.SQLConnection;
	import flash.data.SQLMode;
	import flash.data.SQLResult;
	import flash.data.SQLStatement;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.SQLErrorEvent;
	import flash.events.SQLEvent;
	import flash.filesystem.File;
	import flash.net.Responder;
	
	import mx.collections.ArrayCollection;
	import mx.managers.CursorManager;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	public class DelegadoSQLite extends EventDispatcher
	{
		protected var dbFile:File;
		
		protected var sqlConnection:SQLConnection;
		
		protected var dbAsyncToken:AsyncToken;
		
		private var cache:ArrayCollection;
		
		public static const MOCK_ASYNC_TIME:int = 100;
		
		private var lastId:int;
		
		private static var delegado:DelegadoSQLite;
		
		public static function getInstance():DelegadoSQLite
		{
			if ( delegado== null ){
				delegado = new DelegadoSQLite();
				
			}			
			return delegado;
		}
		
		public function DelegadoSQLite()
		{
			if(delegado){
				throw new Error("Singleton... use getInstance()");
				
			} 
			initDB();
			delegado = this;
		}
		
		private function initDB():void
		{
			
			/*****CREA EL DIRECTORIO QUE NECESITO PARA LA BASE****/
			//var appUserDir:File = new File(File.applicationStorageDirectory.nativePath + "/CRUDTablet/");
			var appUserDir:File = new File(File.applicationStorageDirectory.nativePath + "/Plazos/");
			if (!appUserDir.exists)
			{
				appUserDir.addEventListener(Event.COMPLETE, onDataDirectoryCreated);
				appUserDir.createDirectory();
				
				
			}
			dbFile = new File(File.applicationStorageDirectory.nativePath + "/Plazos/plazos.db");
			if(dbFile.exists){
				openDBAsync();
			}else{
				onDataDirectoryCreated(null);
			}
			
		}
		
		
		private function creacionDB():void
		{
			if (sqlConnection)
			{
				sqlConnection.close();
			}
			sqlConnection = new SQLConnection();
			sqlConnection.open(dbFile, "create");			
			
			/*************Generacion de la base de datos sqlite**************/
			/*
			var stmt:SQLStatement = new SQLStatement();
			stmt.sqlConnection = sqlConnection;
			stmt.text = "CREATE TABLE IF NOT EXISTS tbl_fechas (id INTEGER PRIMARY KEY AUTOINCREMENT, fecha DATE, sabado BOOLEAN, feriado BOOLEAN)";
			stmt.execute();*/
			
			
		}	
		
		
		protected function onDataDirectoryCreated(event:Event):void
		{
			var testPath:String = File.applicationDirectory.url;
			var assetsDir:File = new File(testPath);
			
			//var origDBFile:File = new File("d:\\plazo.db");
			var origDBFile:File = new File(File.applicationDirectory.url + "assets/data/plazos.db");
			//dbFile = new File(File.applicationStorageDirectory.nativePath + "/Plazos/plazos.db");
			
			
			origDBFile.copyTo(dbFile, true);
			//openDBAsync();
			creacionDB();//  primera apertura crea tablas y data 
			
		}
		
		protected function openDBAsync():void
		{
			sqlConnection = new SQLConnection();
			sqlConnection.openAsync(dbFile, SQLMode.UPDATE, null);
			
		}
		
		private function onDBError(event:*):void
		{
			trace("db error just happened");
			
		}	
		
		public function consultaEventos(getEventosResultHandler:Function):void{
			var getExpensesSQLStatement:SQLStatement = new SQLStatement();
			getExpensesSQLStatement.sqlConnection = sqlConnection;
			//getExpensesSQLStatement.text = "SELECT id, nombre, fecha , descripcion, evento, estado, telefono, e_mail, estado FROM tbl_registro_evento";
			getExpensesSQLStatement.execute(-1, new flash.net.Responder(getEventosResultHandler, onDBError));
		}
		
		public function newEvento(newEventoResultHandler:Function, event:*):void{
			var stmt:SQLStatement = new SQLStatement();
			stmt.addEventListener(SQLEvent.RESULT, event.callback);
			//stmt.text = "INSERT INTO tbl_registro_evento values(null, '" + event.evento.nombre + "', julianday('" + event.evento.fecha + "'), '" + event.evento.descripcion + "', '" + event.evento.evento + "', 'Pendiente', '" + event.evento.telefono + "', '" + event.evento.e_mail + "');"
			stmt.sqlConnection = sqlConnection;
			stmt.execute();
		}	
	}
}