package
{
	import ff.Fonts;
	import ff.tweaker.Bool;
	import ff.tweaker.DefaultModule;
	import ff.tweaker.Real;
	
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	
	import test.TestWorld;

	[SWF(width="800", height="450")]
	
	public class Game extends Engine
	{	
		// CHANGE THIS TO TRUE TO ENABLE THE TEST WORLD
		public static const TEST:Boolean = false;
		public static const FPDEBUG:Boolean = false;
		public static const TWEAKS:Boolean = false;
		
		// CHANGE THIS TO ENABLE DEBUG OUTPUT
		public static const Tweakables:Object = {
			debug:false
		};
		
		public function Game()
		{
			super( Settings.appX, Settings.appY );
			
			// seed the random number generator
			FP.randomSeed = (new Date()).getTime() + flash.utils.getTimer();
			
			// Create tweaker
			if ( ! Tweaker )
			{
				InitTweaker();
			}
			
			// Create gameflow
			if ( ! Flow )
			{
				Flow = new Gameflow;
			}
			
			// Create tournament state
			if ( ! Tournament )
			{
				Tournament = new TournamentState;
			}
			
			if ( TEST )
			{
				FP.world = new test.TestWorld;
			}
			else
			{
				Flow.NextState();
			}
			
			// Create a title track
			
			if ( ! Music )
			{
				Music = new TitleMusic;
			}
			
			// Create some debug text
			if ( ! DebugText )
			{
				InitDebugText();
				
				if ( FPDEBUG )
				{
					FP.console.enable();
				}
			}
			
			if ( ! Fader )
			{
				Fader = new ScreenFader( stage );
			}
		}
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		override public function update():void
		{
			Flow.Update( FP.elapsed );
			super.update();
			UpdateDebugText();
			Fader.Update( FP.elapsed );
		}
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		private function InitTweaker():void
		{
			Tweaker = new ff.tweaker.DefaultModule( stage );
			
			// Install tweaker event handler
			stage.addEventListener( KeyboardEvent.KEY_DOWN, OnKeyDown );	
			
			// Install default tweaks
			Tweaker.Add(
				"Debug/Show debug text",
				new ff.tweaker.Bool({
					object:Tweakables,
					property:"debug"
				})
			);	
			
			Tweaker.Add(
				"Timer/X",
				new ff.tweaker.Unsigned({
					object:Settings.timer,
					property:"x"
				})
			);
			
			Tweaker.Add(
				"Timer/Y",
				new ff.tweaker.Unsigned({
					object:Settings.timer,
					property:"y"
				})
			);				
			
			// Add event tweakables
			for ( var eventHandle:String in Settings.Events )
			{
				var event:Object = Settings.Events[eventHandle];
				var label:String = "Events/" + event["label"];
				var tweakables:Object = event["tweakables"];
				
				// forward declarations
				var property:String;
				var itemLabel:String;
				var options:Object;
				
				// Event-wide properties
				for ( property in tweakables )
				{
					itemLabel = label + "/" + property;
					
					// Create options
					options = {
						object: tweakables[property],
						property: "value"
					};
					
					for ( var o:String in tweakables[property]["options"] )
					{
						options[ o ] = tweakables[property]["options"][ o ];
					}					
					
					// Add tweak item
					if ( tweakables[property]["value"] is Number )
					{
						Tweaker.Add( itemLabel, new ff.tweaker.Real(options) );
					}
					else if ( tweakables[property]["value"] is uint )
					{
						Tweaker.Add( itemLabel, new ff.tweaker.Unsigned(options) );
					}		
					else if ( tweakables[property]["value"] is Boolean )
					{
						Tweaker.Add( itemLabel, new ff.tweaker.Bool(options) );
					}
					else if ( tweakables[property]["value"] is Boolean )
					{
						Tweaker.Add( itemLabel, new ff.tweaker.Bool(options) );
					}
				}
			}			
		}
		
		private static function OnKeyDown( e:KeyboardEvent ):void
		{
			switch ( e.keyCode )
			{
			case 27: // ESCAPE
				OnTweakerToggle();
				break;
			}
		}
		
		private static function OnTweakerToggle():void
		{
			if ( ! TWEAKS )
			{
				return;
			}
			
			var tweakerActive:Boolean = Tweaker.IsActive();
			
			Tweaker.SetActive( ! tweakerActive );
			Input.SetEnabled( tweakerActive ); // disable game input
		}
		
		private function InitDebugText():void
		{
			DebugText = new DebugTextManager( stage );
			
			m_debugText = {
				gamestate: DebugText.Add( "PLACEHOLER", Settings.appX / 2, 0 )
			};
		}
		
		private function UpdateDebugText():void
		{				
			if ( Tweakables["debug"] )
			{
				DebugText.SetVisible( true );
				
				// update gamestate
				TextField( m_debugText["gamestate"] ).text = flash.utils.getQualifiedClassName( FP.world );
			}
			else
			{
				DebugText.SetVisible( false );
			}		
		}
		
			
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		private var m_debugText:Object;
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		public static var Tweaker:ff.tweaker.DefaultModule;
		public static var Flow:Gameflow;
		public static var Tournament:TournamentState;
		public static var DebugText:DebugTextManager;
		public static var Fader:ScreenFader;
		public static var Music:TitleMusic;
	}
}