package cutscenes 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class CutsceneGreg extends Entity
	{
		[Embed(source = 'assets/cutscenes/greg.png')]
		private const GREG : Class;
		
		public var spriteGreg:Spritemap = new Spritemap(GREG, 442, 387);
		public var curExpression : String = "default";
		
		public function CutsceneGreg()
		{
			
			spriteGreg.add("default", [0,3,1,3,2,0,1,3,2,1,0,1,0,1,3,0,2,3,1,0,1,2,1,0,3,1,2], 8, true);
			spriteGreg.add("shocked", [4,6,7,6,5,4,7,4,6,4,5,7,6,4,5,7,4,6,4,7,5,4,6,7,5,7,6,4,7,5,6,4,4,7,4,6,7,5], 8, true);
			spriteGreg.add("cynical", [8,9,10,8,9,8,11,10,9,8,10,8,10,11,9,11,10,8,9,10,8,10,9,11,10,8,10,9,10,8,10,11], 8, true);
			spriteGreg.add("paused_default", [2], 8, false);
			spriteGreg.add("paused_shocked", [6], 8, false);
			spriteGreg.add("paused_cynical", [9], 8, false);
			
			graphic = spriteGreg;
			super(0, 63, spriteGreg);

		}

		public function say(sound : Sfx, expression : String) : void
		{
			spriteGreg.play(expression);
			sound.play();
			curExpression = expression;
		}
		
		public function shutup() : void
		{
			var silence : String = "paused_"+curExpression;
			spriteGreg.play(silence);
			
		}
		
		public function setFace(expression : String) : void
		{
			if (expression)
			{
			spriteGreg.play("paused_"+expression);
			}
		}
		
	}
}