package ff.tweaker
{
	public class Bool extends Item
	{
		public function Bool( options:Object )
		{
			var setup:Array = [
				[ "m_object", "object", Object, null ],
				[ "m_property", "property", String, null ],
				[ "m_changeCallback", "changeCallback", Function, null ],
				[ "m_textCallback", "textCallback", Function, null ],
				[ "m_wrap", "wrap", Boolean, true ],
			];
			
			for each ( var s:Array in setup )
			{
				var member:String = s[0];
				var option:String = s[1];
				var type:Class = s[2];
				var defaultValue:* = s[3];
				
				if ( options[option] is type )
				{
					this[member] = options[option];
				}
				else
				{
					this[member] = defaultValue;
				}
			}
			
			m_tweakable = true;
		}
		
		override public function ValueText():String
		{
			if ( m_object[m_property] != undefined )
			{
				if ( m_textCallback != null )
				{
					return m_textCallback( m_object[m_property] );
				}
				
				return String( m_object[m_property] );
			}
			
			return super.ValueText();
		}
		
		override public function OnAction( action:uint ):void
		{
			if ( m_object[m_property] == undefined )
			{			
				return;
			}
			
			var current:Boolean = m_object[m_property];
			
			switch ( action )
			{
			case InputActions.UP:
			case InputActions.RIGHT:
			case InputActions.ALT_UP:
			case InputActions.ALT_RIGHT:
				if ( m_wrap )
				{
					ChangeValue( ! current );
				}
				else
				{
					ChangeValue( true );
				}
				break;
				
			case InputActions.DOWN:
			case InputActions.LEFT:				
			case InputActions.ALT_DOWN:
			case InputActions.ALT_LEFT:
				if ( m_wrap )
				{
					ChangeValue( ! current );
				}
				else
				{
					ChangeValue( false );
				}
				break;
			
			}
		}
		
		private function ChangeValue( b:Boolean ):void
		{
			if ( m_object[m_property] == b )
			{
				return;
			}

			m_object[m_property] = b;
			
			if ( m_changeCallback != null )
			{
				m_changeCallback( m_object[m_property] );
			}
		}
		
		private var m_object:Object;
		private var m_property:String;
		private var m_changeCallback:Function;
		private var m_textCallback:Function;
		private var m_wrap:Boolean;
	}
}