package menus
{
	import Game;
	
	import Settings;
	
	import entities.BlinkyText;
	
	import ff.S;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Sfx;


	public class TitleMenu extends BaseMenu
	{
		public function TitleMenu()
		{
			super();
			InitEntities();
			m_state.Set( STATE_PLAYERCOUNT );
			m_retroFlicker = new RetroFlicker;
			

		}
		
		private function InitEntities():void
		{
			// BG
			add( new Entity(0, 0, new Image(imgBg)) );
			
			// Text
			Text.font = "console";
			Text.size = 50;
			
			m_playersText = new Text("X");
			m_playersText.smooth = true;
			
			add( new Entity(
				440 - m_playersText.width/2,
				370 - m_playersText.height/2,
				m_playersText ) );		
			
			

		
		}
		
		override protected function InitState():void
		{
			if (!Game.Music.IsPlaying())
			{ 
				Game.Music.Start();
			}
			
			switch ( m_state.Get() )
	 		{		
			case STATE_PLAYERCOUNT:
				m_playersSelected = 1;
				break;
			
			case STATE_DONE:
				m_playersText.color = 0xCCFFFF;
				Game.Tournament.Setup( m_playersSelected );
				Game.Flow.GamestateFinished();
				break;
			}
		}
		
		override protected function UpdateState(timeDelta:Number):void
		{		
			switch ( m_state.Get() )
			{
			case STATE_PLAYERCOUNT:
				if ( Input.pressed(Key.ENTER) )
				{
					SfxConfirm.play();
					m_state.Set( STATE_DONE );	
				}
				else
				{
					if ( Input.pressed(Key.LEFT) || Input.pressed(Key.DOWN) )
					{
						m_playersSelected--;
						SfxCursor.play();
					}
					else if ( Input.pressed(Key.RIGHT) || Input.pressed(Key.UP) )
					{
						m_playersSelected++;
						SfxCursor.play();
					}
					
					m_playersSelected = ff.M.clamp( m_playersSelected, 1, ff.A.Count(Settings.Critters) );
				}
				
				m_playersText.text = String(m_playersSelected);
				
				m_retroFlicker.Update( FP.elapsed );
				m_playersText.color = m_retroFlicker.GetCurrentColor();
				break;
			}
		}
		
		private var m_playersSelected:uint;
		private var m_playersText:Text;
		private var m_retroFlicker:RetroFlicker;
		
		private static const STATE_PLAYERCOUNT:uint = 0;
		private static const STATE_DONE:uint = 1;
		
		[Embed(source = "../../assets/UI/0_introscreen.png")]
		private const imgBg:Class;
		
		[Embed(source = 'assets/sfx/cursor_move.mp3')]
		public static const SFX_CURSOR:Class;
		private static const SfxCursor : Sfx = new Sfx(SFX_CURSOR);
		
		[Embed(source = 'assets/sfx/metal_small.mp3')]
		public static const SFX_CONFIRM:Class;
		private static const SfxConfirm : Sfx = new Sfx(SFX_CONFIRM);
		
		//[Embed(source = 'assets/music/title.mp3')]
		//public static const MUSIC_TITLE:Class;
		//public static const MusicTitle : Sfx = new Sfx(MUSIC_TITLE);
		
		
	}
}