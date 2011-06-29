package ff.tweaker
{
	public class Callback extends Item
	{
		public function Callback( callback:Function, args:Array = null )
		{
			m_callback = callback;
			m_args = args ? args : [];
		}
		
		override protected function OnClick():void
		{
			if ( m_callback == null )
			{
				return;
			}
			
			switch ( m_args.length )
			{
			case 0: m_callback(); break;
			case 1: m_callback( m_args[0] ); break;
			case 2: m_callback( m_args[0], m_args[1] ); break;
			case 3: m_callback( m_args[0], m_args[1], m_args[2] ); break;
			case 4: m_callback( m_args[0], m_args[1], m_args[2], m_args[3] ); break;
			case 5: m_callback( m_args[0], m_args[1], m_args[2], m_args[3], m_args[4] ); break;
			case 6: m_callback( m_args[0], m_args[1], m_args[2], m_args[3], m_args[4], m_args[5] ); break;
			case 7: m_callback( m_args[0], m_args[1], m_args[2], m_args[3], m_args[4], m_args[5], m_args[6] ); break;
			case 8: m_callback( m_args[0], m_args[1], m_args[2], m_args[3], m_args[4], m_args[5], m_args[6], m_args[7] ); break;
			}
		}
		
		private var m_callback:Function;
		private var m_args:Array;
	}
}