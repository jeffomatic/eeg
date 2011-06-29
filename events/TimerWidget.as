package events
{
	import ff.Fonts;
	import ff.U;
	
	import flash.display.Graphics;
	import flash.geom.Rectangle;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Graphic;
	import net.flashpunk.Mask;
	import net.flashpunk.graphics.Canvas;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	
	public class TimerWidget extends Entity
	{
		public function TimerWidget(x:Number=0, y:Number=0)
		{					
			// create text
			Text.size = 30;
			Text.font = ff.Fonts.CousineBold.fontName;
			
			m_text = new Text( "00:00:00" );
			m_text.smooth = true;
			
			m_shadow = new Text( "00:00:00" );
			m_shadow.color = 0x000000;
			m_shadow.smooth = true;
			m_shadow.x = 3;
			m_shadow.y = 3;
			
			var list:Graphiclist = new Graphiclist;
			
			list.scrollX = 0;
			list.scrollY = 0;
			
			list.add( m_shadow );
			list.add( m_text );
			
			super( x, y, list );
		}
		
		override public function update():void
		{
			super.update();
			x = Settings.timer.x;
			y = Settings.timer.y;
		}
		
		public function SetTime( time:Number ):void
		{		
			var s:String = ff.U.SecondsToHHMMXX( time );	
			m_text.text = s;
			m_shadow.text = s;
		}
		
		private var m_text:Text;
		private var m_shadow:Text;
	}
}