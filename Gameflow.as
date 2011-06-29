package
{
	import cutscenes.CutsceneGrabbag;
	import cutscenes.EndCutscene;
	import cutscenes.IntroCutscene;
	
	import events.BaseEventWorld;
	
	import flash.utils.getQualifiedClassName;
	
	import menus.CharSelect;
	import menus.EventResults;
	import menus.InstructionMenu;
	import menus.TitleMenu;
	import menus.TournamentResults;
	
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;

	public class Gameflow
	{
		public function Gameflow()
		{
			m_gamestateStack = [];
			m_gamestateStack.push( menus.TitleMenu );
			
		}
		
		
		public function NextState():void
		{
			if ( ! m_gamestateStack.length )
			{
				return;
			}
			
			var c:Class = m_gamestateStack.shift();
 			FP.world = new c;

		}
		
		public function GamestateFinished():void
		{
			m_transition = true;
			m_doTransitionFade = true;

			if ( FP.world is menus.TitleMenu )
			{
				if ( Game.Tournament.GetPlayerCount() > 0 )
				{
					m_gamestateStack.push( menus.CharSelect );
				}
				
			}
			else if ( FP.world is menus.CharSelect )
			{
				m_gamestateStack.push( cutscenes.IntroCutscene );
				Game.Music.SetVolume( 0.5 );
			}
			else if ( FP.world is cutscenes.IntroCutscene )
			{
				m_gamestateStack.push( menus.InstructionMenu );
			}
			else if ( FP.world is menus.InstructionMenu )
			{
				if (Game.Music.IsPlaying())
				{ 
					Game.Music.Stop();
				}
				m_gamestateStack.push( Game.Tournament.GetEventDescriptor()["world"] );
			}
			else if ( FP.world is events.BaseEventWorld )
			{
				if ( Game.Tournament.AllPlayersFinishedEvent() )
				{				
					m_gamestateStack.push( menus.EventResults );
				}
				else // we just finished someone's turn
				{
					m_gamestateStack.push( Game.Tournament.GetEventDescriptor()["world"] );
				}
			}
			else if ( FP.world is cutscenes.CutsceneGrabbag )
			{
				m_gamestateStack.push( menus.InstructionMenu );
			}
			else if ( FP.world is menus.EventResults )
			{
				Game.Tournament.SetPostEventComplete();
				
				if ( Game.Tournament.AllEventsFinished() )
				{
					m_gamestateStack.push( menus.TournamentResults );
				}
				else // go on to next event
				{
					m_gamestateStack.push( cutscenes.CutsceneGrabbag );
				}
			}			
			else if ( FP.world is menus.TournamentResults )
			{
				m_gamestateStack.push( cutscenes.EndCutscene );
			}
			else if ( FP.world is cutscenes.EndCutscene )
			{
				m_gamestateStack.push( menus.TitleMenu );
			}
		}
		
		public function Update( timeDelta:Number ):void
		{
			//!!!TODO - Play transition
			if ( m_transition )
			{
				if ( m_doTransitionFade )
				{
					Game.Fader.FadeOut( OnFadeOutComplete );
					Input.SetEnabled( false );
				}
				else
				{
					NextState();
				}
				
				m_transition = false;
				m_doTransitionFade = false;
			}
		}
		
		private function OnFadeOutComplete():void
		{
			NextState();
			Game.Fader.FadeIn();
			Input.SetEnabled( true );
		}
		
		private var m_gamestateStack:Array;
		private var m_nextEventIndex:int;
		private var m_transition:Boolean;
		private var m_doTransitionFade:Boolean;
	}
}