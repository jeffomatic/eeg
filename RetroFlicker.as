package
{
	public class RetroFlicker
	{
		public function RetroFlicker()
		{
			m_textColorTimer = 0;
			m_textColorFrame = 0;
		}
		
		public function Update( timeDelta:Number ):void
		{				
			m_textColorTimer += timeDelta;
			
			if ( m_textColorTimer > s_colorFrameRate )
			{
				m_textColorFrame = (m_textColorFrame + 1) % s_colorFrames.length;				
				m_textColorTimer -= s_colorFrameRate;
			}			
		}
		
		public function GetCurrentColor():uint
		{
			return s_colorFrames[ m_textColorFrame ];
		}
		
		private var m_textColorTimer:Number;
		private var m_textColorFrame:uint;
		
		private static const s_colorFrameRate:Number = 1 / 20;
		private static const s_colorFrames:Array = [ 0xFF000, 0x0000FF, 0xFFFFFF, 0x00FFFF, 0xFF00FF ];		
	}
}