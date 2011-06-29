package ff.tweaker
{
	import ff.Fonts;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.AntiAliasType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class Renderer
	{
		public function Renderer( minWidth:uint = 250, minHeight:uint = 30 )
		{
			// Set min width to prevent weird auto-sizing issues
			m_minWidth = minWidth;
			m_minHeight = minHeight;
			
			// Main display object
			m_display = new Sprite;
			
			// Background
			m_bg = new Shape;
			m_display.addChild( m_bg );
			
			// Text
			var format:TextFormat = new TextFormat;
			format.color = 0x00EE33;
			format.font = ff.Fonts.CousineRegular.fontName;
			format.size = 13;
			format.leading = 0;
			
			m_text = new TextField;
			m_display.addChild( m_text );
			
			m_text.multiline = true;
			m_text.autoSize = "left";
			m_text.defaultTextFormat = format;
			m_text.embedFonts = true;
			m_text.antiAliasType = flash.text.AntiAliasType.ADVANCED;
		}
		
		public function Render( root:Root ):void
		{
			m_text.htmlText = RenderItem( root );

			m_bg.graphics.clear();
			m_bg.graphics.beginFill( 0, .5 );
			m_bg.graphics.drawRect(
				0, 0,
				Math.max(m_minWidth, m_text.width),
				Math.max(m_minHeight, m_text.height) );
			m_bg.graphics.endFill();			
		}
		
		public function RenderItem( root:Item, indent:String = "" ):String
		{
			var normalPad:String = "  ";
			var tweakPad:String = "> ";
			
			var s:String = "";
			
			for each ( var i:Item in root.Children() )
			{
				var itemText:String = indent;
				
				var label:String = i.Label();
				
				if ( i.IsSelected() )
				{
					label = "<b>" + label + "</b>";
				}				
				
				if ( i is Folder )
				{
					itemText += normalPad
						+ ( Folder(i).IsOpen() ? "- " : "+ " )
						+ label
						+ "/";
				}
				else if ( i is Callback )
				{
					itemText += normalPad + label + "<b>*</b>";
				}
				else if ( i.IsTweakable() )
				{
					itemText += i.IsTweaking() ? tweakPad : normalPad;
					itemText += label + ": ";
					
					var value:String = i.ValueText();
					
					if ( i.IsTweaking() )
					{
						value = "<b>" + value + "</b>";
					}
					
					itemText += value;
				}
				
				if ( i.IsSelected() )
				{
					itemText = "<font color='#00EECC'>" + itemText + "</font>";
				}
				
				s += itemText + "\n";
				
				if ( i is Folder && Folder(i).IsOpen() && i.Children().length > 0 )
				{
					s += RenderItem( i, indent + normalPad );
				}
			}
			
			return s;
		}
		
		public function GetDisplayObject():DisplayObject
		{
			return m_display;
		}	
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		private var m_text:TextField;
		private var m_bg:Shape;
		private var m_display:Sprite;
		private var m_minWidth:uint;
		private var m_minHeight:uint;		
	}
}