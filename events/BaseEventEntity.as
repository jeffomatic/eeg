package events
{
	import ff.FPUtil;
	import ff.State;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Anim;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	
	public class BaseEventEntity extends Entity
	{
		public function BaseEventEntity(
			x:Number = 0,
			y:Number = 0,
			spritemap:*="largeMap",
			frameWidth:Number=128,
			frameHeight:Number = 128,
			usePixelmasks:Boolean = true )
		{
			// Create spritemap					
			if ( spritemap is String )
			{
				m_spritemap = new Spritemap(
					Game.Tournament.GetCompetingCritterData()[ spritemap ],
					frameWidth,
					frameHeight );
			}
			else
			{
				m_spritemap = new Spritemap( spritemap, frameWidth, frameHeight );
			}
			
			m_spritemap.add( "idle", [0] );
			m_spritemap.add( "runA", [1] );
			m_spritemap.add( "runB", [2] );
			m_spritemap.add( "jump", [3] );
			m_spritemap.add( "hit", [4] );
			m_runningAnim = m_spritemap.add( "running", [1, 2], 6, true );
			
			// Parent constructor
			super(
				x - frameWidth/2,
				y - frameHeight, // visually focus on center-bottom
				m_spritemap );
			
			if ( usePixelmasks )
			{
				// Generate pixel-perfect collision buffers
				m_pixelmasks = ff.FPUtil.GetPixelmasks( m_spritemap, frameWidth, frameHeight );					
			}		
			
			// state machine
			m_state = new State;
		}
		
		override public function update():void
		{
			super.update();
			
			if ( m_pixelmasks )
			{
				// synch pixelmask with current anim frame
				mask = m_pixelmasks[m_spritemap.frame];			
			}
			
			if ( m_state.IsChanged() )
			{
				m_state.SetCurrent();
				InitState();
			}
			
			UpdateState( net.flashpunk.FP.elapsed );
			m_state.Update( net.flashpunk.FP.elapsed );			
		}
		
		protected function InitState():void
		{
			// do nothing
		}
		
		protected function UpdateState( timeDelta:Number ):void
		{
			// do nothing
		}
		
		protected function GetEventTweakables():Object
		{
			return Game.Tournament.GetEventTweakables();
		}
		
		public var m_spritemap:Spritemap;
		protected var m_runningAnim:Anim;
		protected var m_pixelmasks:Array;
		protected var m_state:ff.State;
	}
}