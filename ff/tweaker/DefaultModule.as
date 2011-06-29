package ff.tweaker
{
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.KeyboardEvent;

	public class DefaultModule
	{
		public function DefaultModule( stage:Stage )
		{			
			m_root = new Root;
			m_controller = new Controller( m_root );
			m_renderer = new Renderer;
			
			stage.addEventListener( KeyboardEvent.KEY_DOWN, OnKeyDown );
			stage.addChild( m_renderer.GetDisplayObject() );
			
			SetActive( false );			
		}
		
		public function GetDisplayObject():DisplayObject
		{
			return m_renderer.GetDisplayObject();
		}
		
		public function Add( path:String, item:Item ):void
		{
			m_root.Add( path, item );
			m_controller.CheckCurrent();
			m_renderer.Render( m_root );
		}

		public function OnKeyDown( e:KeyboardEvent ):void
		{
			if ( ! m_active )
			{
				return;
			}
			
			var action:uint = InputActions.NONE;

			switch ( e.keyCode )
			{
			case 8: action = InputActions.BACKCLICK; break; // backspace
			case 13: action = InputActions.CLICK; break; // enter
			case 32: action = InputActions.CLICK; break; // space
			case 37: action = e.shiftKey ? InputActions.ALT_LEFT : InputActions.LEFT; break;
			case 38: action = e.shiftKey ? InputActions.ALT_UP : InputActions.UP; break;
			case 39: action = e.shiftKey ? InputActions.ALT_RIGHT : InputActions.RIGHT; break;
			case 40: action = e.shiftKey ? InputActions.ALT_DOWN : InputActions.DOWN; break;
			}
			
			if ( action != InputActions.NONE )
			{
				m_controller.OnAction( action );
				m_renderer.Render( m_root );	
			}			
		}
		
		public function IsActive():Boolean
		{
			return m_active;
		}
		
		public function SetActive( active:Boolean = true ):void
		{
			m_active = active;
			m_renderer.GetDisplayObject().visible = m_active;
		}
		
		private var m_root:Root;
		private var m_controller:Controller;
		private var m_renderer:Renderer;
		private var m_active:Boolean;
	}
}