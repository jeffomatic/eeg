package cutscenes
{
	public class EndCutscene extends CutsceneTalkingHeads
	{
		public function EndCutscene()
		{
			super();
			InitializeCutscene(CutsceneScript.SceneE, uint((Math.random() * 8) + 1));
		}
	}
}