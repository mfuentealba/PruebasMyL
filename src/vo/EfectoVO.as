package vo
{
	
	import modelo.Modelo;
	
	import mx.collections.ArrayCollection;
	
	public class EfectoVO// extends ArrayCollection
	{
		private var modelApp:Modelo = Modelo.getInstance();
		public var intensidad:String;
		public var envio:String;
		
		public function EfectoVO()
		{
		}
	}
}