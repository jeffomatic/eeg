package menus
{
	public class EventResults extends ResultsMenu
	{
		public function EventResults()
		{
			super(
				Game.Tournament.GetCurrentEventRankings(),
				imgEventResults
			);
		}
		
		[Embed(source="../../assets/UI/5_matchresults.png")]
		private var imgEventResults:Class;
	}
}