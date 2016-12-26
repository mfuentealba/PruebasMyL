package controlador
{
	
	import clasesInternas.Duelo;
	
	import componentes.graficos.Alert;
	import componentes.graficos.PopupMensaje;
	import componentes.graficos.Reloj;
	
	import components.CartaView;
	
	import eventos.CartasEvent;
	import eventos.EfectosEvent;
	import eventos.MazoEvent;
	import eventos.MensajeEvent;
	import eventos.MovimientoEvent;
	import eventos.PartidaEvent;
	import eventos.SesionEvent;
	
	import flash.data.SQLResult;
	import flash.events.DataEvent;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	import mx.managers.PopUpManager;
	import mx.rpc.Responder;
	import mx.rpc.events.ResultEvent;
	
	import servicios.DelegadoChat;
	import servicios.DelegadoNode;
	import servicios.DelegadoSQLite;
	
	import spark.components.Application;
	import spark.components.Button;
	
	import vo.MazoVO;
	import vo.MovimientoVO;
	import vo.PartidaVO;
	import vo.SesionVO;
	
	public class Controlador extends EventDispatcher
	{
		private static var controladorGeneral:Controlador;
		private var delegadoSQLITE:DelegadoSQLite;
		[Bindable] private var modelApp:Modelo = Modelo.getInstance();
		[Bindable] private var dlNode:DelegadoNode = DelegadoNode.getInstance();
		[Bindable] private var dlChat:DelegadoChat = DelegadoChat.getInstance();
		
		
		
		
		public static function getInstance():Controlador
		{
			if ( controladorGeneral == null ){
				controladorGeneral = new Controlador();
				
			}
			
			return controladorGeneral;
		}
		
		
		public function Controlador(target:IEventDispatcher=null)
		{
			if(controladorGeneral){
				throw new Error("Singleton... use getInstance()");
			} 
			controladorGeneral = this;
			inic();
		}
		
		
		
		public function inic():void{
			addEventListener(SesionEvent.INICIA_SESION, despachar);
			addEventListener(PartidaEvent.CREA_PARTIDA, despachar);
			addEventListener(PartidaEvent.GENERA_PARTIDA, despachar);
			addEventListener(PartidaEvent.BUSCA_PARTIDAS_TODAS, despachar);
			addEventListener(PartidaEvent.AZAR, despachar);
			addEventListener(PartidaEvent.CONFIGURA_TURNO, despachar);
			addEventListener(PartidaEvent.FIN_JUEGO, despachar);
			addEventListener(MovimientoEvent.EJECUTA_MOVIMIENTO, despachar);
			addEventListener(MovimientoEvent.CAMBIA_FASE, despachar);
			addEventListener(MovimientoEvent.DEFENSA_DEFINIDA, despachar);
			addEventListener(MovimientoEvent.GUERRA_TALISMANES, despachar);
			addEventListener(MovimientoEvent.DESTRUYE_CARTA, despachar);
			addEventListener(MovimientoEvent.DESTIERRA_CARTA, despachar);
			addEventListener(MazoEvent.OBTIENE_MAZO, despachar);
			addEventListener(CartasEvent.TRAE_CARTAS, despachar);
			addEventListener(MensajeEvent.MENSAJE_PUBLICO, despachar);
			addEventListener(EfectosEvent.BOTA_CARTAS, despachar);
			addEventListener(MovimientoEvent.MOVER_CARTA, despachar);
			addEventListener(MovimientoEvent.EFECTO_CARTA, despachar);
			addEventListener(MovimientoEvent.ENVIA_PARTIDA, despachar);
			
			dlNode.callbackRecep = callbackRecep;
			dlChat.callbackRecep = callbackChat;
		}
		
		
		private function despachar(event:*):void{
			switch(event.clase){
				case 'SesionEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case SesionEvent.INICIA_SESION:
							DelegadoNode.getInstance().consultaSesion(event, sesionResponse);
							break;
						//DelegadoSQLite.getInstance().fnDelegado(fn del controller que actualiza vista, fn callback del evento para alguna otra actualizacion mas visual)
					}
					break;
				case 'PartidaEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case PartidaEvent.CREA_PARTIDA:
							DelegadoNode.getInstance().creaPartida(event, creacionResponse);
							break;
						case PartidaEvent.GENERA_PARTIDA:
							DelegadoNode.getInstance().generaPartida(event, busquedaResponse);
							break;
						case PartidaEvent.BUSCA_PARTIDAS_TODAS:
							DelegadoNode.getInstance().buscaPartidasTodas(event, busquedaAllResponse);
							break;
						case PartidaEvent.AZAR:
							DelegadoNode.getInstance().azar(event);
							break;
						case PartidaEvent.CONFIGURA_TURNO:
							DelegadoNode.getInstance().configTurno(event);
							break;
						case PartidaEvent.FIN_JUEGO:
							DelegadoNode.getInstance().finJuego(event);
							break;
					}
					break;
				case 'MovimientoEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MovimientoEvent.EJECUTA_MOVIMIENTO:
							modelApp.partida.turno = false;
							modelApp.timeUsuario.timer.stop();
							modelApp.timeOponente.timer.start();
							DelegadoNode.getInstance().ejecutaMovimiento(event,ejecutaMovimientoResponse);
							break;	
						case MovimientoEvent.CAMBIA_FASE:
							DelegadoNode.getInstance().cambiaFase(event);
							break;	
						case MovimientoEvent.DEFENSA_DEFINIDA:
							DelegadoNode.getInstance().defensaDefinida(event);
							break;	
						case MovimientoEvent.GUERRA_TALISMANES:
							DelegadoNode.getInstance().guerraTalismanes(event);
							break;	
						case MovimientoEvent.DESTRUYE_CARTA:
							DelegadoNode.getInstance().destruyeCarta(event);
							break;
						case MovimientoEvent.DESTIERRA_CARTA:
							DelegadoNode.getInstance().destierraCarta(event);
							break;
						case MovimientoEvent.MOVER_CARTA:
							DelegadoNode.getInstance().moverCartas(event);
							break;
						case MovimientoEvent.ENVIA_PARTIDA:
							DelegadoNode.getInstance().enviaPartida(event);
							break;
						case MovimientoEvent.EFECTO_CARTA:
							DelegadoNode.getInstance().efectoCarta(event);
							break;
					}
					break;
				case 'MazoEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MazoEvent.OBTIENE_MAZO:
							DelegadoNode.getInstance().obtenerMazoResponse(event, obtenerMazoResponse);
							break;						
					}
					break;
				case 'CartasEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case CartasEvent.TRAE_CARTAS:
							DelegadoNode.getInstance().traeCartas(event, traeCartasResponse);
							break;						
					}
					break;
				case 'MensajeEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case MensajeEvent.MENSAJE_PUBLICO:
							DelegadoChat.getInstance().chatPublico(event, null);//, traeCartasResponse
							break;						
					}
					break;
				case 'EfectosEvent':
					//var sesionEvent:SesionEvent = event as SesionEvent;
					switch(event.type){
						case EfectosEvent.BOTA_CARTAS:
							DelegadoNode.getInstance().botaCartas(event);
							break;
						//DelegadoSQLite.getInstance().fnDelegado(fn del controller que actualiza vista, fn callback del evento para alguna otra actualizacion mas visual)
						case EfectosEvent.MOVER_CARTAS:
							DelegadoNode.getInstance().moverCartas(event);
							break;
					}
					break;
			}
		}
		
		
		
		/*******Respuestas base de datos********/
		
		
		private function getConfigResultHandler(event:SQLResult):void{
			/****Fn que se ejecuta en respuesta de actualización de la vista ej: en el delegadosqlite getConfigResultHandler.execute(-1, new flash.net.Responder(getEventosResultHandler, onDBError));*****/
		}
		
		/***************NODEJS**************************************/
		
		private function callbackRecep(result:DataEvent):void{
			var arrParam:Array = String(result.data).split('|');
			switch(arrParam[1]){
				case 'INI':
					if(arrParam[2] == 'OK'){
						modelApp.partida.idPlayer2 = arrParam[3];
						modelApp.partida.idOponente = arrParam[3];
						modelApp.partida.oroPlayer2 = arrParam[4];
						modelApp.flagInicioPartida = true;
					}
					break;
				case 'MOV':
					if(arrParam[2] == 'OK'){
						modelApp.partida.arrMovimientos.push(arrParam[3]);
						modelApp.partida.tiempoOponente = arrParam[4];
						modelApp.partida.turno = true;
						modelApp.partida.nuevaMovida++;	
					}
					
					break;
				case 'TP':
					var eve:PartidaEvent = new PartidaEvent(PartidaEvent.BUSCA_PARTIDAS_TODAS, modelApp.sesion.id, '', '');
					this.despachar(eve);
					break;
				
				case 'AZ':
					if(arrParam[2] == 'OK'){
						modelApp.partida.azarEl = arrParam[3];
						if(modelApp.partida.azarYo == -1){
							modelApp.azar = true;
							
						} else {
							
							if(modelApp.partida.azarEl > modelApp.partida.azarYo){
								trace('el jugador ' + modelApp.partida.azarEl);
								modelApp.partida.azarGanador = modelApp.partida.azarEl; 
							} else {
								if(modelApp.partida.azarEl == modelApp.partida.azarYo && modelApp.partida.idPlayer1 == modelApp.sesion.id){
									modelApp.partida.azarGanador = modelApp.sesion.id;
								} else {
									modelApp.partida.azarGanador = modelApp.partida.idPlayer1;
								}
							}
							modelApp.azarResultado = true;
						}
						
					}
					
					break;
				case 'CT':
					modelApp.go = true;
					if(arrParam[2] == 'OK'){
						modelApp.partida.relojIni = true;
						
						if(arrParam[3] == 'true'){
							if(modelApp.duelo.fase == Duelo.G_TALISMANES){
								modelApp.fnQuitaPopupGuerra.call(this);
								modelApp.duelo.fase++;
								modelApp.duelo.fase++;
								modelApp.duelo.fase++;
								
							}
							modelApp.pasaTalisman = 0;
							modelApp.partida.turno = true;
							modelApp.turnoOficial = true;
							modelApp.duelo.fase = 1;
							modelApp.timeUsuario.timer.start();
							modelApp.timeOponente.timer.stop();
						} else {
							modelApp.partida.turno = false;
							modelApp.turnoOficial = false;
							modelApp.timeOponente.timer.start();
							modelApp.timeUsuario.timer.stop();
						}
						
					}
					
					break;
				case 'EM':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						var movimientoNuevo:MovimientoVO = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[4];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[11];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.partida.nuevaMovida++;
						
					}
					break;
				case 'CF':
					if(arrParam[3] == 'Def'){
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[7];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[9];
						movimientoNuevo.nroJugada = arrParam[6];// 
						movimientoNuevo.tiempo = '' + arrParam[10];//
						movimientoNuevo.turno = '' + arrParam[12];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						var arr:Array = movimientoNuevo.movimiento.split(',');
						arr = String(arr[0]).split('@');
						
						
						if(arr[0] != ""){
							modelApp.timeOponente.timer.stop();
							modelApp.timeUsuario.timer.start();
							modelApp.partida.turno = true;	
						} else {
							modelApp.partida.turno = false;	
						}
						modelApp.switchCambioFase = true;
					}
					if(modelApp.duelo.fase == 0){
						modelApp.duelo.fase = 2;
					} else {
						modelApp.duelo.fase++;	
					}
					
					break;
				case 'DD':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.partida.nuevaMovida++;
						
					}
					modelApp.popAtaque++;
					modelApp.duelo.fase++;
					break;
				
				case 'GT':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
					//	modelApp.partida.nuevaMovida++;
						modelApp.fnPasaTalisman.call(this, movimientoNuevo);
						
					}
					modelApp.partida.turno = true;
					//modelApp.duelo.fase++;
					break;
				case 'FIN':
					if(arrParam[2] == 'OK'){
						modelApp.fnFinPartida.call(this, 1);
					}
					
					break;
				case 'BOTA_CARTAS':
					if(arrParam[2] == 'OK'){
						modelApp.fnBotaCartas.call(this, arrParam[3]);
					}
					
					break;
				case 'DESTRUYE_CARTA':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.efecto++;
						
					}
					break;
				case 'DESTIERRA_CARTA':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.efecto++;
						
					}
					break;
				case 'MOVER_CARTAS':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.efecto++;
						
					}
					break;
				
				
				
				case 'EFECTO_CARTA':
					if(arrParam[2] == 'OK'){
						
						modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						modelApp.efecto++;
						
					}
					break;
				case 'ENVIA_PARTIDA':
					if(arrParam[2] == 'OK'){
						
						/*modelApp.partida.tiempoOponente = arrParam[9];
						//modelApp.partida.turno = true;
						
						modelApp.timeOponente.timer.stop();
						modelApp.timeUsuario.timer.start();
						
						movimientoNuevo = new MovimientoVO();
						movimientoNuevo.fase = '' + arrParam[6];
						movimientoNuevo.idOponente = '' + modelApp.partida.idOponente;
						movimientoNuevo.idPartida = '' + modelApp.partida.id;
						movimientoNuevo.movimiento = '' + arrParam[8];
						movimientoNuevo.nroJugada = arrParam[5];// 
						movimientoNuevo.tiempo = '' + arrParam[9];//
						movimientoNuevo.turno = '' + arrParam[10];//
						
						var n:int = int(movimientoNuevo.movimiento.split(',')[0]);
						var m:int = int(movimientoNuevo.movimiento.split(',')[1]);
						modelApp.partida.arrMovimientos.push(movimientoNuevo);
						
						for(i = 0; i < 50; i++){
							
							carta = new Carta();
							carta.propietario = 'Oponente';
							carta.envio = 'Propia';
							carta.percentHeight = 100;
							carta.fnInfo = modelApp.fnInfo;
							carta.fnDeselecciona = modelApp.fnDeselecciona;
							carta.cartaVO = CartaVO.clone(modelApp.arrCartas[0]);
							carta.propietario = 'Oponente';
							carta.envio = 'Propia';
							carta.fnAccion('zonaCastilloOponente');
							
						}
						
						
						for(var i:int = 0; i < n; i++){
							
							//var carta:Carta = modelApp.duelo.zonaCastilloOponente.getItemAt(48 - i) as Carta;							
							var carta:Carta = modelApp.partidaView.zonaCastilloOponente.getElementAt(48 - i) as Carta;
							carta.fnAccion('zonaManoOponente');
							
						}
						
						carta = modelApp.partidaView.zonaCastilloOponente.getElementAt(modelApp.partidaView.zonaCastilloOponente.numElements - 1) as Carta;
						carta.fnAccion('zonaOroOponente');
						var arrCarta:Array;
						
						if(modelApp.partida.idPlayer1 == modelApp.sesion.id){
							modelApp.indexCartaSearch = modelApp.partida.oroPlayer2;	
						} else {
							modelApp.indexCartaSearch = modelApp.partida.oroPlayer1;
						}
						
						
						
						arrCarta = modelApp.arrCartas.source.filter(modelApp.fnBuscaCarta2);
						carta.cartaVO = arrCarta[0];
						carta.img = carta.cartaVO.url;
						*/
						
					}
					break;
			}
		}
		
		
		private function callbackChat(result:DataEvent):void{
			var arrParam:Array = String(result.data).split('|');
			switch(arrParam[1]){
				case 'MP':
					
					if(arrParam[2] == 'OK'){
						modelApp.chatPublico = arrParam[3] + '\n' + modelApp.chatPublico;
						
					}
					break;
				
			}
		}
		
		
		
		
		private function sesionResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			modelApp.sesion = new SesionVO();
			modelApp.sesion.id = arrSesion[0];
			modelApp.sesion.user = arrSesion[1];
			modelApp.jugador.sesion = modelApp.sesion;
			modelApp.jugador.id = arrSesion[0];
			modelApp.jugador.nombreUsuario = arrSesion[1];
			modelApp.jugador.mazoActivo = arrSesion[2];
			modelApp.jugador.ranking = arrSesion[3];
			modelApp.jugador.puntos = arrSesion[4];
			var arr:Array = String(arrSesion[5]).split(';');
			modelApp.jugador.objMazos['cantidad'] = 0;
			
			if(arr.length > 0){
				for(var i:int = 0; i < arr.length - 1; i++){
					var mazo:MazoVO = new MazoVO();
					mazo.id = String(arr[i]).split(',')[0];
					mazo.oroInicial = String(arr[i]).split(',')[1]; 
					mazo.oroInicialCarta = String(arr[i]).split(',')[2]; 
					modelApp.jugador.objMazos[String(arr[i]).split(',')[0]] = mazo;
					modelApp.jugador.objMazos['cantidad']++;
				}	
			}
			
		}
		
		private function creacionResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			
			if(arrSesion[0] == 'OK'){
				modelApp.partida = new PartidaVO();
				modelApp.partida.id = arrSesion[1];	
				modelApp.partida.idPlayer1 = modelApp.sesion.id;
				modelApp.partida.duracion = arrSesion[2];
				modelApp.partida.colorUsuario = arrSesion[3];
				
			}
			
			
		}
		
		
		private function busquedaResponse(aEvent : DataEvent):void{
			var arrSesion:Array = String(aEvent.data).split('|');
			
			if(arrSesion[0] == 'OK'){
				/*modelApp.partida = new PartidaVO();
				modelApp.partida.idPlayer1 = arrSesion[1]
				modelApp.partida.id = arrSesion[2];	
				modelApp.partida.duracion = arrSesion[3];	
				modelApp.partida.idOponente = '' + modelApp.partida.idPlayer1;*/
				modelApp.flagInicioPartida = true;
				
				modelApp.partida.turno = modelApp.partida.colorUsuario == 'B' ? true : false;
			}
			
			
		}
		
		private function busquedaAllResponse(aEvent : DataEvent):void{
			var arrPartidas:Array = String(aEvent.data).split('|');
			modelApp.arrPartidas.source = null;
			if(arrPartidas[0] == 'OK'){
				
				for(var i:int = 1; i < arrPartidas.length - 1; i++){
					var arrPart:Array = String(arrPartidas[i]).split(';');
					var part:PartidaVO = new PartidaVO();
					part.id = arrPart[0];
					part.idPlayer1 = arrPart[1];
					part.Player1 = arrPart[2];
					part.duracion = arrPart[3];
					part.apuesta = arrPart[4];
					part.mazoPlayer1 = arrPart[5];
					part.oroPlayer1 = arrPart[6];
					modelApp.arrPartidas.addItem(part);
				}
				
				
				
				
			}
			
			for(var str:String in modelApp.jugador.objMazos){
				if(str != 'cantidad' && MazoVO(modelApp.jugador.objMazos[str]).arrCartas.length == 0){
					var mazoEvent:MazoEvent = new MazoEvent(MazoEvent.OBTIENE_MAZO, modelApp.jugador.objMazos[str]);
					mazoEvent.callback = obtenerMazoResponse;
					Controlador.getInstance().dispatchEvent(mazoEvent);	
				}
			}
		}
		
		private function ejecutaMovimientoResponse(aEvent : DataEvent):void{
			var arrConfirmacion:Array = String(aEvent.data).split('|');
			
			if(arrConfirmacion[0] == 'OK'){
				modelApp.partida.turno = false;
			}
		}
		
		private function obtenerMazoResponse(aEvent : DataEvent):void{
			var arrConfirmacion:Array = String(aEvent.data).split('|');
			
			if(arrConfirmacion[0] == 'OK'){
				var dataProvider:ArrayCollection = new ArrayCollection(String(arrConfirmacion[2]).split(';'));
				for(var i:int = 0; i < dataProvider.length - 1; i++){
					if(i == 8){
						i = 8;
					}
					var carta:CartaView = new CartaView();
					carta.propietario = 'Propia';
					carta.envio = 'Oponente';
					carta.percentHeight = 100;
					carta.fnInfo = modelApp.fnInfo;
					carta.fnDeselecciona = modelApp.fnDeselecciona;
					carta.img = modelApp.arrCartas[dataProvider.getItemAt(i).split(',')[1]]['url'];
					
					var idcarta:int = String(dataProvider.getItemAt(i)).split(',')[1];
					
					carta.idUnico = String(dataProvider.getItemAt(i)).split(',')[0];
					//carta.cartaVO = CartaVO(modelApp.arrCartas[dataProvider.getItemAt(i)]);
					
					MazoVO(modelApp.jugador.objMazos[arrConfirmacion[1]]).arrCartas.addItem(carta);
				}
				
				/*MazoVO(modelApp.jugador.objMazos[arrConfirmacion[1]]).arrCartas = 
				MazoVO(modelApp.jugador.objMazos[arrConfirmacion[1]]).arrCartas.source.pop();*/
			}
			
		}
		
		private function traeCartasResponse(aEvent : DataEvent):void{
			var arrConfirmacion:Array = String(aEvent.data).split('|');
			if(arrConfirmacion[0] == 'OK'){
				var arrCartas:Array = String(arrConfirmacion[1]).split('@@@@');
				arrCartas.pop();
				modelApp.arrCartas.addItem(new CartaView());
				var arrCartasAjustada:Array = [];
				var objCarta:Object = {};
				for(var i:int = 0; i < arrCartas.length; i++){
					var arr:Array = String(arrCartas[i]).split('---');
					
					if(arr[0] == '6'){
						arr[0] = '6';
					}
					if(!objCarta['c' + arr[0]]){
						var cartaVO:CartaView = new CartaView();
						if(arr[13] == 'enJuego'){
							cartaVO.btnEfecto = true;
							
						}
						cartaVO.id = arr[0];
						cartaVO.nombre = arr[1];
						if(arr[1] == 'Ataque de Dragón'){
							arr[1] = 'Ataque de Dragón';
						}
						cartaVO.descripcion = arr[2];
						cartaVO.tipo = arr[3];
						cartaVO.raza = arr[4];
						cartaVO.frecuencia = arr[5];
						cartaVO.cantidad = arr[6];cartaVO.cantidadMazo = arr[6];						
						cartaVO.estado = arr[7];
						cartaVO.url = arr[8];	
						cartaVO.fuerzaTotal = int(arr[9]);
						cartaVO.fuerzaBase = int(arr[9]);
						cartaVO.fuerzaBono = 0;
						cartaVO.coste = arr[10];
						cartaVO.habilidades = arr[11];
						cartaVO.arrHabilidades = [];
						cartaVO.fnDispIngresoJuego = modelApp.dispIngresoJuego;
						if(arr[12] != "null"){
							var obj:Object = {habilidad: arr[12]};
							obj['habId'] = arr[23];
							obj['arrDisparadores'] = {};
							obj['arrDisparadores'][arr[13]] = arr[13];
							cartaVO.arrHabilidades.push(obj);
							
							objCarta['c' + arr[0]] = {carta: cartaVO};
							objCarta['c' + arr[0]][arr[23]] = {};
							objCarta['c' + arr[0]][arr[23]][arr[13]] = arr[13];
							obj['TipoBonificacion']  = arr[14];
							obj['TipoObjetivo']  = arr[15];
							obj['zonaObjetivo'] = arr[16];
							obj['filtro'] = arr[17];
							obj['Selector'] = arr[18];
							obj['ejecucion']  = arr[19];
							obj['CosteAdicional']  = arr[20];
							obj['hasta'] = arr[21];
							obj['intensidad'] = arr[22];
							obj['descripcion'] = arr[24];
						}
						modelApp.arrCartas.addItem(cartaVO);
						
					} else {
						if(arr[12] != "null"){
							if(!objCarta['c' + arr[0]][arr[23]]){
								
								obj = {habilidad: arr[12]};
								obj['habId'] = arr[23];
								obj['arrDisparadores'] = {};
								obj['arrDisparadores'][arr[13]] = arr[13];							
								CartaView(objCarta['c' + arr[0]]['carta']).arrHabilidades.push(obj);
								objCarta['c' + arr[0]][arr[23]] = {};
								objCarta['c' + arr[0]][arr[23]][arr[13]] = arr[13];
								obj['TipoBonificacion']  = arr[14];
								obj['TipoObjetivo']  = arr[15];
								obj['zonaObjetivo'] = arr[16];
								obj['filtro'] = arr[17];
								obj['Selector'] = arr[18];
								obj['ejecucion']  = arr[19];
								obj['CosteAdicional']  = arr[20];
								obj['hasta'] = arr[21];
								obj['intensidad'] = arr[22];
								obj['descripcion'] = arr[24];
							} else {
								objCarta['c' + arr[0]][arr[23]][arr[13]] = arr[13];
								CartaView(objCarta['c' + arr[0]]['carta']).arrHabilidades['arrDisparadores'][arr[13]] = arr[13];
							}	
						}
						
						
					}
					
					
				}
				
				/*for(var i:int = 0; i < arrCartas.length; i++){
				var arr:Array = String(arrCartas[i]).split(';');
				var cartaVO:CartaVO = new CartaVO();
				cartaVO.id = arr[0];
				cartaVO.nombre = arr[1];
				cartaVO.descripcion = arr[2];
				cartaVO.cantidad = arr[3];
				cartaVO.cantidadMazo = arr[4];
				cartaVO.url = arr[5];
				cartaVO.tipo = arr[6];
				cartaVO.raza = arr[7];
				cartaVO.fuerza = int(arr[8]);
				cartaVO.coste = int(arr[9]);
				cartaVO.habilidades = arr[10];
				modelApp.arrCartas.addItem(cartaVO);
				}*/
			}
			
			var evento:PartidaEvent = new PartidaEvent(PartidaEvent.BUSCA_PARTIDAS_TODAS, modelApp.sesion.id, null, null);
			Controlador.getInstance().dispatchEvent(evento);
			
			
			
			
		}
		
	}
}