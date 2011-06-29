package cutscenes 
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class CutsceneBob extends Entity
	{
		[Embed(source = 'assets/cutscenes/bob.png')]
		private const BOB : Class;
		
		public var spriteBob:Spritemap = new Spritemap(BOB, 442, 387);
		public var curExpression : String = "default";
		
		public function CutsceneBob()
		{
			
			spriteBob.add("default", [0,3,1,3,2,0,1,3,2,1,0,1,0,1,3,0,2,3,1,0,1,2,1,0,3,1,2], 8, true);
			spriteBob.add("shocked", [4,6,7,6,5,4,7,4,6,4,5,7,6,4,5,7,4,6,4,7,5,4,6,7,5,7,6,4,7,5,6,4,4,7,4,6,7,5], 8, true);
			spriteBob.add("cynical", [8,9,10,8,9,8,11,10,9,8,10,8,10,11,9,11,10,8,9,10,8,10,9,11,10,8,10,9,10,8,10,11], 8, true);
			spriteBob.add("paused_default", [3], 8, false);
			spriteBob.add("paused_shocked", [4], 8, false);
			spriteBob.add("paused_cynical", [9], 8, false);
			
			graphic = spriteBob;
			super(400, 63, spriteBob);
			
		}
	
		public function say(sound : Sfx, expression : String) : void
		{
			spriteBob.play(expression);
			sound.play();
			curExpression = expression;
			
		}
		
		public function shutup() : void
		{
			var silence : String = "paused_"+curExpression;
			spriteBob.play(silence);
			
		}
		
		public function setFace(expression : String) : void
		{
			if (expression)
			{
				spriteBob.play("paused_"+expression);
			}
		}
		
	}
}