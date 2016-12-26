package vo
{
	
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
		
		
		
	}
}