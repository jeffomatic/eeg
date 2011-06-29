package ff
{
	public class State
	{
		public function State()
		{
			m_state = -1;
			m_pendingState = -1;
			m_prevState = -1;
			m_time = 0;
			m_frameCount = 0;
		}
		
		public function Get():int
		{
			return m_state;	
		}
		
		public function GetPendingState():int
		{
			return m_pendingState;
		}
		
		public function GetPrevState():int
		{
			return m_prevState;
		}
		
		// Only send positive values!
		public function Set( s:uint ):void
		{
			m_pendingState = s;
		}
		
		public function IsChanged():Boolean
		{
			return m_pendingState >= 0;
		}
		
		public function SetCurrent():void
		{
			m_prevState = m_state;
			m_state = m_pendingState;
			m_pendingState = -1;
			
			m_time = 0;
			m_frameCount = 0;
		}
		
		public function Update( timeDelta:Number ):void
		{
			m_time += timeDelta;			
			m_frameCount++;
		}
		
		public function GetFrameCount():uint
		{
			return m_frameCount;
		}
		
		public function GetTime():Number
		{
			return m_time;	
		}
		
		private var m_state:int;
		private var m_pendingState:int;
		private var m_prevState:int;
		private var m_time:Number;
		private var m_frameCount:uint;
	}
}