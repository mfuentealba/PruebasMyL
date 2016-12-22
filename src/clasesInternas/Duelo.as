package clasesInternas
{
	import componentes.clases.ArrayCollectionPropio;
	
	import mx.collections.ArrayCollection;
	
	public class Duelo
	{
		[Bindable] public var reservaOros:int = 1;
		/*[Bindable] public var zonaManoPropia:ArrayCollection;
		[Bindable] public var zonaManoOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaCastilloPropia:ArrayCollectionPropio = new ArrayCollectionPropio();
		[Bindable] public var zonaCastilloOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaCementerioPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaCementerioOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaDestierroPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaDestierroOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaDefensaPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaDefensaOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaAtaquePropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaAtaqueOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaApoyoPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaApoyoOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaOroPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaOroOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaOroPagadoPropia:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaOroPagadoOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaDefendiendo:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaNeutralOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaAliadosOponente:ArrayCollection = new ArrayCollection();
		[Bindable] public var zonaAliadosPropia:ArrayCollection = new ArrayCollection();*/
		public var mazoAct:Mazo = new Mazo();
		public var mazoActOponente:Mazo = new Mazo();
		[Bindable] public var fase:int = 0;
		public var turnoInicial:Boolean = true;
		public static const AGRUPACION:int = 1;
		public static const VIGILIA:int = 2;
		public static const ATAQUE:int = 3;
		public static const DEFENSA:int = 4;
		public static const G_TALISMANES:int = 5;
		public static const ASIGNACION_DAMAGE:int = 6;
		public static const FINAL:int = 7;
		public static const FIN_TURNO:int = 8;
		public var arrFases:Array = [1, 2, 3,  4, 5, 6, 7, 8];
		
		public function Duelo()
		{
			mazoAct = new Mazo();
		}
	}
}