package
{
	import ff.State;
	
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	public class BaseStateWorld extends World
	{
		public function BaseStateWorld()
		{
			super();
			m_state = new ff.State();
		}
		
		override public function update():void
		{
			// Updates the entities
			super.update();
			
			// Update the world state
			if ( m_state.IsChanged() )
			{
				m_state.SetCurrent();
				InitState();
			}
			
			UpdateState( net.flashpunk.FP.elapsed );
			m_state.Update( net.flashpunk.FP.elapsed );			
		}
		
		protected function InitState():void
		{
			// do nothing by default
		}
		
		protected function UpdateState( timeDelta:Number ):void
		{
			// do nothing by default
		}
		
		protected var m_state:ff.State;
	}
}