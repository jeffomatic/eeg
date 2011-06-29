package events.shooting
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	
	public class Splosion extends Entity
	{
		public function Splosion(x:Number=0, y:Number=0)
		{
			var spritemap:Spritemap = new Spritemap(imgSplosion, 10, 10, OnSploded);
			spritemap.add( "splode", [0, 1, 2, 3, 4, 5], 18 );
			spritemap.play( "splode" );
			
			super(x, y, spritemap);
		}
		
		private function OnSploded():void
		{
			world.remove( this );
		}
		
		[Embed(source="../../../assets/props/bullet_explosionFX.png")]
		private static const imgSplosion:Class;
	}
}