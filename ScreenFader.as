package
{
	import flash.display.Shape;
	import flash.display.Stage;
	
	import net.flashpunk.Tween;
	import net.flashpunk.Tweener;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	public class ScreenFader extends Tweener
	{
		public function ScreenFader( stage:Stage )
		{
			m_callback = null;
			
			m_fill = new Shape();
			
			m_fill.graphics.beginFill( 0, 1 );
			m_fill.graphics.drawRect( 0, 0, Settings.appX, Settings.appY );
			m_fill.graphics.endFill();
			m_fill.alpha = 0;
			
			stage.addChild( m_fill );
			
			m_tween = new NumTween;
			m_tween.complete = TweenFinished;
			addTween( m_tween );
		}
		
		public function FadeOut( callback:Function = null ):void
		{
			m_tween.tween( 0, 1, .75, net.flashpunk.utils.Ease.sineInOut );
			m_tween.start();
			m_callback = callback;
		}
		
		public function FadeIn( callback:Function = null ):void
		{
			m_tween.tween( 1, 0, .75, net.flashpunk.utils.Ease.sineInOut );
			m_tween.start();
			m_callback = callback;
		}
		
		public function Update( timeDelta:Number ):void
		{
			// re-attach at the top of the display list
			var stage:Stage = m_fill.stage;
			stage.removeChild( m_fill );
			stage.addChild( m_fill );
			
			updateTweens();
			
			if ( m_tween.active )
			{
				m_fill.alpha = m_tween.value;
			}
		}
		
		private function TweenFinished():void
		{
			if ( m_callback != null )
			{
				m_callback();
			}
			
			m_callback = null;
		}
		
		private var m_callback:Function;
		private var m_fill:Shape;
		private var m_tween:NumTween;
	}
}