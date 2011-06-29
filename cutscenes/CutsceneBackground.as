package cutscenes 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	
	public class CutsceneBackground extends Entity
	{
		[Embed(source = 'assets/cutscenes/cutscene_background.png')]
		private const CUTSCENESTUDIO:Class;
		
		public function CutsceneBackground(x:Number=0, y:Number=0, graphic:Graphic=null, mask:Mask=null)
		{
			graphic = new Image(CUTSCENESTUDIO);
			super(x, y, graphic, mask);
		}
	}
}