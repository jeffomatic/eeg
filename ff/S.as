package ff
{
	/**
	 * String utilities
	 */
	public final class S
	{
		public static function Split( s : String, delim : String ):Vector.<String>
		{
			var tokens:Vector.<String> = new Vector.<String>;
			
			if ( delim == "" )
			{
				tokens.push( s );
				return tokens;
			}
			
			while ( s != "" )
			{
				var n:int = s.indexOf( delim );
				
				if ( n < 0 )
				{
					tokens.push( s );
					s = ""
				}
				else if ( n == 0 )
				{
					// Prefix delimeter
					s = s.substr( 0, delim.length );
				}
				else
				{
					tokens.push( s.substr(0, n) ) ;
					s = s.substring( n + delim.length );					
				}			
			}
			
			return tokens;
		}
	}
}