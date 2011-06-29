package events.running
{
	import events.BaseEventEntity;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Runner extends BaseEventEntity
	{
		public function Runner()
		{		
			super( Settings.appX * 0.4, Settings.appY * 0.75 );
		}
		
		public function SetStart():void	
		{
			m_spritemap.play( "idle" );
		}
		
		public function NextRun():void
		{
			var nextRun:String = ( m_lastRun == "runA" ) ? "runB" : "runA";
			m_spritemap.play( nextRun );
			m_lastRun = nextRun;
		}
		
		public function SetFinished():void
		{
			m_spritemap.play( "idle" );
		}
		
		private var m_lastRun:String;
	}
}