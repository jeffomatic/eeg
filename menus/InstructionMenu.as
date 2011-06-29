package menus
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;

	public class InstructionMenu extends BaseMenu
	{
		public function InstructionMenu()
		{
			super();
			
			// Load bg image
			add( new Entity(
				0,
				0,
				new Image(Game.Tournament.GetEventDescriptor()["instructions"]))
			);
		}
		
		override public function update():void
		{
			super.update();
			
			if ( Input.pressed(Key.ENTER) )
			{
				Game.Flow.GamestateFinished();
			}
		}
	}
}