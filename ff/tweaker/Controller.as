package ff.tweaker
{
	public class Controller
	{
		public function Controller( root : Item )
		{
			m_root = root;
			

		}
		
		public function CheckCurrent():void
		{
			if ( ! m_current && m_root.Children().length > 0 )
			{
				m_current = m_root.Children()[ 0 ];
				m_current.Select();
			}			
		}
		
		public function OnAction( action:uint ):void
		{
			CheckCurrent();
			
			if ( ! m_current )
			{
				return;
			}
			
			if ( m_current.IsTweaking() )
			{
				switch ( action )
				{
				case InputActions.UP:
				case InputActions.DOWN:
				case InputActions.LEFT:
				case InputActions.RIGHT:
				case InputActions.ALT_UP:
				case InputActions.ALT_DOWN:
				case InputActions.ALT_LEFT:
				case InputActions.ALT_RIGHT:					
					m_current.OnAction( action );
					break;
				
				case InputActions.CLICK:
					m_current.Click();
					break;
				
				case InputActions.BACKCLICK:
					m_current.BackClick();
					break;
				}
			}
			else
			{
				switch ( action )
				{
				case InputActions.UP:
					if ( m_current.Prev() )
					{
						m_current.Unselect();
						m_current = m_current.Prev();
						m_current.Select();
					}
					break;
				
				case InputActions.DOWN:
					if ( m_current.Next() )
					{
						m_current.Unselect();
						m_current = m_current.Next();
						m_current.Select();
					}
					break;
				
				case InputActions.CLICK:
					m_current.Click();
					break;
				
				case InputActions.BACKCLICK:
					m_current.BackClick();
					break;				
				}				
			}
		}
		
		private var m_root : Item;
		private var m_current : Item;
	}
}