package componentes.clases
{
	import mx.collections.ArrayCollection;
	
	public class ArrayCollectionPropio extends ArrayCollection
	{
		[Bindable] public var cantidad:String;
		public function ArrayCollectionPropio(source:Array=null)
		{
			//TODO: implement function
			super(source);
		}
		
		override public function removeItemAt(index:int):Object
		{
			// TODO Auto Generated method stub
			var obj:Object = super.removeItemAt(index);
			cantidad = this.length + '';
			return obj;
		}
		
	}
}