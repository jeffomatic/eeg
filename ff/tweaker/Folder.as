package ff.tweaker
{
	public class Folder extends Item
	{
		public function Folder()
		{
			m_open = false;
		}
		
		public function IsOpen():Boolean { return m_open; }
		
		override protected function OnClick():void
		{
			m_open = ! m_open;
			
			if ( m_open )
			{
				Open();
			}
			else
			{
				Close();
			}
		}
		
		override protected function OnChildBackClick():void
		{
			if ( m_open )
			{
				Close();
			}
		}
		
		private function Open():void
		{
			m_open = true;
			
			if ( m_children.length > 0 )
			{
				var oldNext:Item = m_next;
				var lastOpenDescendant:Item = GetLastOpenDescendant();
				
				// First descendant (first child)
				m_next = m_children[ 0 ];
				m_children[ 0 ].SetPrev( this );
				
				// Last open descendant
				lastOpenDescendant.SetNext( oldNext );
				
				if ( oldNext )
				{
					oldNext.SetPrev( lastOpenDescendant );	
				}
			}			
		}
		
		private function Close():void
		{
			m_open = false;
			
			if ( m_children.length > 0 )
			{
				var lastOpenDescendant:Item = GetLastOpenDescendant();
				var postDescendant:Item = lastOpenDescendant.Next();

				// Disconnect first and last open descendants
				lastOpenDescendant.SetNext( null );
				m_children[ 0 ].SetPrev( null );
				
				// Connect to first post-descendant
				m_next = postDescendant;
				
				if ( postDescendant )
				{
					postDescendant.SetPrev( this );
				}
			}			
		}
		
		private function GetLastOpenDescendant():Item
		{
			if ( ! m_children.length )
			{
				return null;
			}
			
			var lastChild:Item = m_children[ m_children.length - 1 ];
			
			if ( lastChild is Folder && Folder(lastChild).IsOpen() )
			{
				return Folder( lastChild ).GetLastOpenDescendant();
			}
			else
			{
				return lastChild;
			}
		}
		
		private var m_open:Boolean;
	}
}