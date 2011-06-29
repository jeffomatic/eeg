package
{
	import ff.Fonts;
	
	import flash.display.Stage;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public final class DebugTextManager
	{
		public function DebugTextManager( stage:flash.display.Stage )
		{
			m_stage = stage;
			m_text = new Array;
		}
		
		public function Add( text:String, x:Number, y:Number ):flash.text.TextField
		{
			var debugFormat:TextFormat = new TextFormat;
			debugFormat.font = ff.Fonts.CousineRegular.fontName;
			debugFormat.align = "center";
			debugFormat.color = 0xEE00EE;				
			
			var t:TextField = new TextField;
			
			t.text = text;
			t.defaultTextFormat = debugFormat;
			t.embedFonts = true;
			t.visible = false;
			t.autoSize = "left";
			t.x = x;
			t.y = y;
			
			m_text.push( t );
			m_stage.addChild( t );
			
			return t;
		}
		
		public function Remove( toRemove:TextField ):void
		{
			var newText:Array = new Array;
			
			for each ( var t:TextField in m_text )
			{
				if ( t == toRemove )
				{
					// Found! Remove it from the display list
					m_stage.removeChild( toRemove );
				}
				else
				{
					newText.push( t );
				}
			}
			
			m_text = newText;
		}
		
		public function SetVisible( enable:Boolean ):void
		{
			// Set all text to visible
			for each ( var t:TextField in m_text )
			{
				t.visible = enable;
			}
		}
		
		public function Update():void
		{
			// refresh draw order
			for each ( var t:TextField in m_text )
			{
				m_stage.removeChild( t );
				m_stage.addChild( t );
			}			
		}
		
		private var m_stage:Stage;
		private var m_text:Array;
	}
}