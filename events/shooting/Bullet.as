package events.shooting
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.masks.Pixelmask;
	
	public class Bullet extends Entity
	{
		public function Bullet(x:Number=0, y:Number=0, angle:Number = 0)
		{
			var mask:Pixelmask = new Pixelmask( imgBullet );
			super( x, y, new Image(imgBullet), mask );
			
			
			m_velScaleX = Math.cos( angle );
			m_velScaleY = Math.sin( angle );
		}
		
		override public function update():void
		{		
			var speed:Number = Game.Tournament.GetEventTweakables()["bulletSpeed"];
			
			var velX:Number = m_velScaleX * speed;
			var velY:Number = m_velScaleY * speed;
			
			x += velX * FP.elapsed;
			y += velY * FP.elapsed;
			
			var dodger:Dodger = Dodger( collide("dodger", x, y) );
			
			if ( dodger )
			{
				dodger.OnHit();
			}
			
			if ( dodger
			  || x < -10 || Settings.appX + 10 < x
			  || y < -10 || Settings.appY + 10 < y )
			{
				world.remove( this );
				return;
			}	
		}
		
		private var m_velScaleX:Number;
		private var m_velScaleY:Number;
		
		[Embed(source="../../../assets/props/bullet.png")]
		private static const imgBullet:Class;
	}
}