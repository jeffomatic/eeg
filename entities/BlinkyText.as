package entities
{
	import ff.State;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Text;
	
	public class BlinkyText extends Entity
	{
		public function BlinkyText( text:String, size:uint = 16, timeOn:Number = 2, timeOff:Number = 1 )
		{
			m_timeOn = timeOn;
			m_timeOff = timeOff;
			
			// Create state
			m_state = new ff.State;
			m_state.Set( STATE_ON );
			
			// Create text
			m_text = new net.flashpunk.graphics.Text( text );
			m_text.size = size;
			super( 0, 0, m_text );				
		}
		
		public function SetText( text:String ):void
		{
			m_text.text = text;
		}
		
		override public function update():void
		{
			super.update();
			
			if ( m_state.IsChanged() )
			{
				m_state.SetCurrent();
				InitState();
			}
			
			UpdateState();
			m_state.Update( net.flashpunk.FP.elapsed );
		}
		
		private function InitState():void
		{
			switch ( m_state.Get() )
			{
			case STATE_ON:
				m_text.visible = true;
				break;
			
			case STATE_OFF:
				m_text.visible = false;
				break;
			}
		}
		
		private function UpdateState():void
		{
			switch ( m_state.Get() )
			{
			case STATE_ON:
				if ( m_state.GetTime() >= m_timeOn )
				{
					m_state.Set( STATE_OFF );
				}
				break;
			
			case STATE_OFF:
				if ( m_state.GetTime() >= m_timeOff )
				{
					m_state.Set( STATE_ON );
				}
				break;
			}
		}		
		
		private var m_state:ff.State;
		private var m_text:net.flashpunk.graphics.Text;
		private var m_timeOn:Number;
		private var m_timeOff:Number;
		
		private const STATE_ON:uint = 0;
		private const STATE_OFF:uint = 1;
	}
}