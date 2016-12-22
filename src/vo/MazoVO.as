package vo
{
	import componentes.graficos.Carta;
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	
	public class MazoVO// extends ArrayCollection
	{
		public var id:int;
		private var _arrCartas:ArrayCollection = new ArrayCollection();;
		public var oroInicial:int;
		public var oroInicialCarta:int;
		private var modelApp:Modelo = Modelo.getInstance();
		
		public function MazoVO()
		{
		}
		
		public function get arrCartas():ArrayCollection
		{
			return _arrCartas;
		}
		
		public function set arrCartas(dataProvider:ArrayCollection):void
		{
			/*for(var i:int = 0; i < dataProvider.length; i++){
				var carta:Carta = new Carta();
				carta.percentHeight = 100;
				carta.fnInfo = modelApp.fnInfo;
				carta.fnDeselecciona = modelApp.fnDeselecciona;
				carta.img = dataProvider.getItemAt(i)['cartaVO']['url'];
				carta.cartaVO = CartaVO(modelApp.arrCartas[dataProvider.getItemAt(i)]);
				_arrCartas.addItem(dataProvider.getItemAt(i));
			}*/
			_arrCartas = dataProvider;
		}
		
		public static function clone(_mazoVO:MazoVO):void{
			var mazoVO:MazoVO = new MazoVO();
			mazoVO.id = _mazoVO.id;
			mazoVO.oroInicial = _mazoVO.oroInicial;
			for(var i:int = 0; i < _mazoVO.arrCartas.length; i++){
				var carta:Carta = new Carta();
				carta.percentHeight = 100;
				carta.idUnico = _mazoVO.arrCartas.getItemAt(i)['idUnico'];
				carta.fnInfo = Modelo.getInstance().fnInfo;
				carta.fnDeselecciona = Modelo.getInstance().fnDeselecciona;
				carta.img = _mazoVO.arrCartas.getItemAt(i)['cartaVO']['url'];
				carta.cartaVO = CartaVO.clone(_mazoVO.arrCartas.getItemAt(i)['cartaVO']);
				carta.propietario = 'Propia';
				carta.envio = 'Oponente';
				carta.contenedor = 'zonaCastilloPropia';
				carta.accion = 'zonaCastilloPropia';
				carta.fnAccion('zonaCastilloPropia');
			}
			//modelapduelo.mazoAct.mazoVO
		}
		
	}
}