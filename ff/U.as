package ff
{
	public final class U
	{
		public static function SecondsToHHMMXX( time:Number ):String
		{
			var minutes:uint = time / 60;
			var seconds:uint = time - 60 * minutes;
			var decimal:Number = time - Number( uint(time) );
			var cs:uint = uint(decimal * 100);
			
			return (minutes > 9 ? minutes : "0" + minutes)
				+ ":"
				+ (seconds > 9 ? seconds : "0" + seconds)
				+ ":"
				+ (cs > 9 ? cs : "0" + cs);
		}
	}
}