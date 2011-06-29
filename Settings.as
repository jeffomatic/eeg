package
{
	import events.hurdles.*;
	import events.maze.MazeWorld;
	import events.running.*;
	import events.shooting.*;
	
	public final class Settings
	{
		public static const aspectRatio:Number = 16/9;
		
		public static const appX:uint = 800;
		public static const appY:uint = Number(appX) / aspectRatio;
		
		public static var timer:Object = { x: 610, y: 30 };	
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		[Embed(source = "./assets/UI/2_instruct-sprint.png")]
		private static const imgRunningInstructions:Class;
		
		[Embed(source = "./assets/UI/3_instruct-trap.png")]
		private static const imgHurdlesInstructions:Class;		
		
		[Embed(source = "./assets/UI/4_instruct-fish.png")]
		private static const imgShootingInstructions:Class;				
		
		[Embed(source = "./assets/UI/7_instruct-maze.png")]
		private static const imgMazeInstructions:Class;	
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		// List of event classes
		public static var Events:Object = {
			running: {
				label:"RUNNING",
				world:events.running.EventWorld,
				instructions:imgRunningInstructions,
				highScoreIsGood: false,
				bestTime: 28.0,
				worstTime: 40.0,
					
				tweakables: {
					speedScale: { value: Number(200), options: {min:0, max:1000, step:10, altStep:100} }
				}
			},
			
			shooting: {
				label:"SHOOTING",
				world:events.shooting.EventWorld,
				instructions:imgShootingInstructions,
				highScoreIsGood: true,
				bestTime: 50.0,
				worstTime: 20.0,
					
				tweakables: {
					startX: { value: appX/2 },
					startY: { value: appY/2 },
					playerSpeed: { value: Number(appX)/3 },

					bulletSpeed: { value: Number(appX)/3 },
					
					perimeterL: { value: 75 },
					perimeterR: { value: 725 },
					perimeterT: { value: 75 },
					perimeterB: { value: 375 }
				}
			},
			
			hurdles: {
				label:"HURDLES",
				world:events.hurdles.EventWorld,
				instructions:imgHurdlesInstructions,
				highScoreIsGood: true,
				bestTime: 40.0,
				worstTime: 20.0,
				
				tweakables: {
					startX: { value: 150 },
					startY: { value: 320 },					
					
					// x-axis
					accelPreThreshold: { value: 80.0 },
					thresholdVel: { value: 200.0 },
					accelPostThreshold: { value: 40.0 },
					
					// y-axis
					jumpGravity: { value: 1000.0, options: {min:0, max:1500} },
					jumpVel: { value: -500.0, options: {min:-1000, max:0, step:5, altStep:20} },

					// animation
					frameRateBase: { value: 2.0, options: {min:0, max:10, step:0.5, altStep:1} }, 
					frameRateScale: { value: 0.005, options: {min:0.001, max: 2, step:.001, altStep:.005} },
					
					// traps
					trapSpawnMinVel: { value: 20.0 },
					trapSpawnDistance: { value: Number(appX) * 1.5 },
					trapX: { value: Number(appX) + 10.0 },
					trapY: { value: Number(appY / 2) },
					
					// patterns
					patternMultiOffset: { value: 80.0 },
					patternTrickyOffset: { value: 800.0 },
					patternSingleWeight: { value: uint(10) },
					patternMultiWeight: { value: uint(4) },
					patternTrickyWeight: { value: uint(2) }
				}
			},
			
			maze: {
				label:"MAZE",
				world:events.maze.MazeWorld,
				instructions:imgMazeInstructions,
				highScoreIsGood: false,
				bestTime: 35.0,
				worstTime: 60.0,
					
				tweakables: {
					playerStartTileX: { value: uint(18) },
					playerStartTileY: { value: uint(10) },
					playerSpeed: { value: Number(3*75) },
					
					pickups: { value: uint(5) }
				}
			}
		};
		
		public static const TournamentOrder:Array = [
			"running",			
			"hurdles",						
			"shooting",
			"maze",
		];
		
		public static const RankingPoints:Array = [ 10, 8, 6, 4, 2, 0];
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		[Embed(source = "./assets/characters/1_dolphin.png")]
		private static const imgLargeDolphin:Class;
		
		[Embed(source = "./assets/characters/2_elephant.png")]
		private static const imgLargeElephant:Class;
		
		[Embed(source = "./assets/characters/3_gorilla.png")]
		private static const imgLargeGorilla:Class;			
		
		[Embed(source = "./assets/characters/4_tiger.png")]
		private static const imgLargeTiger:Class;			
		
		[Embed(source = "./assets/characters/5_rhino.png")]
		private static const imgLargeRhino:Class;
		
		[Embed(source = "./assets/characters/6_panda.png")]
		private static const imgLargePanda:Class;	
			
		[Embed(source = "./assets/characters/75/1_dolphin.png")]
		private static const imgSmallDolphin:Class;
		
		[Embed(source = "./assets/characters/75/2_elephant.png")]
		private static const imgSmallElephant:Class;
		
		[Embed(source = "./assets/characters/75/3_gorilla.png")]
		private static const imgSmallGorilla:Class;			
		
		[Embed(source = "./assets/characters/75/4_tiger.png")]
		private static const imgSmallTiger:Class;			
		
		[Embed(source = "./assets/characters/75/5_rhino.png")]
		private static const imgSmallRhino:Class;
		
		[Embed(source = "./assets/characters/75/6_panda.png")]
		private static const imgSmallPanda:Class;			
		
		///////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////
		
		// Stats for critters
		public static const Critters:Object = {
			tiger: {
				label:"TIGER",
				largeMap:imgLargeTiger,
				smallMap:imgSmallTiger
			},
			
			rhino: {
				label:"RHINO",
				largeMap:imgLargeRhino,
				smallMap:imgSmallRhino
			},
			
			panda: {
				label:"PANDA",
				largeMap:imgLargePanda,
				smallMap:imgSmallPanda
			},
			
			gorilla: {
				label:"GORILLA",
				largeMap:imgLargeGorilla,
				smallMap:imgSmallGorilla
			},
			
			elephant: {
				label:"ELEPHANT",
				largeMap:imgLargeElephant,
				smallMap:imgSmallElephant
			},
			
			dolphin: {
				label:"DOLPHIN",
				largeMap:imgLargeDolphin,
				smallMap:imgSmallDolphin
			}
		};		
	}
}