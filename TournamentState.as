package
{
	import ff.A;
	import ff.U;
	
	import net.flashpunk.FP;

	public class TournamentState
	{
		public function TournamentState()
		{
		}
		
		public function Setup( playerCount:uint ):void
		{
			m_playerCount = playerCount;
			m_selectingPlayer = 0;	
			m_competingPlayer = 0;
			
			m_eventIndex = 0;
			
			m_isPlayer = new Array;
			m_critterAssignment = new Array;			
			
			var i:uint;
			
			// Player indexes
			for ( i = 0; i < ff.A.Count(Settings.Critters); ++i )
			{
				m_isPlayer.push( i < playerCount );
			}
			
			// Scores
			m_allEventScores = new Object;
			m_currentEventRankings = [];
			m_cumulativeScores = [];
			m_cumulativeRankings = [];
			
			for ( i = 0; i < Settings.TournamentOrder.length; ++i )
			{
				var handle:String = Settings.TournamentOrder[ i ];
				m_allEventScores[ handle ] = new Object;
			}
		}
		
		public function IsCritterAssigned( c:String ):Boolean
		{
			return m_critterAssignment.indexOf( c ) >= 0;
		}
		
		public function GetPlayerCount():uint
		{
			return m_playerCount;
		}
		
		public function GetSelectingPlayer():uint
		{
			return m_selectingPlayer;
		}
		
		public function GetCompetingPlayer():uint
		{
			return m_competingPlayer;
		}
		
		public function GetCompetingCritter():String
		{
			return m_critterAssignment[ GetCompetingPlayer() ];
		}
		
		public function GetCompetingCritterData():Object
		{
			return Settings.Critters[ Game.Tournament.GetCompetingCritter() ];
		}
		
		public function GetEventHandle():String
		{
			return Settings.TournamentOrder[ m_eventIndex ];
		}
		
		public function GetEventDescriptor():Object
		{
			return Settings.Events[GetEventHandle()];
		}		
		
		public function GetEventTweakables():Object
		{
			var values:Object = new Object;
			var tweakables:Object = Settings.Events[GetEventHandle()]["tweakables"];
			
			for ( var key:String in tweakables )
			{
				values[ key ] = tweakables[key]["value"];	
			}
			
			return values;
		}
		
		public function AllPlayersAssigned():Boolean
		{
			return m_selectingPlayer == m_playerCount;
		}
		
		public function AllPlayersFinishedEvent():Boolean
		{
			return m_competingPlayer == m_playerCount;
		}
		
		public function AllEventsFinished():Boolean
		{
			return m_eventIndex == Settings.TournamentOrder.length;
		}
		
		public function SetPlayerFinishedCompeting( score:Number ):void
		{
			// Store results
			m_allEventScores[ GetEventHandle() ][ GetCompetingCritter() ] = score;
			
			//trace( GetEventHandle() + " completed by " + GetCompetingCritter() + ". Score: " + score );
			
			// Go to next player
			m_competingPlayer++;
			
			if ( AllPlayersFinishedEvent() )
			{
				ProcessEventScore();
			}
		}
		
		public function SetPostEventComplete():void
		{
			m_competingPlayer = 0;
			m_eventIndex++;
		}
		
		public function SetSelectingPlayerCritter( critter:String ):void
		{
			m_critterAssignment.push( critter );
			m_selectingPlayer++;
			
			// Auto-assign the remaining critters
			if ( AllPlayersAssigned() )
			{
				AutoassignCritters();
			}
		}
		
		public function GetCurrentEventRankings():Array
		{
			return m_currentEventRankings;
		}
		
		public function GetCumulativeRankings():Array
		{
			return m_cumulativeRankings;
		}
		
		private function AutoassignCritters():void
		{
			var unselected:Array = new Array;
			var c:String;
			
			for ( c in Settings.Critters )
			{
				if ( m_critterAssignment.indexOf(c) < 0 )
				{
					unselected.push( c );
				}
			}
			
			//!!!TODO - randomize order of unselected critters
			
			for each ( c in unselected ) 
			{
				m_critterAssignment.push( c );
			}
		}
		
		private function ProcessEventScore():void
		{
			// Determine who we need scores for
			var otherCritters:Array = [];
			
			for (var c:String in Settings.Critters)
			{
				if ( m_allEventScores[GetEventHandle()][c] == undefined )
				{
					otherCritters.push( c );
				}
			}
			
			// Generate scores
			SimulateScores( otherCritters );
			
			// Reorganize in sortable form
			RankScoresForCurrentEvent();
			
			// Update cumulative ranking
			UpdateCumulativeRank();
		}
		
		private function SimulateScores( critters:Array ):void
		{
			var bestTime:Number = GetEventDescriptor()["bestTime"];
			var worstTime:Number = GetEventDescriptor()["worstTime"];
			var max:Number = Math.max( bestTime, worstTime );
			var min:Number = Math.min( bestTime, worstTime );
			
			var range:Number = max - min;
			
			// 1/6th chance being in either top-third
				
			for each ( var c:String in critters )
			{
				var trial:Number = FP.random;

				var subMin:Number;
				var subMax:Number;

				if ( trial < Number(1)/6 )
				{
					// bottom third
					subMax = min + (range/3);
					subMin = min * .9;
				}
				else if ( trial < Number(1)/3 )
				{
					// top third
					subMax = 1.1 * max;
					subMin = max - (range/3);
				}
				else
				{
					subMax = (1.1) * (max - range/3);
					subMin = .9 * (min + range/3);
				}
				
				var subRange:Number = subMax - subMin;
				
				m_allEventScores[GetEventHandle()][ c ] = subMin + FP.random * subRange;
			}
		}
		
		private function RankScoresForCurrentEvent():void
		{
			m_currentEventRankings = [];
			var currentScores:Object = m_allEventScores[ GetEventHandle() ];
			
			for ( var c:String in currentScores )	
			{
				m_currentEventRankings.push( [c, currentScores[c]] );
			}
			
			var comparison:Function = GetEventDescriptor()["highScoreIsGood"] ? CompareHighIsGood : CompareHighIsBad;
			
			m_currentEventRankings.sort( comparison );
			
			// Push results into cumulative scores			
			for ( var i:uint = 0; i < m_currentEventRankings.length; ++i )
			{
				var critter:String = m_currentEventRankings[i][0];
				var points:uint = Settings.RankingPoints[i];
				
				if ( m_cumulativeScores[critter] == undefined )
				{
					m_cumulativeScores[ critter ] = points;	
				}
				else
				{
					m_cumulativeScores[ critter ] += points;
				}
				
				// Append cumulative points to the current event rankings...useful to have there
				( m_currentEventRankings[i] as Array ).push( m_cumulativeScores[critter] );
				
				// Turn event score into human-readable format
				m_currentEventRankings[i][1] = ff.U.SecondsToHHMMXX( m_currentEventRankings[i][1] );
			}
		}
		
		private function UpdateCumulativeRank():void
		{
			m_cumulativeRankings = [];
			
			for ( var c:String in m_cumulativeScores )	
			{
				m_cumulativeRankings.push( [c, m_cumulativeScores[c]] );
			}
			
			m_cumulativeRankings.sort( CompareHighIsGood );
		}
		
		private function CompareHighIsGood( a:Array, b:Array ):int
		{
			if ( a[1] == b[1] )
			{
				return 0;
			}
			else
			{
				return a[1] > b[1] ? -1 : 1;
			}			
		}
		
		private function CompareHighIsBad( a:Array, b:Array ):int
		{
			if ( a[1] == b[1] )
			{
				return 0;
			}
			else
			{
				return a[1] > b[1] ? 1 : -1;
			}			
		}		
		
		private var m_playerCount:uint;
		private var m_selectingPlayer:uint;
		private var m_competingPlayer:uint;
		
		private var m_eventIndex:uint;
		
		private var m_critterAssignment:Array;
		private var m_isPlayer:Array;
		
		private var m_allEventScores:Object;
		private var m_currentEventRankings:Array;
		private var m_cumulativeScores:Array;
		private var m_cumulativeRankings:Array;
	}
}