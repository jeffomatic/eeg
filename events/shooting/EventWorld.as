package events.shooting
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
			
			var t:Object = GetEventTweakables();
			
			// Create bg
			var bg:net.flashpunk.graphics.Image = new Image(imgBgField);
			add( new Entity(0, 0, bg) );
			
			// Create dodger
			m_player = new Dodger( t["startX"], t["startY"] );
			add( m_player );
			
			// Create spawn points
			m_spawnPoints = [];
			m_spawnPointsGrabbag = [];
			
			var i:uint = 0;
			var intervalX:Number = Number(Settings.appX) / 32;
			
			for ( i = 0; i < 31; ++i )
			{
				var x:Number = intervalX * (2 * i + 1) / 2;
				
				// top perimeter
				var yTop:Number = t["perimeterT"];
				
				// lower perimeter
				var yBottom:Number = t["perimeterB"];
					
				m_spawnPoints.push( [x, yTop] );
				m_spawnPoints.push( [x, yBottom] );
			}
			
			var intervalY:Number = Number(Settings.appY) / 24;			
			
			for ( i = 1; i < 22; ++i ) // skip corner points
			{
				var y:Number = intervalY * (2 * i + 1) / 2;
				
				// left
				var xLeft:Number = t["perimeterL"];
				
				// right
				var xRight:Number = t["perimeterR"];
				
				m_spawnPoints.push( [xLeft, y] );
				m_spawnPoints.push( [xRight, y] );
			}
		}
		
		override protected function InitGameplay():void
		{
			m_spawnTimer = 0;
			m_spawnDelay = 2.0;
			m_spawnModifier = 0.98;
		}
		
		override protected function UpdateGameplay(timeDelta:Number):void
		{
			m_spawnTimer += timeDelta;
			
			if ( m_spawnTimer > m_spawnDelay )	
			{
				m_spawnTimer = 0;
				m_spawnDelay *= m_spawnModifier;
				SpawnRandomBullet();
			}
			
			if ( m_player.IsDead() )
			{
				FinishGameplay( m_state.GetTime() );
			}
		}
		
		private function GetSpawnPointFromGrabbag():Array
		{
			if ( ! m_spawnPointsGrabbag.length )
			{
				for each ( var sp:Array in m_spawnPoints )
				{
					m_spawnPointsGrabbag.push( sp );
				}
			}
			
			var r:uint = FP.rand( m_spawnPointsGrabbag.length );
			var spawnPoint:Array = m_spawnPointsGrabbag[r];
			
			// remove from grabbag
			var copy:Array = [];
			
			for ( var i:uint = 0; i < m_spawnPointsGrabbag.length; ++i )
			{
				if ( i == r )
				{
					continue;
				}
				
				copy.push( m_spawnPointsGrabbag[i] );
			}
			
			m_spawnPointsGrabbag = copy;
			
			return spawnPoint;
		}
		
		private function SpawnBullet( sourceX:Number, sourceY:Number ):void
		{	
			var dx:Number = (m_player.x + m_player.halfWidth) - sourceX;
			var dy:Number = (m_player.y + m_player.halfHeight) - sourceY;
			var angle:Number = Math.atan2( dy, dx );
			
			add( new Bullet(sourceX, sourceY, angle) );
			add( new Splosion(sourceX, sourceY) );
		}
		
		private function SpawnRandomBullet():void
		{
			var point:Array = GetSpawnPointFromGrabbag();
			SpawnBullet( point[0], point[1] );
		}
		
		private var m_player:Dodger;
		private var m_spawnPoints:Array;
		private var m_spawnPointsGrabbag:Array;
		private var m_spawnTimer:Number;
		private var m_spawnDelay:Number;
		private var m_spawnModifier:Number;
		
		[Embed(source="../../../assets/Backgrounds/hunting field.png")]
		private static const imgBgField:Class;
	}
}