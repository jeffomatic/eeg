package events.maze
{
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class MazePickup extends Entity
	{
		public function MazePickup( x:Number=0, y:Number=0 )
		{
			super(x, y, new Image(imgTreasure), new Pixelmask(imgTreasure) );
			
			// assume centered coordinates
			x -= halfWidth;
			y -= halfHeight;
		}
		
		override public function update():void
		{
			if ( collide("mazePlayer", x, y) )
			{
				MazeWorld(world).OnTreasureCollected();
				world.remove( this );
			}
		}
		
		[Embed(source="../../../assets/props/treasure.png")]
		private static const imgTreasure:Class;
	}
}