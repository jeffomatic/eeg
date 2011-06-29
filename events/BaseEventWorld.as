package events
{
	import Game;
	
	public class BaseEventWorld extends BaseStateWorld
	{
		public function BaseEventWorld()
		{
			super();
			m_score = 0;
			m_state.Set( STATE_INTRO );
		}
		
		override protected function InitState():void
		{
			switch ( m_state.Get() )
			{
			case STATE_INTRO:
				InitIntro();
				break;
			
			case STATE_GAMEPLAY:
				InitGameplay();
				m_timerWidget = new TimerWidget( Settings.timer.x, Settings.timer.x );
				add( m_timerWidget );			
				break;
			
			case STATE_OUTRO:
				InitOutro();
				break;
			
			case STATE_DONE:
				Game.Tournament.SetPlayerFinishedCompeting( m_score );
				Game.Flow.GamestateFinished();
				break;
			}
		}
		
		override protected function UpdateState( timeDelta:Number ):void
		{
			switch ( m_state.Get() )
			{
			case STATE_INTRO:
				UpdateIntro( timeDelta );
				break;
			
			case STATE_GAMEPLAY:
				UpdateGameplay( timeDelta );
				// refresh timer z
				remove( m_timerWidget );
				add( m_timerWidget );
				m_timerWidget.SetTime( m_state.GetTime() );				
				break;
			
			case STATE_OUTRO:
				UpdateOutro( timeDelta );
				break;
			}
		}
		
		protected function InitIntro():void
		{
			// do nothing
		}	
		
		protected function UpdateIntro( timeDelta:Number ):void
		{
			// finish by default
			FinishIntro();
		}
		
		protected function FinishIntro():void
		{
			m_state.Set( STATE_GAMEPLAY );
		}			
		
		protected function InitGameplay():void
		{
			// do nothing
		}
		
		protected function UpdateGameplay( timeDelta:Number ):void
		{
			// finish by default
			FinishGameplay( 0 );
		}
		
		protected function FinishGameplay( score:Number ):void
		{
			m_score = score;
			m_state.Set( STATE_OUTRO );
		}
		
		protected function InitOutro():void
		{
			// do nothing
		}
		
		protected function UpdateOutro( timeDelta:Number ):void
		{
			// finish by default
			FinishOutro();
		}
		
		protected function FinishOutro():void
		{
			m_state.Set( STATE_DONE );
		}
		
		protected function GetEventTweakables():Object
		{
			return Game.Tournament.GetEventTweakables();	
		}
		
		protected var m_score:Number;
		protected var m_timerWidget:events.TimerWidget;
		
		private static const STATE_INTRO:uint = 0;
		private static const STATE_GAMEPLAY:uint = 1;
		private static const STATE_OUTRO:uint = 2;
		private static const STATE_DONE:uint = 3;
		protected static const STATE_RESERVE:uint = STATE_DONE + 1;
	}
}