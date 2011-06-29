package events.running
{
	import events.BaseEventWorld;
	
	import ff.A;
	
	import flash.text.TextField;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class EventWorld extends BaseEventWorld
	{
		public function EventWorld()
		{
			super();
			
			m_lastTime = 0;
			
			var bgImageA:Image = new Image( imgBgTrack1 );
			
			m_fieldWidth = bgImageA.width;
			m_fieldWidth = Settings.appX;
			
			m_bgBuffer = [];
			m_nextBg = 0;
			
			UpdateBgBuffer( 0 );
			
			// Player
			m_entity = new Runner();
			add( m_entity );			
			
			// Debug text
			m_debugText = Game.DebugText.Add( "PLACEHOLDER", Settings.appX * 3 / 4, 0 );
		}
		
		override protected function InitIntro():void
		{
			m_entity.SetStart();
		}
		
		override protected function UpdateIntro(timeDelta:Number):void
		{
			for each ( var button:uint in s_input )
			{
				if ( Input.pressed(button) )
				{
					FinishIntro();
				}
			}
		}
		
		override protected function InitGameplay():void
		{
			m_progress = 0;
			m_history = new Array;			
		}
		
		override protected function UpdateGameplay( timeDelta:Number ):void
		{
			var currentTime:Number = m_state.GetTime();
			var elapsed:Number = currentTime - m_lastTime;
			m_lastTime = currentTime;
			
			var press:Boolean = false;
			
			if ( Input.pressed(s_input[m_nextInput]) )
			{
				m_nextInput = (m_nextInput + 1) % s_input.length;
				m_entity.NextRun();
				press = true;
			}
			
			m_history.unshift( {time:elapsed, press:press} );
			
			var inputPerSecond:Number = UpdateInputPerSecond();
			
			// Scale the input/second by the critter's speed
			var speedScale:Number = Game.Tournament.GetEventTweakables()[ "speedScale" ];		
			var bgDisp:Number = speedScale * inputPerSecond * timeDelta;

			UpdateBgBuffer( bgDisp );
			m_progress += bgDisp;			
			
			if ( m_progress >= (s_backgrounds.length - 2) * m_fieldWidth )
			{
				FinishGameplay( m_state.GetTime() );
			}
			
			// debug text
			m_debugText.text = "Input/second: " + inputPerSecond
				+ "\nProgress: " + m_progress;			
		}
		
		override protected function InitOutro():void
		{
			m_entity.SetFinished();
			Game.DebugText.Remove( m_debugText );
		}
		
		private function UpdateInputPerSecond():Number
		{
			var i:uint;
			var presses:uint;
			var time:Number = 0;
			
			for ( i = 0; i < m_history.length; ++i )
			{
				time += m_history[ i ][ "time" ];
				presses += m_history[ i ][ "press" ] ? 1 : 0;
				
				if ( time > s_historyWindow )
				{
					m_history = m_history.slice( 0, i + 1 ); // shave history
					return Number(presses) / (1.0 / time); // return presses per second
				}			
			}
			
			return 0;
		}
		
		private function UpdateBgBuffer( displacement:Number ):void
		{
			var newBuffer:Array = [];
			var endOfFieldX:Number = 0;
			
			// Scoot all existin buffers forward
			// Leave behind any that are off-screen
			for each ( var bg:Entity in m_bgBuffer )
			{
				bg.x -= displacement;
				
				// this will discover the last x-position covered by our buffers
				endOfFieldX = bg.x + m_fieldWidth;
				
				// leave behind old buffers
				if ( bg.x < - m_fieldWidth )
				{
					continue;
				}
				else
				{
					newBuffer.push( bg );
				}
			}
			
			m_bgBuffer = newBuffer;
			var bufferDeficit:int = 5 - m_bgBuffer.length;
			
			if ( bufferDeficit > 0 && m_nextBg < s_backgrounds.length )
			{
				for ( var i:uint = 0; i < bufferDeficit; ++i )
				{
					var newBg:Entity = new Entity(
						endOfFieldX,
						0,
						new Image( s_backgrounds[m_nextBg] ) );
					
					add( newBg );
					m_bgBuffer.push( newBg );
					
					m_nextBg++;
					endOfFieldX += m_fieldWidth;
				}
			}
			
			// Re-situate the entity in the draw order
			if ( m_entity )
			{
				remove( m_entity );
				add( m_entity );				
			}
		}
		
		private var m_entity:Runner;
		
		private var m_fieldWidth:Number;
		private var m_progress:Number;
		private var m_nextInput:uint;
		
		private var m_bgBuffer:Array;
		private var m_nextBg:uint;
		
		// Speed averaging
		private var m_history:Array;
		private var m_lastTime:Number;
		
		private var m_debugText:flash.text.TextField;
		
		private static const s_historyWindow:Number = 0.5;
		
		private static const s_input:Array = [
			Key.LEFT_SQUARE_BRACKET,
			Key.RIGHT_SQUARE_BRACKET,
		];
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		[Embed(source = "../../../assets/Backgrounds/running_track_start.png")]
		private static const imgBgTrackStart:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_blank.png")]
		private static const imgBgBlank:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_1.png")]
		private static const imgBgTrack1:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_2.png")]
		private static const imgBgTrack2:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_3.png")]
		private static const imgBgTrack3:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_4.png")]
		private static const imgBgTrack4:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_5.png")]
		private static const imgBgTrack5:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_6.png")]
		private static const imgBgTrack6:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_7.png")]
		private static const imgBgTrack7:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_8.png")]
		private static const imgBgTrack8:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_9.png")]
		private static const imgBgTrack9:Class;
		[Embed(source = "../../../assets/Backgrounds/running_track_finish.png")]
		private static const imgBgTrackFinish:Class;
		
		private static var s_backgrounds:Array=[	
			imgBgTrackStart,			
			imgBgBlank,
			imgBgTrack1,
			imgBgBlank,
			imgBgTrack2,
			imgBgBlank,
			imgBgTrack3,
			imgBgBlank,
			imgBgTrack4,
			imgBgBlank,
			imgBgTrack5,
			imgBgBlank,
			imgBgTrack6,
			imgBgBlank,
			imgBgTrack7,
			imgBgBlank,
			imgBgTrack8,
			imgBgBlank,
			imgBgTrack9,
			imgBgBlank,
			imgBgTrackFinish,
			imgBgBlank,
		];
	}
}