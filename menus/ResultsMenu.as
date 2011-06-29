package menus
{
	import ff.tweaker.Unsigned;
	
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class ResultsMenu extends BaseMenu
	{
		public function ResultsMenu( rankings:Array, bgImage:Class, critterNameField:int = 0 )
		{
			super();
			
			// Create graphics list
			var list:Graphiclist = new Graphiclist;
			
			// Add bg image
			list.add( new Image(bgImage) );
			
			// Text
			m_cols = [];
			m_rows = [];
			
			var rowCount:uint = rankings.length;
			
			Text.font = "lektonbold";
			Text.size = 20;

			for ( var i:uint = 0; i < rowCount; ++i )
			{
				m_rows.push( new Array );
				
				if ( i == 0 )
				{
					m_cols.push( new Array );
				}
				
				// Index
				var index:Text = new Text( String(i + 1) );
				m_cols[0].push( index );
				m_rows[i].push( index );
				list.add( index );
				
				// Data fields
				for ( var j:uint = 0; j < (rankings[0] as Array).length; ++j )
				{
					if ( i == 0 )
					{
						m_cols.push( new Array );
					}
					
					var fieldText:String = rankings[i][j];
					
					// Filter critter handle to get actual label
					if ( critterNameField >= 0 && critterNameField == j )
					{
						fieldText = Settings.Critters[ fieldText ]["label"];
					}
					
					var field:Text = new Text( fieldText );
					m_cols[ j + 1 ].push( field );
					m_rows[i].push( field );
					list.add( field );
					

				}
			}
			
			SynchTextToLayout();
			
			// Attach everything to an entity
			add( new Entity(0, 0, list) );
			
			// tweaker
			if ( ! s_tweaked )
			{
				SetupTweaks();
			}
		}
		
		override public function update():void
		{
			super.update();
			SynchTextToLayout();
			
			if ( Input.pressed(Key.ENTER) )
			{
				Game.Flow.GamestateFinished();
			}
		}
		
		private function SynchTextToLayout():void
		{		
			for ( var i:uint = 0; i < m_rows.length; ++i )
			{
				for each ( var rowItem:Text in m_rows[i] )
				{
					rowItem.y = s_layoutRows[ s_rowKeys[i] ];
				}
			}
			
			var layoutCols:Object = ( m_cols.length == 3 )
				? s_layoutThreeCols
				: s_layoutFourCols;			
			
			for ( var j:uint = 0; j < m_cols.length; ++j )
			{
				for each ( var colItem:Text in m_cols[j] )
				{
					colItem.x = layoutCols[ s_colKeys[j] ];
				}
			}
		}
		
		private static function SetupTweaks():void
		{
			s_tweaked = true;
			
			var i:uint;
			var path:String = "Results/";
			
			// Rows
			var pathRows:String = path + "Rows/";
			
			for ( i = 0; i < s_rowKeys.length; ++i )
			{
				Game.Tweaker.Add(
					pathRows + i,
					new Unsigned({
						object: s_layoutRows,
						property: s_rowKeys[i]
					}) );
			}
			
			// 3-cols
			var pathThreeCols:String = path + "3-column/";
			
			for ( i = 0; i < 3; ++i )
			{
				Game.Tweaker.Add(
					pathThreeCols + i,
					new Unsigned({
						object: s_layoutThreeCols,
						property: s_colKeys[i]
					}) );
			}
			
			// 4-cols
			var pathFourCols:String = path + "4-column/";
			
			for ( i = 0; i < 4; ++i )
			{
				Game.Tweaker.Add(
					pathFourCols + i,
					new Unsigned({
						object: s_layoutFourCols,
						property: s_colKeys[i]
					}) );
			}									
		}
		
		private var m_cols:Array;
		private var m_rows:Array;
		
		private static var s_tweaked:Boolean = false;
	
		public static const s_rowKeys:Array = ["a", "b", "c", "d", "e", "f"];
		public static const s_colKeys:Array = ["a", "b", "c", "d"];
		
		public static var s_layoutRows:Object = { a: 173, b: 212, c: 254, d: 294, e: 337, f: 377 };
		public static var s_layoutThreeCols:Object = { a: 57, b: 235, c: 487 };
		public static var s_layoutFourCols:Object = { a: 57, b: 182, c: 347, d: 503 };
	}
}