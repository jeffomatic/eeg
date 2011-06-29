package test
{
	import ff.tweaker.Real;
	
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	public class SquareEntity extends Entity
	{
		public static var Tweakables:Object = {
			speed:50	
		};
		
		public static var addedTweak:Boolean = false;
		
		public function SquareEntity()
		{
			var canvas:Canvas = new Canvas( 10, 10 );
			canvas.fill( new Rectangle(0, 0, canvas.width, canvas.height), 0xFF00FF );
			
			super( Settings.appX / 2, Settings.appY / 2, canvas );
			
			if ( ! addedTweak )
			{
				Game.Tweaker.Add(
					"Entities/SquareEntity/Speed",
					new ff.tweaker.Real({
						object:Tweakables,
						property:"speed",
						min:0,
						max:100
					}) );
			}
		}
		
		override public function update():void
		{
			var d:Number = Tweakables["speed"] * FP.elapsed;
			
			if ( Input.check(Key.RIGHT) )
			{
				x += d;
			}
			else if ( Input.check(Key.LEFT) )
			{
				x -= d;
			}
			
			if ( Input.check(Key.DOWN) )
			{
				y += d;
			}
			else if ( Input.check(Key.UP) )
			{
				y -= d;
			}
		}
	}
}