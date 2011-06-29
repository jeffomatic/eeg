package ff.tweaker
{
	import ff.S;
	
	public class Root extends Item
	{
		public function Root()
		{
		}
		
		public function Add( path : String, item : Item ):void
		{
			// Tokenize the path
			var pathTokens:Vector.<String> = ff.S.Split( path, "/" );
			var current:Item = this;

			// Seek through existing sections of the path
			for (;;)
			{
				var label:String = pathTokens[ 0 ];
				var c:Item = current.GetChild( label );
				
				if ( c )
				{
					current = c;
					pathTokens.shift();
				}
				else
				{
					break;
				}
			}
			
			// Make sure we haven't exhausted the entire given path
			if ( ! pathTokens.length )
			{
				throw new Error( "Bad path for Tweaker item: " + path );
			}
			
			// Construct remaining path 
			while ( pathTokens.length > 1 )
			{
				var folder:Folder = new Folder();
				folder.SetLabel( pathTokens.shift() );
				
				current.AddChild( folder );
				current = folder;
			}
			
			// Last path token is the label of the added item
			item.SetLabel( pathTokens.shift() );
			current.AddChild( item );
		}
	}
}