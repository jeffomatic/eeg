package events.hurdles
{
	import ff.FPUtil;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;
	
	public class Trap extends Entity
	{
		public function Trap( x:Number=0, y:Number=0)
		{		
			// Create spritemap
			var frameWidth:Number = 90;
			var frameHeight:Number = 90;
			
			m_spritemap = new Spritemap( imgTrap, frameWidth, frameHeight );
			m_spritemap.add( "normal", [0] );
			m_spritemap.add( "hit", [1] );
			
			// mask
			var masks:Array = ff.FPUtil.GetPixelmasks( m_spritemap, frameWidth, frameHeight );
			
			// reset sprite map
			m_spritemap.play( "normal" );
			
			super( x, y, m_spritemap, masks[0] );
		}
		
		override public function update():void
		{
			super.update();
			
			if ( ! m_hit )
			{
				var hurdler:Hurdler = Hurdler( collide("hurdler", x, y) );
				
				if ( hurdler )
				{
					hurdler.HitTrap( this );
					m_spritemap.play( "hit" );
					m_hit = true;
				}
			}
		}
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		private var m_spritemap:Spritemap;
		private var m_hit:Boolean;
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		[Embed(source="../../../assets/props/beartrap.png")]
		private static const imgTrap:Class;
	}
}