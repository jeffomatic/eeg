package events.hurdles
{
	import events.BaseEventEntity;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class Hurdler extends BaseEventEntity
	{
		public function Hurdler()
		{
			m_velX = 0;
			m_velY = 0;
			
			m_trackPosX = 0;
			m_trackPosY = 0;
			
			super();
			
			// for collision detection
			type = "hurdler";
		}
		
		public function GetTrackPosX():Number { return m_trackPosX; }
		public function GetTrackPosY():Number { return m_trackPosY; }
		public function GetVelX():Number { return m_velX; }
		
		public function StartRunning():void
		{
			m_state.Set( STATE_RUN );
		}
		
		public function HitTrap( trap: Trap ):void
		{
			m_state.Set( STATE_TRAPPED );
		}
		
		public function IsTrapped():Boolean
		{
			return m_state.Get() == STATE_TRAPPED;
		}
		
		override protected function InitState():void
		{
			switch ( m_state.Get() )
			{
			case STATE_RUN:
				m_spritemap.play( "running" );
				break;
			
			case STATE_JUMP:
				m_spritemap.play( "jump" );
				m_velY = GetEventTweakables()[ "jumpVel" ];
				break;
			
			case STATE_TRAPPED:
				m_spritemap.play( "hit" );
				break;
			}
		}
		
		override protected function UpdateState(timeDelta:Number):void
		{
			switch ( m_state.Get() )
			{
			case STATE_RUN:
			{
				if ( Input.pressed(Key.SPACE) )
				{
					m_state.Set( STATE_JUMP );
				}
				
				var accel:Number = m_velX > GetEventTweakables()["thresholdVel"]
					? GetEventTweakables()["accelPostThreshold"]
					: GetEventTweakables()["accelPreThreshold"];
				
				m_trackPosX += (m_velX * timeDelta) + (0.5 * timeDelta * timeDelta * accel);
				m_velX += accel * timeDelta;
				
				SynchAnim();
			}
			break;
			
			case STATE_JUMP:
				{
					var jumpGravity:Number = GetEventTweakables()["jumpGravity"];
					
					// Non-euler
					m_velY += timeDelta * jumpGravity;
					m_trackPosY += m_velY * timeDelta;
					
					//m_trackPosY += ( m_velY * timeDelta ) + ( 0.5 * timeDelta * timeDelta * jumpGravity );
					//m_velY += timeDelta * jumpGravity;
					
					if ( m_trackPosY > 0 )
					{
						m_trackPosY = 0;
						m_velY = 0;
						
						m_state.Set( STATE_RUN );
					}
					
					m_trackPosX += (m_velX * timeDelta);
					
					SynchAnim();
				}
				break;
			}
		}
		
		private function SynchAnim():void
		{
			var tweaks:Object = GetEventTweakables();
			m_runningAnim.frameRate = tweaks["frameRateBase"] + ( tweaks["frameRateScale"] * m_velX );
		}
		
		private var m_velX:Number;
		private var m_velY:Number;
		
		private var m_trackPosX:Number;
		private var m_trackPosY:Number;
		
		private static const STATE_RUN:uint = 0;
		private static const STATE_JUMP:uint = 1;
		private static const STATE_TRAPPED:uint = 2;
	}
}