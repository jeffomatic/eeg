package
{
	import net.flashpunk.Sfx;
	
	public class TitleMusic
	{
		public function TitleMusic() : void
		{
			
		}
		
		public function Start() : void
		{
			Song.play();
		}
		
		public function Stop() : void
		{
			Song.stop();
		}
		
		public function IsPlaying() : Boolean
		{
			//trace ("hepple"+Song.playing);
			return Song.playing;
		}
		
		public function SetVolume( v:Number ):void
		{
			Song.volume = v;
		}
		
	[Embed(source = 'assets/music/title.mp3')]
	public static const MUSIC_TITLE:Class;
	public static const Song : Sfx = new Sfx(MUSIC_TITLE);

	}
}