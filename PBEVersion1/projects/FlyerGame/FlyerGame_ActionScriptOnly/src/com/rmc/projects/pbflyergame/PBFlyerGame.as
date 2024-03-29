/***************************************************************************************************
 * Copyright (C) 2007 - 2010  : Rivello Multimedia Consulting
 * For more information email : presentations2010@RivelloMultimediaConsulting.com
 * For more information see   : http://www.RivelloMultimediaConsulting.com
 * 
 * This file and/or its constituents are licensed under the terms of the MIT license, 
 * which is included in the License.html file at the root directory of this SDK.
 ***************************************************************************************************/

//Marks the right margin of code *******************************************************************
package com.rmc.projects.pbflyergame
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.pblabs.box2D.Box2DManagerComponent;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.debug.Logger;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.AnimationController;
	import com.pblabs.rendering2D.AnimationControllerInfo;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	import com.pblabs.rendering2D.spritesheet.SWFSpriteSheetComponent;
	import com.pblabs.rendering2D.ui.SceneView;
	import com.rmc.projects.pbflyergame.components.CollisionDetectComponent;
	import com.rmc.projects.pbflyergame.components.FaceForwardComponent;
	import com.rmc.projects.pbflyergame.components.GameOverComponent;
	import com.rmc.projects.pbflyergame.components.MoveByKeyboardInputComponent;
	import com.rmc.projects.pbflyergame.components.MoveHorizontallyComponent;
	import com.rmc.projects.pbflyergame.components.ScreenTrapComponent;
	import com.rmc.projects.pbflyergame.components.ScreenWrapComponent;
	import com.rmc.projects.pbflyergame.screens.GameScreen;
	import com.rmc.projects.pbflyergame.screens.IntroScreen;
	import com.rmc.utils.pbe.FlyerGameHelper;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : PBFlyerGame: Main Game Class</p>
	 * 
	 * <p>DATE    : May 02, 2010</p>
	 * <p>AUTHOR  : Samuel Asher Rivello</p>
	 * <p>CONTACT : presentations2010@RivelloMultimediaConsulting.com</p>
	 * 
	 */
	[SWF(width="800", height="600", frameRate="60")]
	public class PBFlyerGame extends Sprite
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC GETTER/SETTERS
		
		//PUBLIC CONST
		public static var WIDTH 	: Number = 800;
		public static var HEIGHT		: Number = 600;
		
		//PRIVATE
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * FLASH: Setup the Game and Start Playing!
		 * 
		 */
		public function PBFlyerGame ()
		{
			//SUPER
			super (); 
			
			//	START PBE
			PBE.startup(this);
			
			//	0.5 =  HALF-SPEED, 
			//	2.0 = DOUBLE SPEED (SMOOTHER ANIMATION)
			PBE.processManager.timeScale = 1;
			
			//	TEST TRACING OUTPUT MESSAGE
			Logger.print(this, "PBFlyerGame - Press 'Ctrl + ~' to Open Debugger");
			
			//	LOAD EMBEDDED RESOURCS
			PBE.addResources(new PBFlyerGameResources()); 
			
			// Set up our screens.
			PBE.screenManager.registerScreen		("intro_screen", 	new IntroScreen());
			PBE.screenManager.registerScreen		("game_screen", 	new GameScreen());
			
			//	Show the intro_screen - Then wait for a user click and it calls 'restartGame()'
			PBE.screenManager.goto				("intro_screen");
			

			
		}

		
		//--------------------------------------
		//  Methods
		//--------------------------------------		
		//PRIVATE	
		/**
		 * PBE: Restart Game
		 * 
		 * @return void
		 */
		public function restartGame ( ) : void 
		{

			//	CLEAR SCREEN (IF 'RE'-STARTING)
			_clearEverything ();
			
			//	SHOW INTRO
			PBE.screenManager.goto		("intro_screen");
			
			//	CREATE SCENE ENTITY
			_createScene();
			
			//	CREATE BACKGROUND ENTITY
			_createBackgroundEntity();
			
			//	CREATE OBSTACLE ENTITIES
			_createObstacleEntities();
			
			//	CREATE FLYER ENTITY
			_createFlyerEntity();
			
			//	START THE 'ENGINE!'
			PBE.processManager.start();
			

			

		}
		
		
		
		/**
		 * PBE: CLEAR SCENE
		 * 
		 * @return void
		 */
		private function _clearEverything ( ) : void 
		{
			//what do I do here to clear out the world and everything??? - srivello
			PBE.rootGroup.destroy();
			PBE.rootGroup.clear();
			//All entities, sets, and groups are automatically added to PBE.rootGroup. 
			//	Call clear() on that PBGroup to delete them all. (IIRC)
			//This ownership system is designed to ease memory/lifespan management.
		}
		
		
		/**
		 * PBE: CREATE SCENE ENTITY
		 * 
		 * @return void
		 */
		private function _createScene ( ) : void 
		{
			//make the scene (add to class comments, not here)
			var sceneView : SceneView = new SceneView();  
			sceneView.width 		= WIDTH;
			sceneView.height 		= HEIGHT;
			PBE.initializeScene		(sceneView, FlyerGameHelper.SCENE, null, Box2DManagerComponent);     
			
			// Adjust graphics for convenience
			PBE.scene.setWorldCenter	( new Point (-WIDTH, -HEIGHT));								
		
			//PHYSICS ARE NOT NEEDED SO WE DISABLE GRAVITY
			//BUT 'BOX2D' IS USED FOR ITS COLLISION DETECTION - NICE!
			(PBE.spatialManager as Box2DManagerComponent).gravity = new Point (0,0);

		}
		
		
		/**
		 * PBE: CREATE FLYER ENTITY
		 * 
		 * @return void
		 */
		private function _createFlyerEntity ( ) : void 
		{
			
			//////////////////
			//	PROPERTIES
			//////////////////
			var position_point	: Point 	= new Point (WIDTH*.65,HEIGHT-50);
			var size_point		: Point 	= new Point (.1,.1);
			var zIndex_uint		: uint 		= 10;
			
			//////////////////
			//	ENTITY
			//////////////////
			// Allocate an entity for our background sprite
			var flyer_entity:IEntity = 		PBE.allocateEntity();
			FlyerGameHelper.createSpatialEntity 	( flyer_entity, position_point, size_point);
			
			//////////////////
			//	COLLISION DETECTION
			//////////////////
			var collisionType_str 					: String	= "Flyer";
			var collidesWithCollisionTypes_array 	: Array 	= ["Obstacle"];
			FlyerGameHelper.enableCollisionDetection (	flyer_entity, collisionType_str, 
														collidesWithCollisionTypes_array, true); 
			
			//////////////////
			//	RENDER
			//	COMPONENTS
			//////////////////
			//	LOAD MC ASSET
			var swfSpriteSheetComponent : SWFSpriteSheetComponent = new SWFSpriteSheetComponent();
			FlyerGameHelper.loadMovieClipAsset (swfSpriteSheetComponent, 
												PBFlyerGameResources.ASSETS_SWF, 
												PBFlyerGameResources.MOVIE_CLIP_OBSTACLE_FLYER);

			// 	USE ASSET TO RENDER
			var spriteSheetRenderer:SpriteSheetRenderer = new SpriteSheetRenderer();
			FlyerGameHelper.setupSpriteSheetRenderer (	spriteSheetRenderer, 
														swfSpriteSheetComponent, 
														0, 
														zIndex_uint);

			//	CREATE ANIMATION LOOP #1
			var idle_animationControllerInfo:AnimationControllerInfo = new AnimationControllerInfo();
			idle_animationControllerInfo.loop 			= false;
			idle_animationControllerInfo.frameRate 		= 1;
			idle_animationControllerInfo.spriteSheet 	= swfSpriteSheetComponent;
			
			//	CREATE ANIMATION LOOP #2
			var move_animationControllerInfo:AnimationControllerInfo = new AnimationControllerInfo();
			move_animationControllerInfo.loop 			= true;
			move_animationControllerInfo.frameRate 		= 1;
			move_animationControllerInfo.maxFrameDelay 	= 250;
			move_animationControllerInfo.spriteSheet 	= swfSpriteSheetComponent;
			
			//	SAVE ALL ANIMATION LOOPS
			var animationController : AnimationController 	= new AnimationController ();
			animationController.spriteSheetReference  		= new PropertyReference (FlyerGameHelper.RENDER_SPRITE_SHEET);
			animationController.currentFrameReference 		= new PropertyReference (FlyerGameHelper.RENDER_SPRITE_INDEX);
			animationController.animations	[FlyerGameHelper.ANIMATION_IDLE] 	= idle_animationControllerInfo;
			animationController.animations	[FlyerGameHelper.ANIMATION_MOVE] 	= move_animationControllerInfo;
			animationController.defaultAnimation 			= FlyerGameHelper.ANIMATION_IDLE;
			animationController.changeAnimationEvent			= FlyerGameHelper.ANIMATION_CHANGE_EVENT;
			animationController.currentAnimationReference	= new PropertyReference (FlyerGameHelper.CURRENT_ANIMATION_REFERENCE);
			
			//	ADD COMPONENTS
			flyer_entity.addComponent(animationController, FlyerGameHelper.ANIMATION_CONTROLLER);
			flyer_entity.addComponent(spriteSheetRenderer, FlyerGameHelper.RENDER);
			
			
			//////////////////
			//	MOVE-BY-KEYBOARD
			//	COMPONENT
			//////////////////
			// Create an instance of our hero controller component
			var moveByKeyboardInputComponent:MoveByKeyboardInputComponent = new MoveByKeyboardInputComponent();
			flyer_entity.addComponent( moveByKeyboardInputComponent, MoveByKeyboardInputComponent.NAME);
			
			//////////////////
			//	SCREEN-TRAP/WRAP
			//	COMPONENT
			//////////////////
			var isScreenWrapping_boolean : Boolean = false; //Try (true) and see the flexibility of PBE
			if (isScreenWrapping_boolean) {
				//EXPERIMENT: WRAP AROUND SCREEN (From Left Edge to Right Edge, Etc...)
				var screenWrapComponent : ScreenWrapComponent = new ScreenWrapComponent();
				flyer_entity.addComponent ( screenWrapComponent, ScreenWrapComponent.NAME );
			} else {
				//EXPERIMENT: BE 'TRAPPED' AND STAY IN SCREEN'S BOUNDS
				var screenTrapComponent : ScreenTrapComponent = new ScreenTrapComponent();
				flyer_entity.addComponent ( screenTrapComponent, ScreenTrapComponent.NAME );
				
			}

			//////////////////
			//	FACE-FORWARD 
			//	COMPONENT
			//////////////////
			var faceForwardComponent : FaceForwardComponent = new FaceForwardComponent();
			flyer_entity.addComponent ( faceForwardComponent, FaceForwardComponent.NAME );
			
			//////////////////
			//	COLLISION-DETECTION 
			//	COMPONENT
			//////////////////
			var collisionDetectComponent : CollisionDetectComponent = new CollisionDetectComponent();
			flyer_entity.addComponent ( collisionDetectComponent, CollisionDetectComponent.NAME );
			
			//////////////////
			//	GAME-OVER 
			//	COMPONENT
			//////////////////
			var gameOverComponent : GameOverComponent = new GameOverComponent ();
			flyer_entity.addComponent ( gameOverComponent, GameOverComponent.NAME );
			
			
			//////////////////
			//	INITIALIZE
			//////////////////
			flyer_entity.initialize			("flyer_entity");
			
			
		}

		
		/**
		 * PBE: CREATE OBSTACLE ENTITIES
		 * 
		 * @return void
		 */
		private function _createObstacleEntities ( ) : void 
		{
			
			//	CREATE OBSTACLE ENTITY (MOVIE_CLIP_APPEARANCE, POSITION, AND DRAWING DEPTH)
			_createObstacleEntity ( PBFlyerGameResources.MOVIE_CLIP_OBSTACLE_BIPLANE, 	new Point (WIDTH*.0,	HEIGHT*0.20), 	1, 1, 30);
			_createObstacleEntity ( PBFlyerGameResources.MOVIE_CLIP_OBSTACLE_BLIMP, 		new Point (WIDTH*.20,	HEIGHT*0.40), 	2, -1, 25);
			_createObstacleEntity ( PBFlyerGameResources.MOVIE_CLIP_OBSTACLE_BIPLANE, 	new Point (WIDTH*.35,	HEIGHT*0.55), 	3, 1, 15);
			_createObstacleEntity ( PBFlyerGameResources.MOVIE_CLIP_OBSTACLE_BLIMP, 		new Point (WIDTH*.50,	HEIGHT*0.70), 	4, -1, 35);
		
		}
		
		
		/**
		 * PBE: CREATE OBSTACLE ENTITIES
		 * 
		 * @return void
		 */
		private function _createObstacleEntity (aMovieClipName_str 			: String, 
												aPosition_point 			: Point, 
												aZIndex_uint				: uint,  
												aHorizontalDirection_int	: int, 
												aHorizontalSpeed_num 		: Number) : void 
		{
			
			//////////////////
			//	ENTITY
			//////////////////
			// Allocate an entity for our background sprite
			var obstacle_entity:IEntity = PBE.allocateEntity();
			FlyerGameHelper.createSpatialEntity ( obstacle_entity, aPosition_point);
			
			
			//////////////////
			//	COLLISION DETECTION
			//////////////////
			var collisionType_str 					: String	= "Obstacle";
			var collidesWithCollisionTypes_array 	: Array 	= ["Flyer"];
			FlyerGameHelper.enableCollisionDetection (obstacle_entity, collisionType_str, collidesWithCollisionTypes_array, false);
			
				
			//////////////////
			//	RENDER
			//	COMPONENTS
			//////////////////
			
			//	LOAD MC ASSET
			var swfSpriteSheetComponent : SWFSpriteSheetComponent = new SWFSpriteSheetComponent();
			FlyerGameHelper.loadMovieClipAsset (swfSpriteSheetComponent, PBFlyerGameResources.ASSETS_SWF, aMovieClipName_str);
			
			// 	USE ASSET TO RENDER
			var spriteSheetRenderer:SpriteSheetRenderer = new SpriteSheetRenderer();
			FlyerGameHelper.setupSpriteSheetRenderer (spriteSheetRenderer, swfSpriteSheetComponent, 0, aZIndex_uint);

			//	ADD AS RENDERER
			obstacle_entity.addComponent( spriteSheetRenderer, FlyerGameHelper.RENDER );
			
			
			//////////////////
			//	MOVE-HORIZONTALLY
			//	COMPONENT
			//////////////////
			var moveHorizontallyComponent:MoveHorizontallyComponent = new MoveHorizontallyComponent();
			moveHorizontallyComponent.horizontalDirection_int 		= aHorizontalDirection_int;
			moveHorizontallyComponent.horizontalSpeed_num 			= aHorizontalSpeed_num;
			obstacle_entity.addComponent ( moveHorizontallyComponent, MoveHorizontallyComponent.NAME );
			
			//////////////////
			//	SCREEN-WRAP
			//	COMPONENT
			//////////////////
			var screenWrapComponent : ScreenWrapComponent = new ScreenWrapComponent();
			obstacle_entity.addComponent ( screenWrapComponent, ScreenWrapComponent.NAME );
			
			//////////////////
			//	FACE-FORWARD 
			//	COMPONENT
			//////////////////
			var faceForwardComponent : FaceForwardComponent = new FaceForwardComponent();
			obstacle_entity.addComponent ( faceForwardComponent, FaceForwardComponent.NAME );
			
			
			//////////////////
			//	INITIALIZE
			//////////////////
			obstacle_entity.initialize("obstacle_entity" + aZIndex_uint);
		}

		
		/**
		 * PBE: CREATE BACKGROUND ENTITY
		 * 
		 * @return void
		 */
		private function _createBackgroundEntity ( ) : void 
		{

			//////////////////
			//	PROPERTIES
			//////////////////
			var position_point	: Point 	= new Point (0,0);
			var zIndex_uint		: uint 		= 1;
			
			//////////////////
			//	ENTITY
			//////////////////
			// Allocate an entity for our background sprite
			var background_entity:IEntity = PBE.allocateEntity();
			background_entity.initialize	("background_entity");  
			FlyerGameHelper.createSpatialEntity 	( background_entity, position_point);
			
			
			//////////////////
			//	RENDER
			//	COMPONENTS
			//////////////////
			
			//	LOAD MC ASSET
			var swfSpriteSheetComponent : SWFSpriteSheetComponent = new SWFSpriteSheetComponent();
			FlyerGameHelper.loadMovieClipAsset (swfSpriteSheetComponent, PBFlyerGameResources.ASSETS_SWF, PBFlyerGameResources.MOVIE_CLIP_BACKGROUND);
			
			// 	USE ASSET TO RENDER
			var spriteSheetRenderer:SpriteSheetRenderer = new SpriteSheetRenderer();
			FlyerGameHelper.setupSpriteSheetRenderer (spriteSheetRenderer, swfSpriteSheetComponent, 0, zIndex_uint);
			
			//	ADD AS RENDERER
			background_entity.addComponent( spriteSheetRenderer, FlyerGameHelper.RENDER );

			
		}
	}
}