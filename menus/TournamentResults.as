package menus
{
	public class TournamentResults extends ResultsMenu
	{
		public function TournamentResults()
		{
			super(
				Game.Tournament.GetCumulativeRankings(),
				imgTournamentResults
			);
		}
		
		[Embed(source="../../assets/UI/6_finalresults.png")]
		private var imgTournamentResults:Class;
	}
}