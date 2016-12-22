package vo
{
	import componentes.graficos.Carta;
	
	[Bindable] public dynamic class CartaVO
	{
		public var id:int;
		public var nombre:String;
		public var descripcion:String;
		public var habilidades:String
		public var tipo:String;
		public var raza:String;
		public var frecuencia:String;
		public var cantidad:int;
		public var cantidadMazo:int;
		public var estado:String;
		public var url:String;
		public var fuerzaBase:int;
		public var fuerzaTotal:int;
		public var fuerzaBono:int;
		public var imbloqueable:Boolean;
		public var indestructible:Boolean;
		public var coste:int;
		public var arrHabilidades:Array = [];
		public var btnEfecto:Boolean;
		
		public var fnDispIngresoJuego:Function;
		public var fnEfecto:Function;
		
		
		public static const ORO:int = 1;
		public static const ALIADO:int = 2;
		public static const ARMA:int = 3;
		public static const TOTEM:int = 4;
		public static const TALISMAN:int = 5;
		//public static const TALISMAN:int = 6;
		
		
		public function CartaVO()
		{
		}
		
		public static function clone(_cartaVO:CartaVO):CartaVO{
			var cartaVO:CartaVO = new CartaVO();
			cartaVO.id = _cartaVO['id'];
			cartaVO.nombre = _cartaVO['nombre'];
			cartaVO.descripcion = _cartaVO['descripcion'];
			cartaVO.tipo = _cartaVO['tipo'];
			cartaVO.raza = _cartaVO['raza'];
			cartaVO.frecuencia = _cartaVO['frecuencia'];
			cartaVO.cantidad = _cartaVO['cantidad'];
			cartaVO.cantidadMazo = _cartaVO['cantidadMazo'];
			cartaVO.estado = _cartaVO['estado'];
			cartaVO.url = _cartaVO['url'];	
			cartaVO.fuerzaTotal = _cartaVO['fuerzaTotal'];
			cartaVO.fuerzaBase = _cartaVO['fuerzaBase'];
			cartaVO.fuerzaBono = _cartaVO['fuerzaBono'];
			cartaVO.coste = _cartaVO['coste'];
			cartaVO.habilidades = _cartaVO['habilidades'];
			cartaVO.fnDispIngresoJuego = _cartaVO['fnDispIngresoJuego'];
			cartaVO.btnEfecto = _cartaVO['btnEfecto'];
			
			
			cartaVO.arrHabilidades = new Array();
			for(var i:int = 0; i < _cartaVO.arrHabilidades.length; i++){
				var obj:Object = {};
				for(var str:String in _cartaVO.arrHabilidades[i]){					
					if(str == 'arrDisparadores'){
						obj[str] = [];
						for(var strDisp:String in _cartaVO.arrHabilidades[i][str]){
							obj[str][strDisp] = _cartaVO.arrHabilidades[i][str][strDisp];
						}
						obj[str] = _cartaVO.arrHabilidades[i][str];
					} else {
						obj[str] = _cartaVO.arrHabilidades[i][str];
					}
				}
				cartaVO.arrHabilidades.push(obj);
			}
			//cartaVO.fnDeselecciona = _cartaVO['fnDeselecciona'];
			return cartaVO;
		}
		
	}
}