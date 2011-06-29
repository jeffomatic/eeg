package cutscenes
{
	public class CutsceneGrabbag extends CutsceneTalkingHeads
	{
		
		private static const CutsceneScriptList : Array = 
			[	CutsceneScript.Scene1, 
				CutsceneScript.Scene2,
				CutsceneScript.Scene3,
				CutsceneScript.Scene4,
				CutsceneScript.Scene5,
				CutsceneScript.Scene6,
				CutsceneScript.Scene7,
				CutsceneScript.Scene8,
				CutsceneScript.Scene9,
				CutsceneScript.Scene10,
				CutsceneScript.Scene11,
				CutsceneScript.Scene12,
				CutsceneScript.Scene13,
				CutsceneScript.Scene14,
				CutsceneScript.Scene15,
				CutsceneScript.Scene16,
				CutsceneScript.Scene17,
				CutsceneScript.Scene18,
				CutsceneScript.Scene19,
				CutsceneScript.Scene20,
			];
		private static var RemainingScriptList : Array = [];
		private static function GetRandomScript() : Array
		{
			if (RemainingScriptList.length == 0)
			{
				for each (var s:Object in CutsceneScriptList)
				{
					RemainingScriptList.push (s);
				}
				
			}
				var n : uint = Math.random() * RemainingScriptList.length;
				
				var SelectedScript : Array = RemainingScriptList[n];
				
				var TempArray : Array = [];
				
				for (var i : uint; i < RemainingScriptList.length; ++i)
				{
					if ( i == n )
						continue;
					
					TempArray.push(RemainingScriptList[i]);
				
				}
				
				RemainingScriptList = TempArray;
				
				return SelectedScript;
				
			
		}
		
		
		public function CutsceneGrabbag()
		{
			super();
			GetRandomScript();
			InitializeCutscene(GetRandomScript(), uint((Math.random() * 8) + 1));
		}
	}
}