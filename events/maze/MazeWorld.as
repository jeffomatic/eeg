package events.maze
{
	import events.BaseEventWorld;
	
	import ff.A;
	import ff.M;
	
	import flash.ui.Keyboard;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Grid;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class MazeWorld extends BaseEventWorld
	{
		public function MazeWorld()
		{
			super();
			
			// BG
			var playfieldImage:Image = new Image(imgMaze);

			// Grid map
			var tilesX:uint = 32;
			var tilesY:uint = 18;
			
			var playfieldMask:Grid = new Grid( tilesX * 75, tilesY * 75, 75, 75 );
			
			for ( var i:uint = 0; i < s_playfieldGrid.length; ++i )
			{
				for ( var j:uint = 0; j < s_playfieldGrid[0].length; ++j )
				{
					if ( s_playfieldGrid[i][j] )
					{
						playfieldMask.setTile( j, i );
					}
				}
			}			
			
			// Create playfield
			var playfield:Entity = new Entity( 0, 0, playfieldImage, playfieldMask );
			add( playfield );
			playfield.type = "playfield";
			
			// Create pickups
			m_pickups = GetEventTweakables()["pickups"];
			
			// don't let pickups lie on the same rows or columns
			var rows:Array = [];
			var cols:Array = []
			
			for ( var k:uint = 0; k < m_pickups; ++k )
			{
				for (;;)
				{
					var tileX:uint = FP.rand( tilesX );
					var tileY:uint = FP.rand( tilesY );
					
					if ( ! IsOpen(tileX, tileY) )
					{
						continue;
					}
					
					if ( rows.indexOf(tileY) >= 0 || cols.indexOf(tileX) >= 0 )
					{
						continue;
					}
					
					rows.push(tileY);
					cols.push(tileX);

					// create treasure
					add( new MazePickup(
						(tileX + 0.5) * 75,
						(tileY + 0.5) * 75 ) );
					
					break;
				}
			}
			
			// Create hero
			m_player = new MazePlayer(
				GetEventTweakables()["playerStartTileX"] * 75,
				GetEventTweakables()["playerStartTileY"] * 75 );
			add( m_player );
		}
		
		public function IsOpen( tileX:uint, tileY:uint ):Boolean
		{
			return s_playfieldGrid[ tileY ][ tileX ] == 0;
		}
		
		public function OnTreasureCollected():void
		{
			SfxTreasure.play();
			m_pickups--;
			
			if ( ! m_pickups )
			{
				FinishGameplay( m_state.GetTime() );
			}
		}
		
		override protected function UpdateIntro(timeDelta:Number):void
		{
			if ( Input.pressed(Key.LEFT)
				|| Input.pressed(Key.RIGHT)
				|| Input.pressed(Key.UP)
				|| Input.pressed(Key.DOWN) )
			{
				FinishIntro();
			}
			
			UpdateCamera();
		}
		
		override protected function InitGameplay():void
		{
			
		}
		
		override protected function UpdateGameplay(timeDelta:Number):void
		{
			UpdateCamera();
		}
		
		private function UpdateCamera():void
		{
			// focus camera over player
			FP.camera.x = m_player.x - Settings.appX/2 + Number(75)/2;
			FP.camera.y = m_player.y - Settings.appY/2 + Number(75)/2;
			
			// Clamp to playfied
			FP.camera.x = ff.M.clamp( FP.camera.x, 0, 2400 - Settings.appX );
			FP.camera.y = ff.M.clamp( FP.camera.y, 0, 1350 - Settings.appY );
		}
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		private var m_pickups:uint;
		private var m_player:MazePlayer;
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////		
		
		private static const s_playfieldGrid:Array = [
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			[1,0,0,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,1],
			[1,0,1,1,1,1,0,1,1,1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,1,1,1,1,1,0,0,1],
			[1,0,1,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,1,0,1],
			[1,0,1,0,1,1,1,1,0,1,0,1,1,1,1,1,1,1,0,1,1,0,1,0,1,0,1,0,0,1,0,1],
			[1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,1,0,0,0,1,0,0,0,0,1],
			[1,0,1,0,0,0,1,0,1,1,1,1,1,1,1,0,1,0,1,1,1,0,0,0,1,1,1,0,1,1,1,1],
			[1,0,1,1,1,1,1,0,0,0,0,0,0,1,0,0,1,0,1,0,0,0,1,0,1,0,0,0,1,0,0,1],
			[1,0,0,0,0,0,0,0,1,0,1,1,0,1,0,1,1,0,1,1,1,1,1,0,1,0,1,0,1,1,0,1],
			[1,0,1,1,1,0,1,1,1,0,1,0,0,1,0,1,0,0,0,0,0,0,0,0,1,0,1,0,0,0,0,1],
			[1,0,0,0,1,0,1,0,0,0,1,0,1,1,0,1,0,1,1,1,0,1,1,1,1,0,1,1,1,1,0,1],
			[1,0,1,0,1,0,1,1,1,0,0,0,1,1,0,1,0,1,0,0,0,1,0,1,0,0,0,0,0,1,0,1],
			[1,0,1,0,0,0,0,0,0,0,1,0,0,0,0,1,0,1,0,1,0,0,0,0,0,1,0,1,0,1,0,1],
			[1,0,1,0,1,0,1,1,1,1,1,1,1,1,0,1,0,0,0,1,1,1,0,1,1,1,0,1,0,1,0,1],
			[1,0,1,0,1,0,0,0,0,0,0,0,0,0,0,1,0,1,0,1,0,0,0,0,0,1,0,0,0,1,0,1],
			[1,0,1,0,1,1,1,1,1,0,1,1,1,1,1,1,0,1,0,1,1,1,1,1,0,1,1,0,1,1,0,1],
			[1,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,1],
			[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],			
		];
		
		[Embed(source="../../../assets/Backgrounds/maze.png")]
		private static const imgMaze:Class;
		
		[Embed(source = 'assets/sfx/treasure_get.mp3')]
		public static const SFX_TREASURE:Class;
		private static const SfxTreasure : Sfx = new Sfx(SFX_TREASURE);
	}
}