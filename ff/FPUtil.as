package ff
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.masks.Pixelmask;

	public class FPUtil
	{
		public static function GetFrameData( s:Spritemap, frameWidth:uint, frameHeight:uint ):Array
		{
			var frames:Array = [];
			
			for ( var i:uint = 0; i < s.rows; ++i )
			{
				for ( var j:uint = 0; j < s.columns; ++j )
				{	
					s.setFrame( j, i );
					
					var b:BitmapData = new BitmapData( frameWidth, frameHeight, true, 0x00000000 );
					s.render( b, new Point, new Point );
					
					frames.push( b );
				}				
			}
			
			return frames;
		}
		
		public static function GetPixelmasks( s:Spritemap, frameWidth:uint, frameHeight:uint ):Array
		{
			var frameData:Array = GetFrameData( s, frameWidth, frameHeight );
			var pixelMasks:Array = [];
			
			for each ( var bitmap:BitmapData in frameData )
			{
				pixelMasks.push( new Pixelmask(bitmap) );
			}
			
			return pixelMasks;
		}
	}
}