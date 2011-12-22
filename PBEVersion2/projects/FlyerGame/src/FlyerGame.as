/**
 * Copyright (C) 2005-2012 by Rivello Multimedia Consulting (RMC).                    
 * code [at] RivelloMultimediaConsulting [dot] com                                                  
 *                                                                      
 * Permission is hereby granted, free of charge, to any person obtaining
 * a copy of this software and associated documentation files (the      
 * "Software"), to deal in the Software without restriction, including  
 * without limitation the rights to use, copy, modify, merge, publish,  
 * distribute, sublicense, and#or sell copies of the Software, and to   
 * permit persons to whom the Software is furnished to do so, subject to
 * the following conditions:                                            
 *                                                                      
 * The above copyright notice and this permission notice shall be       
 * included in all copies or substantial portions of the Software.      
 *                                                                      
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,      
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF   
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR    
 * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.                                      
 */
// Marks the right margin of code *******************************************************************
package
{
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.pblabs.core.PBGroup;
	import com.pblabs.core.PBSet;
	import com.pblabs.debug.Console;
	import com.pblabs.debug.ConsoleCommandManager;
	import com.pblabs.input.KeyboardManager;
	import com.pblabs.property.PropertyManager;
	import com.pblabs.time.TimeManager;
	import com.rmc.projects.pbe2.pbflyergame.resources.FlyerGameResources;
	import com.rmc.projects.pbe2.pbflyergame.components.CollisionDetectComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.GameOverComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.input.KeyboardMoverComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.movement.FaceForwardComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.movement.MoveHorizontallyComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.movement.ScreenTrapComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.movement.ScreenWrapComponent;
	import com.rmc.projects.pbe2.pbflyergame.gameobjects.MovieClipGameObject;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.KeyboardEvent;
	import flash.filters.DropShadowFilter;
	import flash.geom.Point;
	import flash.media.Sound;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.ui.Keyboard;
	
	import flashx.textLayout.formats.TextAlign;
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class </p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	[SWF(width="800", height="600", frameRate="60")]
	public class FlyerGame extends Sprite
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		//PUBLIC
		
		//PUBLIC GETTER / SETTER
		/**
		 * ...
		 * 
		 */		
		public function get isPaused () 					: Boolean 	{ 	return _isPaused_boolean; 		}
		public function set isPaused (aValue : Boolean) 	: void 		{ 
			if (_isPaused_boolean != aValue) {
				_isPaused_boolean = aValue; 
				if (_isPaused_boolean) {
					(_root_pbgroup.getManager(TimeManager) as TimeManager).timeScale = 0;
				} else {
					(_root_pbgroup.getManager(TimeManager) as TimeManager).timeScale = 1;
				}
			}
		}
		private var _isPaused_boolean : Boolean;
		
		
		//PUBLIC STATIC
		public static const FLYER_MOVEMENT_RADIUS : uint 		= 30;  //increase to move more per keypress
		public static const STAGE_VICTORY_Y_POSITION : uint 	= 30;
		public static const ENEMY_MAX_MOVEMENT_RADIUS : uint 	= 30; //increase to raise difficulty
		public static const COLLISION_DETECTION_RADIUS : uint 	= 30; //increase to raise difficulty
		
		
		/**
		 * Components call getInstance() to access core game class
		 * 
		 */
		public static var _instance : FlyerGame;
		public static function getInstance () : FlyerGame { return _instance }
		
		//PRIVATE
		
		/**
		 * Describe this member.
		 * 
		 */
		public static var _root_pbgroup:PBGroup;
		
		
		/**
		 * Describe this member.
		 * 
		 */
		public static var _root_pbset:PBSet;
		
		
		/**
		 * Describe this member.
		 * 
		 */
		private var _score_textfield:TextField;
		
		
		/**
		 * Game Objects!
		 * 
		 */
		private var _flyer_mcgo:MovieClipGameObject;
		private var _biplane2_mcgo:MovieClipGameObject;
		private var _biplane1_mcgo:MovieClipGameObject;
		private var _blimp2_mcgo:MovieClipGameObject;
		private var _blimp1_mcgo:MovieClipGameObject;
		
		/**
		 * Sounds!
		 * 
		 */
		private var _winFlyer_sound:Sound;
		private var _loseFlyer_sound:Sound;
		private var _moveFlyer_sound:Sound;
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		
		private var _background_mcgo:MovieClipGameObject;
		
		
		/**
		 * This is the constructor.
		 * 
		 */
		public function FlyerGame()
		{
			// SETUP
			_instance = this;
			stage.addEventListener(KeyboardEvent.KEY_DOWN, _onKeyDown);
			restartGame();
			
		}
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		
		//PRIVATE
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		public function restartGame () : void
		{
			if (!_root_pbgroup) {
				_doSetup();
			} else {
				trace ("Game Is Not Yet Coded To Clear the screen properly and then restart. Close and open the Flash Player to continue");
			}
		}
		
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		public function doEndGameWithWin () : void
		{
			//MESSAGE
			trace ("You Win!");
			
			//SET SCORE
			setScore (100);
			
			//PLAY SOUND
			playWinGameSound();
			
			//END GAME, STOP LISTENTING TO EVENTS
			onStopGame();
		}
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		public function doEndGameWithLoss () : void
		{
			
			//MESSAGE
			trace ("You Lose!");
			
			//SET SCORE
			setScore (-100);
			
			//PLAY SOUND
			playLoseGameSound();
			
			//END GAME
			onStopGame();
		}
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		public function onStopGame () : void
		{
			isPaused = true;
			restartGame();
		}
		
		/**
		 * Sound: 
		 * 
		 * @return void
		 * 
		 */
		public function playWinGameSound () : void
		{
			_winFlyer_sound.play(0,0);
		}
		
		/**
		 * Sound: 
		 * 
		 * @return void
		 * 
		 */
		public function playLoseGameSound () : void
		{
			_loseFlyer_sound.play(0,0);
			
		}
		
		/**
		 * Sound: 
		 * 
		 * @return void
		 * 
		 */
		public function playMoveFlyerSound () : void
		{
			_moveFlyer_sound.play(0,0);
			
		}
		
		/**
		 * Stage: Update the score display 
		 * 
		 * @return void
		 * 
		 */
		public function setScore (aScore_num : Number) : void
		{
			_score_textfield.htmlText = "Score: " + aScore_num;
		}
		
		
		// PRIVATE
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doSetup () : void
		{
			//
			_doSetupStage();
			
			//ALWAYS SETUP AGAIN (ALSO FOR RE-START)
			_doSetupSprites();
			_doApplyEffects();
			_doSetupGameLoop();
			_doStartGameplay();
		}
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doSetupStage () : void
		{
			// ALIGNMENT
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			// THE ROOT GROUP HOLDS ALL ENTITIES
			// EACH REGISTERED MANAGER IS AVAILABLE TO ANY ENTITY AS DEPENDENCY INJECTION
			_root_pbgroup = new PBGroup();
			_root_pbgroup.name = "RootPBGroup";
			_root_pbgroup.registerManager(Stage, stage);
			_root_pbgroup.registerManager(PropertyManager, new PropertyManager());
			_root_pbgroup.registerManager(ConsoleCommandManager, new ConsoleCommandManager());
			_root_pbgroup.registerManager(TimeManager, new TimeManager());
			_root_pbgroup.registerManager(KeyboardManager, new KeyboardManager());
			_root_pbgroup.registerManager(Console, new Console());
			_root_pbgroup.initialize();
			
			_root_pbset = new PBSet ();
			_root_pbset.name = "_root_pbset";
			_root_pbset.owningGroup = _root_pbgroup;
			_root_pbset.initialize();
			
			////////////////////////////////////////////////////////////////////////
			//SOUNDS - 	PBE1 had sound management classes. As of today, I see no such 
			//			classes in PBE2. Not sure what will come in the future.
			//			So, we use regular AS3 classes.
			////////////////////////////////////////////////////////////////////////
			_winFlyer_sound 	= FlyerGameResources.WIN_FLYER_SOUND;
			_loseFlyer_sound 	= FlyerGameResources.LOSE_FLYER_SOUND;
			_moveFlyer_sound 	= FlyerGameResources.MOVE_FLYER_SOUND;
		}
		
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doSetupSprites () : void
		{
			////////////////////////////////////////////////////////////////////////
			//PUSHBUTTON GAME OBJECTS - These are all 'part of the game world'. 
			//							They may do collision detection, move, animate, 
			//							run logic, more...
			////////////////////////////////////////////////////////////////////////
			//BACKGROUND
			/*
			_background_mcgo = _doCreateMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_BACKGROUND_MC, new Point (0,0));
			_background_mcgo.initialize();
			
			//BLIMP
			_blimp1_mcgo = _doCreateEnemyMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_BLIMP_MC, new Point(120, 120), -1, FlyerGame.ENEMY_MAX_MOVEMENT_RADIUS);
			_blimp1_mcgo.initialize();
			_blimp2_mcgo = _doCreateEnemyMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_BLIMP_MC, new Point(330, 330), -1, FlyerGame.ENEMY_MAX_MOVEMENT_RADIUS/2);
			_blimp2_mcgo.initialize();
			
			//BIPLANE
			_biplane1_mcgo = _doCreateEnemyMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_BIPLANE_MC, new Point(200, 200), 1, FlyerGame.ENEMY_MAX_MOVEMENT_RADIUS);
			_biplane1_mcgo.initialize();
			_biplane2_mcgo = _doCreateEnemyMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_BIPLANE_MC, new Point(440, 440), 1, FlyerGame.ENEMY_MAX_MOVEMENT_RADIUS/3);
			_biplane2_mcgo.initialize();
			
			*/
			//FLYER
			_flyer_mcgo = _doCreateFlyerMovieClipGameObject (FlyerGameResources.MOVIE_CLIP_FLYER_MC, new Point(220, 520)); 
			_flyer_mcgo.initialize();
			
			
			////////////////////////////////////////////////////////////////////////
			//FLASH DISPLAY OBJECTS - 	Since these are simpler 
			//							and not 'part of the game', 
			//							we don't use PUSHBUTTON Game Objects 
			////////////////////////////////////////////////////////////////////////
			_score_textfield = new TextField ();
			_score_textfield.x = _score_textfield.y = 25;
			var textFormat : TextFormat = new TextFormat();
			textFormat.size = 40;
			textFormat.color = 0x000000;
			_score_textfield.defaultTextFormat = (textFormat);
			_score_textfield.width = 300;
			stage.addChild(_score_textfield);
			setScore(0);
			
			var _instructions_textfield : TextField = new TextField ();
			_instructions_textfield.x = 1;
			_instructions_textfield.y = 1;
			var textFormat1 : TextFormat = new TextFormat();
			textFormat1.align = TextAlign.LEFT
				;
			textFormat1.size = 10;
			textFormat1.color = 0x000000;
			_instructions_textfield.defaultTextFormat = (textFormat1);
			_instructions_textfield.width = 500;
			_instructions_textfield.multiline = true;
			stage.addChild(_instructions_textfield);
			_instructions_textfield.htmlText = "<u>Use up, down, left, right to reach the top. Spacebar pause.</u>";
			
			
		}
		
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doApplyEffects () : void
		{
			//TURN OFF DURING TESTING, NO REAL REASON...
			return;
			
			
			//SET ALL TO HAVE A NICE DROPSHADOW - THE SAME ONE
			_flyer_mcgo.render.movieClip.filters = 
				_blimp1_mcgo.render.movieClip.filters = 
				_blimp2_mcgo.render.movieClip.filters = 
				_biplane1_mcgo.render.movieClip.filters = 
				_biplane2_mcgo.render.movieClip.filters = [new DropShadowFilter (4,45,0x000000,.5)]
		}
		
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doSetupGameLoop () : void
		{
			isPaused = false;
		}
		
		
		/**
		 * Setup: 
		 * 
		 * @return void
		 * 
		 */
		private function _doStartGameplay () : void
		{
			setScore (0);
			
		}
		
		
		/**
		 * Create Game Object: Very basic one with graphics from an external MovieClip 
		 * 
		 * @return MovieClipGameObject
		 * 
		 */
		private function _doCreateMovieClipGameObject (aMovieClipClass : Class, aPosition_point : Point) : MovieClipGameObject {
			
			var movieClipGameObject:MovieClipGameObject = new MovieClipGameObject(aMovieClipClass);
			movieClipGameObject.owningGroup = _root_pbgroup;
			_root_pbset.add(movieClipGameObject);
			movieClipGameObject.spatial.position = aPosition_point
			
			return movieClipGameObject;
		}
		
		
		/**
		 * Create Game Object: The Flyer which the user controls
		 * 
		 * @return MovieClipGameObject
		 * 
		 */
		private function _doCreateFlyerMovieClipGameObject (aMovieClipClass : Class, aPosition_point : Point) : MovieClipGameObject {
			
			var movieClipGameObject : MovieClipGameObject = _doCreateMovieClipGameObject (aMovieClipClass, aPosition_point);
			//
			movieClipGameObject.addComponent(new KeyboardMoverComponent(), 		"KeyboardMoverComponent");
			//
			movieClipGameObject.addComponent(new FaceForwardComponent(), 		"FaceForwardComponent");
			//
			movieClipGameObject.addComponent(new ScreenTrapComponent(), 		"ScreenTrapComponent");
			//
			movieClipGameObject.addComponent(new GameOverComponent(), 			"GameOverComponent");
			//
			var collisionDetectComponent : CollisionDetectComponent =  new CollisionDetectComponent();
			collisionDetectComponent.collideType 		= "FLYER";
			collisionDetectComponent.collidesWithType 	= "ENEMY";
			collisionDetectComponent.isCheckingCollisions = true;
			collisionDetectComponent.collisionDetectionRadius = COLLISION_DETECTION_RADIUS;
			movieClipGameObject.addComponent(collisionDetectComponent, "CollisionDetectComponent" );
			//
			return movieClipGameObject;
		}
		
		/**
		 * Create Game Object: These will be the 2 Blimps and the 2 Biplanes
		 * 
		 * @return MovieClipGameObject
		 * 
		 */
		private function _doCreateEnemyMovieClipGameObject (aMovieClipClass : Class, aPosition_point : Point, aDirection_int : int, aSpeed_num : Number) : MovieClipGameObject {
			
			var movieClipGameObject : MovieClipGameObject = _doCreateMovieClipGameObject (aMovieClipClass, aPosition_point);
			//
			var moveHorizontallyComponent : MoveHorizontallyComponent = new MoveHorizontallyComponent();
			moveHorizontallyComponent.horizontalDirection_int 	= aDirection_int;
			moveHorizontallyComponent.horizontalSpeed_num 		= aSpeed_num;
			movieClipGameObject.addComponent(moveHorizontallyComponent, "MoveHorizontallyComponent");
			//
			movieClipGameObject.addComponent(new FaceForwardComponent(), "FaceForwardComponent");
			//
			var collisionDetectComponent : CollisionDetectComponent =  new CollisionDetectComponent();
			collisionDetectComponent.collideType 		= "ENEMY";
			collisionDetectComponent.collidesWithType 	= "FLYER";
			collisionDetectComponent.isCheckingCollisions = false;
			movieClipGameObject.addComponent(collisionDetectComponent, "CollisionDetectComponent" );
			//
			var screenWrapComponent : ScreenWrapComponent = new ScreenWrapComponent();
			movieClipGameObject.addComponent(screenWrapComponent, "ScreenWrapComponent");
			//
			return movieClipGameObject;
		}
		
		// --------------------------------------
		// Event Handlers
		// --------------------------------------
		/**
		 * Handles the Event: <code>KeyboardEvent.KEY_DOWN</code>
		 * 
		 * 		NOTE: Movement is done with a <code>KeyboardMoverComponent</code>
		 * 		      Pause code is done here because its more of a 'global-level' event
		 * 			  And because it must work when pause=true (<code>KeyboardMoverComponent</code> does not) 
		 * 
		 * @param aEvent <code>KeyboardEvent</code> The incoming aEvent payload.
		 *  
		 * @return void
		 * 
		 */
		private function _onKeyDown (aEvent : KeyboardEvent ) : void
		{
			//	PAUSE / UNPAUSE
			if (aEvent.keyCode == Keyboard.SPACE) {
				if (!FlyerGame.getInstance().isPaused) {
					FlyerGame.getInstance().isPaused = true;
				} else {
					FlyerGame.getInstance().isPaused = false;
				}
			}
			
		}
		
		
	}
}





