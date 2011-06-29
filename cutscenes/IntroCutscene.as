package cutscenes
{
	public class IntroCutscene extends CutsceneTalkingHeads
	{
		public function IntroCutscene()
		{
			super();
			InitializeCutscene(CutsceneScript.SceneB, uint((Math.random() * 8) + 1));
		}
	}
}