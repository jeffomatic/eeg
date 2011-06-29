package ff.tweaker
{
	public class Integer extends Item
	{
		public function Integer( options:Object )
		{
			var setup:Array = [
				[ "m_object", "object", Object, null ],
				[ "m_property", "property", String, null ],
				[ "m_changeCallback", "changeCallback", Function, null ],
				[ "m_textCallback", "textCallback", Function, null ],
				[ "m_min", "min", int, int.MIN_VALUE ],
				[ "m_max", "max", int, int.MAX_VALUE ],
				[ "m_step", "step", int, 1 ],
				[ "m_altStep", "altStep", int, 5 ],
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
			switch ( action )
			{
			case InputActions.UP:
			case InputActions.RIGHT:
				ChangeValue( m_step );
				break;
			
			case InputActions.DOWN:
			case InputActions.LEFT:
				ChangeValue( - m_step );
				break;
			
			case InputActions.ALT_UP:
			case InputActions.ALT_RIGHT:
				ChangeValue( m_altStep );
				break;
			
			case InputActions.ALT_DOWN:
			case InputActions.ALT_LEFT:
				ChangeValue( - m_altStep );
				break;			
			}
		}
		
		private function ChangeValue( d:int ):void
		{
			if ( m_object[m_property] != undefined )
			{
				var value:int = m_object[m_property];
				
				value += d;
				
				if ( value > m_max )
				{
					if ( m_wrap )
					{
						value = m_min + (value - m_max);
					}
					else
					{
						value = m_max;
					}
				}
				else if ( value < m_min )
				{
					if ( m_wrap )
					{
						value = m_max + (value - m_min);
					}
					else
					{
						value = m_min;
					}
				}
				
				m_object[m_property] = value;
				
				if ( m_changeCallback != null )
				{
					m_changeCallback( m_object[m_property] );
				}
			}
		}
		
		private var m_object:Object;
		private var m_property:String;
		private var m_changeCallback:Function;
		private var m_textCallback:Function;
		private var m_min:int;
		private var m_max:int;
		private var m_step:int;
		private var m_altStep:int;
		private var m_wrap:Boolean;
	}
}