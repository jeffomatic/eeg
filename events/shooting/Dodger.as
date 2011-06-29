package events.shooting
{
	import events.BaseEventEntity;
	
	import ff.M;
	import ff.State;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Dodger extends BaseEventEntity
	{
		public function Dodger(x:Number=0, y:Number=0)
		{
			super(x, y, "smallMap", 75, 75);
			
			// collision
			type = "dodger";
			
			// state
			m_state.Set( STATE_ALIVE );
			
			// motion
			m_velX = 0;
			m_velY = 0;
		}
		
		public function OnHit():void
		{
			m_state.Set( STATE_DEAD );
		}
		
		public function IsDead():Boolean
		{
			return m_state.Get() == STATE_DEAD;
		}
		
		override protected function UpdateState(timeDelta:Number):void
		{
			switch ( m_state.Get() )
			{
			case STATE_ALIVE:
				UpdateInput( timeDelta );
				break;
			
			case STATE_DEAD:
				m_spritemap.play( "hit" );
				break;
			}
		}
		
		private function UpdateInput(timeDelta:Number):void
		{
			var t:Object = GetEventTweakables();
			
			var speed:Number = t["playerSpeed"];
			
			// account for diagonal motion
			if ( (Input.check(Key.LEFT) || Input.check(Key.RIGHT))
			  && (Input.check(Key.UP) || Input.check(Key.DOWN)) )
			{
				 speed / Math.SQRT2;
			}
			
			if (Input.check(Key.LEFT))
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
			
			if (Input.check(Key.UP))
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
			
			// Apply velocity
			x += m_velX * timeDelta;
			y += m_velY * timeDelta;
			
			// Constrain to boundaries
			x = ff.M.clamp( x, t["perimeterL"], t["perimeterR"] - width );
			y = ff.M.clamp( y, t["perimeterT"], t["perimeterB"] - height );
		}
		
		private var m_velX:Number;
		private var m_velY:Number;
		
		private static var STATE_ALIVE:uint = 0;
		private static var STATE_DEAD:uint = 1;
	}
}