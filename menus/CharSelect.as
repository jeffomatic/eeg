package menus
{
	import entities.BlinkyText;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.Sfx;

	public class CharSelect extends BaseMenu
	{
		public function CharSelect()
		{
			super();
			InitEntities();

			m_retroFlicker = new RetroFlicker;
		}
		
		private function InitEntities():void
		{
			// BG
			add( new Entity(0, 0, new net.flashpunk.graphics.Image(imgBg)) );
			
			// Indicator entity
			m_indicators = [];
			m_indicatorImages = [];
			m_indicatorTexts = [];
			
			for ( var i:uint = 0; i < 6; ++i )
			{
				var indicatorImage:Image = new Image(imgIndicator);
				m_indicatorImages.push( indicatorImage );

				Text.font = "console";
				Text.size = 16;
				var indicatorText:Text = new Text( "P1", 4, 123);
				m_indicatorTexts.push( indicatorText );
				
				var indicatorList:Graphiclist = new Graphiclist;
				indicatorList.add(indicatorImage);
				indicatorList.add(indicatorText);
				
				var indicator:Entity = new Entity(0, 0, indicatorList);
				indicator.visible = false;
				m_indicators.push( indicator );
				
				add( indicator );
			}
			
			Entity( m_indicators[0] ).visible = true;
		}
		
		override public function update():void
		{
			super.update();
			
			if ( Input.pressed(Key.LEFT) )
			{
				if ( m_col > 0 )
				{
					m_col--;
					SfxCharCursor.play();
				}
			}
			else if ( Input.pressed(Key.RIGHT) )
			{
				if ( m_col + 1 < m_colPos.length )
				{
					m_col++;
					SfxCharCursor.play();
				}
			}
			
			if ( Input.pressed(Key.UP) )
			{
				if ( m_row > 0 )
				{
					m_row--;
					SfxCharCursor.play();
				}
			}
			else if ( Input.pressed(Key.DOWN) )
			{
				if ( m_row + 1 < m_rowPos.length )
				{
					m_row++;
					SfxCharCursor.play();
				}
			}
			
			var currentPlayer:uint = Game.Tournament.GetSelectingPlayer();
			
			var critter:String = m_critters[m_row][m_col];
			var critterAssigned:Boolean = Game.Tournament.IsCritterAssigned(critter);
			
			// change indicator on assigned character
			if ( critterAssigned )
			{
				Text(m_indicatorTexts[currentPlayer]).visible = false;
				Image(m_indicatorImages[currentPlayer]).alpha = 0.5;
				Image(m_indicatorImages[currentPlayer]).color = 0x333333;
			}
			else
			{
				Text(m_indicatorTexts[currentPlayer]).visible = true;
				Text(m_indicatorTexts[currentPlayer]).color = m_retroFlicker.GetCurrentColor();
				Image(m_indicatorImages[currentPlayer]).alpha = 1;
				Image(m_indicatorImages[currentPlayer]).color = 0xFFFFFF;
			}			
			
			if ( Input.pressed(Key.SPACE) || Input.pressed(Key.ENTER) )
			{		
				SfxCharChoose.play();
				if ( Game.Tournament.IsCritterAssigned(critter) )
				{

				}
				else
				{
					m_indicatorImages[currentPlayer].alpha = 0.5;
					Image(m_indicatorImages[currentPlayer]).color = 0xFFFFFF;
					Text(m_indicatorTexts[currentPlayer]).color = 0xFFFFFF;
					
					Game.Tournament.SetSelectingPlayerCritter( critter );
					
					if ( Game.Tournament.AllPlayersAssigned() )
					{
						Game.Flow.GamestateFinished();	
					}
					else
					{
						// Needs to be refreshed before we re-assign
						RefreshActivePlayer();
						
						// Hover first available slot
						var done:Boolean = false;
						
						for ( var i:uint = 0; i < m_critters.length; ++i )
						{
							for ( var j:uint = 0; j < (m_critters[i] as Array).length; ++j )
							{
								if ( ! Game.Tournament.IsCritterAssigned(m_critters[i][j]) )
								{
									m_row = i;
									m_col = j;
									done = true;
									break;
								}
							}
							
							if ( done )
							{
								break;
							}
						}							
					}
				}
			}

			RefreshActivePlayer();
			m_retroFlicker.Update( FP.elapsed );
		}
		
		private function RefreshActivePlayer():void
		{
			var currentPlayer:uint = Game.Tournament.GetSelectingPlayer();
			
			Entity(m_indicators[currentPlayer]).visible = true;
			Entity(m_indicators[currentPlayer]).x = m_colPos[ m_col ];
			Entity(m_indicators[currentPlayer]).y = m_rowPos[ m_row ];
			
			m_indicatorTexts[currentPlayer].text = "P" + (currentPlayer + 1);			
		}

		private var m_indicators:Array;
		private var m_indicatorTexts:Array;
		private var m_indicatorImages:Array;
		
		private var m_row:int;
		private var m_col:int;
		
		private var m_retroFlicker:RetroFlicker;
	
		private static const s_colorFrameRate:Number = 1 / 20;
		private static const s_colorFrames:Array = [ 0xFF000, 0x0000FF, 0xFFFFFF, 0x00FFFF, 0xFF00FF ];
		
		// The exact location of the background critters
		private static const m_rowPos:Array = [ 120, 284 ];
		private static const m_colPos:Array = [ 168, 332, 496 ];
		
		private static const m_critters:Array = [
			["panda", "rhino", "tiger"],
			["gorilla", "elephant", "dolphin"]
		];
		
		[Embed(source = "../../assets/UI/1_characterselect.png")]
		private const imgBg:Class;
		
		[Embed(source = "../../assets/UI/highlightstate.png")]
		private const imgIndicator:Class;
		
		[Embed(source = 'assets/sfx/cursor_move.mp3')]
		public static const SFX_CHARCURSOR:Class;
		private static const SfxCharCursor : Sfx = new Sfx(SFX_CHARCURSOR);
		
		[Embed(source = 'assets/sfx/metal_small.mp3')]
		public static const SFX_CHARCHOOSE:Class;
		private static const SfxCharChoose : Sfx = new Sfx(SFX_CHARCHOOSE);
	}
}