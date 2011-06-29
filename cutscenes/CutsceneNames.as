package cutscenes 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	
	
	public class CutsceneNames extends Entity
	{
		[Embed(source = 'assets/cutscenes/cutscene_names_01.png')]
		private const CUTSCENENAMES1:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_02.png')]
		private const CUTSCENENAMES2:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_03.png')]
		private const CUTSCENENAMES3:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_04.png')]
		private const CUTSCENENAMES4:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_05.png')]
		private const CUTSCENENAMES5:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_06.png')]
		private const CUTSCENENAMES6:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_07.png')]
		private const CUTSCENENAMES7:Class;
		
		[Embed(source = 'assets/cutscenes/cutscene_names_08.png')]
		private const CUTSCENENAMES8:Class;
		
		public function CutsceneNames(x:Number=0, y:Number=350, graphic:Graphic=null, mask:Mask=null)
		{
			//graphic = new Image(CUTSCENENAMES1);
			//flyIn(2);
			super(x, y, graphic, mask);
			//flyIn(4);
		}
		
		public function flyIn(namesImage : Number) : void
		{
			switch(namesImage)
			{
				case 1:
					graphic = new Image(CUTSCENENAMES1);
					break;
				case 2:
					graphic = new Image(CUTSCENENAMES2);
					break;
				case 3:
					graphic = new Image(CUTSCENENAMES3);
					break;
				case 4:
					graphic = new Image(CUTSCENENAMES4);
					break;
				case 5:
					graphic = new Image(CUTSCENENAMES5);
					break;
				case 6:
					graphic = new Image(CUTSCENENAMES6);
					break;
				case 7:
					graphic = new Image(CUTSCENENAMES7);
					break;
				case 8:
					graphic = new Image(CUTSCENENAMES8);
					break;
	
			}
		
			var startPosition : Number = -700;
			x = startPosition;
		}
		
		override public function update():void
		{
			if (x < 0)
			{
				x+= 80;
			}
			
		}
		
		
	}
}