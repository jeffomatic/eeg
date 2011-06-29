package cutscenes
{
	
	import Game;
	
	import cutscenes.CutsceneBackground;
	import cutscenes.CutsceneBob;
	import cutscenes.CutsceneGreg;
	import cutscenes.CutsceneNames;
	import cutscenes.CutsceneScript;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.Alarm;
	import net.flashpunk.tweens.misc.NumTween;
	import net.flashpunk.utils.Ease;
	
	public class CutsceneTalkingHeads extends BaseCutscene
	{
		//super();
		
		public var scriptStage : Number = 0;
		public var currentScript : Array;
		public var Scripts : CutsceneScript;
		public var Bob : CutsceneBob;
		public var Greg : CutsceneGreg;
		public var background : CutsceneBackground;
		public var names : CutsceneNames;
		public var gregsound : Sfx;
		public var bobsound : Sfx;
		
		public var tbackground : Entity;
		public var tword1 : Entity;
		public var tword2 : Entity;
		public var tword3 : Entity;
		
		public var adZinfandelephant : Entity;
		public var adPandapals : Entity;
		public var adBuffet : Entity;
		public var adSabertooth : Entity;
		
		
		public var titleTimer : Timer;
		public var delayTimer : Timer;
		
		[Embed(source = 'assets/cutscenes/cutscenetitle_01.png')]
		private const CUTSCENETITLE1:Class;
		
		[Embed(source = 'assets/cutscenes/cutscenetitle_02.png')]
		private const CUTSCENETITLE2:Class;
		
		[Embed(source = 'assets/cutscenes/cutscenetitle_03.png')]
		private const CUTSCENETITLE3:Class;
		
		[Embed(source = 'assets/cutscenes/cutscenetitle_background.png')]
		private const CUTSCENETITLEBKGD:Class;
		
		[Embed(source = 'assets/Ads/ads_1_zin.png')]
		private const ADZINFANDEL:Class;
		
		[Embed(source = 'assets/Ads/ads_1_oldpeople.png')]
		private const ADBUFFET:Class;
		
		[Embed(source = 'assets/Ads/ads_1_sabre.png')]
		private const ADSABER:Class;
		
		[Embed(source = 'assets/Ads/ads_1_pandapals.png')]
		private const ADPANDA:Class;
		
		
		
		
		[Embed(source = 'assets/music/intro1.mp3')]
		public static const MUSIC_INTRO1:Class;

		[Embed(source = 'assets/music/intro2.mp3')]
		public static const MUSIC_INTRO2:Class;
		
		[Embed(source = 'assets/music/intro3.mp3')]
		public static const MUSIC_INTRO3:Class;
		
		[Embed(source = 'assets/music/intro4.mp3')]
		public static const MUSIC_INTRO4:Class;
		
		[Embed(source = 'assets/sfx/bomb.mp3')]
		public static const SFX_SLIDEIN:Class;
		
		
		public static const IntroSong1 : Sfx = new Sfx(MUSIC_INTRO1);
		public static const IntroSong2 : Sfx = new Sfx(MUSIC_INTRO2);
		public static const IntroSong3 : Sfx = new Sfx(MUSIC_INTRO3);
		public static const IntroSong4 : Sfx = new Sfx(MUSIC_INTRO4);
		public static const sfxSlideIn : Sfx = new Sfx(SFX_SLIDEIN);
		public function CutsceneTalkingHeads()
		{
			Scripts = new CutsceneScript;
			//InitializeCutscene(Scripts.Scene2, 5)
			
		}
		
		public function InitializeCutscene(scriptName : Array, nameSelection : Number) : void
		{
			
			background = new CutsceneBackground;
			Bob = new CutsceneBob;
			Greg = new CutsceneGreg;
			names = new CutsceneNames;
			
			
			add(background);
			add(Bob);
			add(Greg);
			add(names);
			
			names.flyIn(nameSelection);
			
			currentScript = scriptName;
			onAdvanceScript();	
		}
		
		override public function update() : void
		{
			
			super.update();
			if (tword1 && tword2 && tword3 && myTween1 && myTween2 && myTween3 && myTweenGlide)
			{
				tword1.x = myTween1.value + myTweenGlide.value;
				tword2.x = myTween2.value - myTweenGlide.value;
				tword3.x = myTween3.value + myTweenGlide.value;
				//tword1.x = tword1.x * 1;
			}
		}
		
		public function PlayRandomIntroSong() : void
		{
			var songchoice : uint = Math.random() * 4;

			switch (songchoice)
			{
				case 0:
					IntroSong1.play();
					break;
				case 1:
					IntroSong2.play();
					break;
				case 2:
					IntroSong3.play();
					break;
				case 3:
					IntroSong4.play();
					break;
			}
		}
		
		public function onDelayFinished( param : Event ) : void
		{
			//if (!scriptStage >= currentScript.length + 1)
			//{
			if (delayTimer.running)
			{
				delayTimer.stop();
				scriptStage += 1;
				onAdvanceScript();
			}

			//}
		}
		
		public function onTitleFinished( param : Event ) : void
		{
			titleTimer.stop();
			remove ( tbackground );
			remove ( tword1 );
			remove ( tword2 );
			remove ( tword3 );
			
			Greg.shutup();
			Bob.shutup();
			
			scriptStage += 1;
			onAdvanceScript();
		}
		
		public function onGregSpeechFinished() : void
		{
			Greg.shutup();
			Bob.shutup();
			scriptStage += 1;
			onAdvanceScript();
		}

		public function onBobSpeechFinished() : void
		{
			Bob.shutup();
			scriptStage += 1;
			onAdvanceScript();
		}

		public function titleCrash() : void
		{
			sfxSlideIn.play()
		
		}
		
		private var myTween1 : NumTween;
		private var myTween2 : NumTween;
		private var myTween3 : NumTween;
		private var myTweenGlide : NumTween;
		
		public function titleFlyin () : void
		{
			if (!myTween1)
			{
				myTween1 = new NumTween(titleCrash);
			}
			
			if (!myTween2)
			{
				myTween2 = new NumTween(titleCrash);
			}
			
			if (!myTween3)
			{
				myTween3 = new NumTween(titleCrash);
			}
	
			myTween1.tween(-800, 0, 0.15, Ease.circIn);
			myTween2.tween(800, 0,  0.3, Ease.circIn);
			myTween3.tween(-800, 0, 0.45, Ease.circIn);
			
			
			this.addTween(myTween1,true);
			this.addTween(myTween2,true);
			this.addTween(myTween3,true);
			
			//myTween.start();
			
		}
		
		public function titleGlide() : void
		{
			if (!myTweenGlide)
			{
				myTweenGlide = new NumTween();
			}
			
			myTweenGlide.tween(0, 50, 5);
			this.addTween(myTweenGlide,true);
			
			//myTween.start();
			
		}
		
	
		public function onAdvanceScript() : void
		{
			//trace (scriptStage);
			if (!currentScript[scriptStage])
				{
					Game.Flow.GamestateFinished();
				}
			else
			{
				
				
				if (currentScript[scriptStage]['title'])
				{					
					var tbkgd:Image = new Image( CUTSCENETITLEBKGD );
					var t1:Image = new Image( CUTSCENETITLE1 );
					var t2:Image = new Image( CUTSCENETITLE2 );
					var t3:Image = new Image( CUTSCENETITLE3 );
					
					tbackground = new Entity(0, 0, tbkgd);
					tword1 = new Entity(-800, 0, t1);
					tword2 = new Entity(800, 120, t2);
					tword3 = new Entity(-800, 250, t3);
					
					
					add( tbackground );
					add( tword1);
					add( tword2);
					add( tword3);
					
					PlayRandomIntroSong();
					
					titleFlyin();
					titleGlide();
					
					
					titleTimer = new Timer(2500);
					titleTimer.addEventListener(TimerEvent.TIMER,onTitleFinished);
					titleTimer.start();
					
					
					
				}
				
				if (currentScript[scriptStage]['advert'])
				{
					var i_adZinfandelephant:Image = new Image ( ADZINFANDEL );	
					var i_adBuffet:Image = new Image ( ADBUFFET );	
					var i_adSabertooth:Image = new Image ( ADSABER );	
					var i_adPandapals:Image = new Image ( ADPANDA );	
					
					adZinfandelephant = new Entity(0, 0, i_adZinfandelephant);
					adBuffet = new Entity(0, 0, i_adBuffet);
					adSabertooth = new Entity(0, 0, i_adSabertooth);
					adPandapals = new Entity(0, 0, i_adPandapals);
					
					var myAds : Array = [adZinfandelephant, adBuffet, adSabertooth, adPandapals, adZinfandelephant]
					var myAd : Number = currentScript[scriptStage]['advert'];
					//trace("MY INDEX: "+myAd
					//myAd.layer = 100;
					
					add(myAds[myAd]);
					scriptStage += 1;
					onAdvanceScript();
					
				
				}
				
				if (currentScript[scriptStage]['delay'])
				{
					if (delayTimer)
					{
						if (delayTimer.running)
						{
							delayTimer.stop();
						}
					}
					var timervalue : Number = (currentScript[scriptStage]['delay']);
					delayTimer = new Timer(timervalue * 1000);
					delayTimer.addEventListener(TimerEvent.TIMER,onDelayFinished);
					delayTimer.start();
					
				}
				var gregface : String = null;
				var bobface  : String = null;
			
				if (currentScript[scriptStage]['gregface'])
				{
					gregface = currentScript[scriptStage]['gregface'];
					if (gregface)
					{
						Greg.setFace(gregface);
						if (!currentScript[scriptStage]['greg'])
						{
							scriptStage += 1;
							onAdvanceScript();
						}
					}
					
				}
				if (currentScript[scriptStage]['bobface'])
				{
					bobface = currentScript[scriptStage]['bobface'];
					if (bobface)
					{
						Bob.setFace(bobface);
						if (!currentScript[scriptStage]['bob'])
						{
							scriptStage += 1;
							onAdvanceScript();
						}
					}
					
				}
				
				if (currentScript[scriptStage]['bob'])
				{
					
					var bobsface : String = currentScript[scriptStage]['face'];
					if (bobsface)
					{
						Bob.setFace(bobsface);
					}
					bobsound = currentScript[scriptStage]['bob'];
					bobsound.complete = onBobSpeechFinished;
					
					
					Bob.say(bobsound, bobsface);
					
				}				
				
				if (currentScript[scriptStage]['greg'])
				{
					var gregsface : String = currentScript[scriptStage]['face'];
					if (gregsface)
					{
						Greg.setFace(gregsface);
					}
					gregsound = currentScript[scriptStage]['greg'];
					gregsound.complete = onGregSpeechFinished;
					
					
					Greg.say(gregsound, gregsface);
					
				}
				

				

				
				
				//scriptStage += 1;
			}
			
		}
		
	}
}