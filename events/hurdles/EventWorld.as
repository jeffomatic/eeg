package events.hurdles
{
	import events.BaseEventWorld;
	
	import ff.M;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;

	public class EventWorld extends BaseEventWorld
	{
		public function EventWorld()
		{
			super();
			
			m_traps = new Array;
			
			// Create BG
			var bgImageA:Image = new Image( imgTrack );
			var bgImageB:Image = new Image( imgTrack );
			
			m_bgA = new Entity(0, 0, bgImageA);
			m_bgB = new Entity(0, 0, bgImageB);
			
			add( m_bgA );
			add( m_bgB );
			
			m_fieldWidth = bgImageA.width;
			
			// Create hurdler
			m_hurdler = new Hurdler;
			add( m_hurdler );
			SynchHurdlerPos();
		}
		
		override protected function InitGameplay():void
		{
			m_trapDistance = 0;
			m_hurdler.StartRunning();
		}
		
		override protected function UpdateGameplay(timeDelta:Number):void
		{
			if ( m_hurdler.IsTrapped() )
			{
				FinishGameplay( m_state.GetTime() );
			}
			else
			{
				UpdateBg();
				UpdateTraps( timeDelta );			
				SynchHurdlerPos();				
			}
		}
		
		private function SynchHurdlerPos():void
		{
			var tweaks:Object = GetEventTweakables();
			
			m_hurdler.x = tweaks["startX"] - m_hurdler.m_spritemap.GetFrameWidth() / 2;
			m_hurdler.y = tweaks["startY"] + m_hurdler.GetTrackPosY() - m_hurdler.m_spritemap.GetFrameHeight();
		}
		
		private function UpdateBg():void
		{
			var bgDisp:Number;
			
			// ghetto fmod
			for (
				bgDisp = m_hurdler.GetTrackPosX();
				bgDisp - m_fieldWidth > 0;
				bgDisp -= m_fieldWidth )
			{
				// do nothing
			}
			
			m_bgA.x = - bgDisp;
			m_bgB.x = - bgDisp + m_fieldWidth;			
		}
		
		private function UpdateTraps( timeDelta:Number ):void
		{
			// advance each hurdle
			for each ( var h:Trap in m_traps )
			{
				h.x -= m_hurdler.GetVelX() * timeDelta;
			}
			
			// remove stale hurdles
			while ( m_traps[0] && m_traps[0].x < -150 )
			{
				var toRemove:Trap = m_traps.shift();
				remove( toRemove );
			}
			
			// Spawn hurdles
			var tweaks:Object = GetEventTweakables();
			
			if ( m_hurdler.GetVelX() > tweaks["trapSpawnMinVel"] )
			{
				m_trapDistance += timeDelta * m_hurdler.GetVelX();
				
				if ( m_trapDistance >= tweaks["trapSpawnDistance"] )
				{
					var trap:Trap;
					m_trapDistance = 0;
					
					switch ( GetRandomTrapPattern() )
					{
					case TRAP_PATTERN_SINGLE:
						trap = new Trap( tweaks["trapX"], tweaks["trapY"] );
						add( trap );
						m_traps.push( trap );
						break;
					
					case TRAP_PATTERN_MULTI:
						m_trapDistance -= tweaks["patternMultiOffset"];
						
						trap = new Trap( tweaks["trapX"], tweaks["trapY"] );
						add( trap );
						m_traps.push( trap );
						
						trap = new Trap( tweaks["trapX"] + tweaks["patternMultiOffset"], tweaks["trapY"] );
						add( trap );
						m_traps.push( trap );
						
						if ( m_hurdler.GetVelX() >= tweaks["thresholdVel"] )
						{
							m_trapDistance -= tweaks["patternMultiOffset"]; 
							
							trap = new Trap( tweaks["trapX"] + 2 * tweaks["patternMultiOffset"], tweaks["trapY"] );
							add( trap );
							m_traps.push( trap );							
						}
						break;
					
					case TRAP_PATTERN_TRICKY:
						m_trapDistance -= tweaks["patternTrickyOffset"];
						
						trap = new Trap( tweaks["trapX"], tweaks["trapY"] );
						add( trap );
						m_traps.push( trap );
						
						trap = new Trap( tweaks["trapX"] + tweaks["patternTrickyOffset"], tweaks["trapY"] );
						add( trap );
						m_traps.push( trap );
						
						if ( m_hurdler.GetVelX() >= tweaks["thresholdVel"] )
						{
							m_trapDistance -= tweaks["patternTrickyOffset"]; 
							
							trap = new Trap( tweaks["trapX"] + 2 * tweaks["patternTrickyOffset"], tweaks["trapY"] );
							add( trap );
							m_traps.push( trap );							
						}
						break;					
					}
				}		
			}
		}
		
		private function GetRandomTrapPattern():uint
		{
			var t:Object = GetEventTweakables();
			var total:uint = t["patternSingleWeight"]
			                 + t["patternMultiWeight"]
						     + t["patternTrickyWeight"];
						   
			var experiment:uint = FP.rand( total );
			
			if ( experiment >= t["patternSingleWeight"] + t["patternMultiWeight"] )
			{
 				return TRAP_PATTERN_TRICKY;
			}
			else if ( experiment >= t["patternSingleWeight"] )
			{
				return TRAP_PATTERN_MULTI;
			}
			else
			{
				return TRAP_PATTERN_SINGLE;
			}
		}
		
		private var m_bgA:Entity;
		private var m_bgB:Entity;
		
		private var m_fieldWidth:Number;
		
		private var m_hurdler:Hurdler;
		private var m_traps:Array;
		
		private var m_trapDistance:Number;
		
		private static const TRAP_PATTERN_SINGLE:uint = 0;
		private static const TRAP_PATTERN_MULTI:uint = 1;
		private static const TRAP_PATTERN_TRICKY:uint = 2;
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		[Embed(source = "../../../assets/Backgrounds/running track.png")]
		private static const imgTrack:Class;		
	}
}