package events.maze
{
	import events.BaseEventEntity;
	
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Hitbox;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class MazePlayer extends BaseEventEntity
	{
		public function MazePlayer(x:Number=0, y:Number=0)
		{	
			super( x, y, "smallMap", 75, 75, false );
			
			mask = new Hitbox( 50, 50, 12, 25 );
			type = "mazePlayer";

			m_state.Set( STATE_ALIVE );			
		}
		
		override protected function UpdateState(timeDelta:Number):void
		{
			switch ( m_state.Get() )
			{
			case STATE_ALIVE:
				{
					UpdateMotion( timeDelta );
				}
				break;
			}
		}
		
		private function UpdateMotion(timeDelta:Number):void
		{
			var t:Object = GetEventTweakables();
			
			var speed:Number = t["playerSpeed"];
			
			if ( Input.check(Key.LEFT) )
			{
				m_velX = -speed;
				m_spritemap.flipped = true;
				m_spritemap.play( "running" );
			}
			else if ( Input.check(Key.RIGHT) )
			{
				m_velX = speed;
				m_spritemap.flipped = false;
				m_spritemap.play( "running" );
			}
			else
			{
				m_velX = 0;
			}
			
			if ( Input.check(Key.UP) )
			{
				m_velY = -speed;
				m_spritemap.play( "running" );
			}
			else if ( Input.check(Key.DOWN) )
			{
				m_velY = speed;
				m_spritemap.play( "running" );
			}
			else
			{
				m_velY = 0;
			}
			
			if ( m_velX == 0 && m_velY == 0 )
			{
				m_spritemap.play( "idle" );
			}
			
			// Move with collision
			moveTo( x + m_velX * timeDelta, y + m_velY * timeDelta, "playfield" );		
		}
		
		private var m_velX:Number;
		private var m_velY:Number;
		
		private static const STATE_ALIVE:uint = 0;
		private static const STATE_DEAD:uint = 1;
	}
}