package ff
{
	public final class A
	{
		public static function Count( array:Object ):uint
		{
			if ( array is Array )
			{
				return (array as Array).length;
			}
			else
			{
				var i:uint = 0;
				
				for each ( var o:* in array )
				{
					++i;
				}
				
				return i;
			}
		}
	}
}