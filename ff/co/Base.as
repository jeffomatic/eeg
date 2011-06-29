package ff.co
{
	public class Base
	{
		/**
		 * Don't override this.
		 */
		public function OnAdd( host : List ) : void
		{
			m_list = host;
			OnAddInternal();
		}
		
		/**
		 * Don't override this.
		 */
		public function OnRemove() : void
		{
			OnRemoveInternal();
			m_list = null;
		}
		
		public function Update( timeDelta : Number ) : void
		{
			// do nothing	
		}
		
		public function GetList() : List
		{
			return m_list;
		}
		
		protected function OnAddInternal() : void
		{
			// do nothing
		}		
		
		protected function OnRemoveInternal() : void
		{
			// do nothing
		}		
		
		private var m_list : List = null;
	}
}