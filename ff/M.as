package ff
{
	/**
	 * Basic math utilities
	 */
	public class M
	{
		public static var epsilon : Number;
		
		public static function between( x : Number, a : Number, b : Number ) : Boolean
		{
			var min : Number, max : Number;
			
			if ( a > b )
			{
				min = b;
				max = a;
			}
			else
			{
				min = a;
				max = b;
			}
			
			return min <= x && x <= max;
		}
		
		public static function clamp( x : Number, min : Number, max : Number ) : Number
		{
			if ( x < min ) return min;
			if ( x > max ) return max;
			return x;
		}
		
		public static function sign( x : Number ) : Number
		{
			return x >= 0 ? 1 : -1;
		}
	}
}