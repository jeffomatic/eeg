package ff.co
{
	public class List
	{
		public function List()
		{
		}
		
		public function Add( component : Base ) : void
		{
			m_components.push( component );
			component.OnAdd( this );
		}
		
		public function Remove( component : Base ) : void
		{
			// Create new list, excluding the component
			var list : Vector.<Base> = new Vector.<Base>;
			
			for each ( var c : Base in m_components )
			{
				if ( component == c )
				{
					component.OnRemove();
				}
				else
				{
					list.push( c );
				}
			}
			
			m_components = list;
		}
		
		public function Get( classType : Class ) : Base
		{
			for each ( var c : Base in m_components )
			{
				if ( c is classType )
				{
					return c;
				}
			}
			
			return null;
		}
		
		public function GetAll( classType : Class ) : Vector.<Base>
		{
			var list : Vector.<Base> = new Vector.<Base>;
			
			for each ( var c : Base in m_components )
			{
				if ( c is classType )
				{
					list.push( c );
				}
			}
			
			return list;
		}
		
		public function Update( timeDelta : Number ) : void
		{
			for each ( var c : Base in m_components )
			{
				c.Update( timeDelta );
			}
		}
		
		private var m_components : Vector.<Base> = new Vector.<Base>;
	}
}