	
/***************************************************************************************************
 * Copyright (C) 2007 - 2010  : Rivello Multimedia Consulting
 * For more information email : presentations2010@RivelloMultimediaConsulting.com
 * For more information see   : http://www.RivelloMultimediaConsulting.com
 * 
 * This file and/or its constituents are licensed under the terms of the MIT license, 
 * which is included in the License.html file at the root directory of this SDK.
 ***************************************************************************************************/

//Marks the right margin of code *******************************************************************
package com.rmc.projects.pbflyergame.components
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.core.InputKey;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.rendering2D.AnimationController;
	import com.rmc.projects.pbflyergame.PBFlyerGameResources;
	import com.rmc.utils.pbe.FlyerGameHelper;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : The 'brain' of the obstacles (blimps and biplanes)
	 * 				This controls the movement and 'thinking'.</p>
	 * 
	 * <p>DATE    : May 02, 2010</p>
	 * <p>AUTHOR  : Samuel Asher Rivello</p>
	 * <p>CONTACT : presentations2010@RivelloMultimediaConsulting.com</p>
	 * 
	 * @example Here is a code example.  
	 * <listing version="3.0" >
	 * 	//Code example goes here.
	 * </listing>
	 *
	 * <span class="hide">Any hidden comments go here.</span>
	 *
	 */
	public class MoveByKeyboardInputComponent extends TickedComponent implements ITickedObject
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//SETTER/GETTERS
		/**
		 * ...
		 * 
		 */		
		public function get isPaused () 					: Boolean 	{ 	return _isPaused_boolean; 		}
		public function set isPaused (aValue : Boolean) 	: void 		{ 
			if (_isPaused_boolean != aValue) {
				_isPaused_boolean = aValue; 
				if (_isPaused_boolean) {
					PBE.processManager.timeScale = 0;
				} else {
					PBE.processManager.timeScale = 1;
				}
			}
		}
		private var _isPaused_boolean : Boolean;
		
		
		//PUBLIC CONSTANTS
		/**
		 * Name of Component
		 */
		public static const NAME : String	 = "MoveByKeyboardInputComponent";
		
		//PRIVATE
		/**
		 * Amount to move each frame
		 */
		private var _movementRadius_uint : uint = 50;
		
		/**
		 * Property Reference: The position of the entity
		 */
		public var _position_propertyreference:PropertyReference;
		
		/**
		 * The current position
		 */
		private var _position_point : Point;
		
		/**
		 * Quick Component Reference: GameOverComponent
		 */
		private function get _gameOverComponent () 	: GameOverComponent 	{ 	return owner.lookupComponentByType(GameOverComponent) as GameOverComponent; 		}
		
		/**
		 * Quick Component Reference: AnimationController
		 */
		private function get _animationController () 	: AnimationController 	{ 	return owner.lookupComponentByType(AnimationController) as AnimationController; 		}
		
		/**
		 * Quick Component Reference: AnimationController
		 */
		public function get animationName () 	: String 	{ 	return _animationName_str; 		}
		private var _animationName_str : String;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * ...
		 * 
		 * <span class="hide">Any hidden comments go here.</span>
		 *
		 */
		public function MoveByKeyboardInputComponent ()
		{
			//SUPER
			super (); 
			
			//VARIABLES
			
			//PROPERTIES
			_position_propertyreference = new PropertyReference (FlyerGameHelper.SPATIAL_POSITION);
			isPaused = false;
			
			//METHODS
			
			//EVENTS
			
			
		}
		
		
		//PRIVATE
		/**
		 * DO: 
		 * 
		 * @return void
		 */
		private function _doPlayAnimationOnce () :void
		{
			_animationName_str = FlyerGameHelper.ANIMATION_MOVE;
			owner.eventDispatcher.dispatchEvent( new Event (FlyerGameHelper.ANIMATION_CHANGE_EVENT));
			
			//PLAY SOUND
			PBE.soundManager.play( PBFlyerGameResources.MOVE_FLYER_SOUND);
		}
		
		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		//Event Handlers
		/**
		 * Handles the event: Add 
		 * 
		 * @return void
		 */
		protected override function onAdd() : void
		{
			super.onAdd();
			PBE.mainStage.addEventListener (MouseEvent.MOUSE_DOWN, _onMouseDown);
			PBE.mainStage.addEventListener (KeyboardEvent.KEY_DOWN, _onKeyDown);
		}
		
		/**
		 * Handles the event: Remove 
		 * 
		 * @return void
		 */
		protected override function onRemove() : void
		{
			super.onRemove();
			PBE.mainStage.removeEventListener (MouseEvent.MOUSE_DOWN, _onMouseDown);
			PBE.mainStage.removeEventListener (KeyboardEvent.KEY_DOWN, _onKeyDown);
		}
		

		/**
		 * Handles the event: 'Tick' to update facing direction
		 * 
		 * @return void
		 */
		override public function onTick (aDeltaTime_num : Number ) :void
		{
			//NOTHING NEEDED TODO HERE EVERY FRAME
		}

		
		/**
		 * Handles the event: KeyboardEvent.KEY_DOWN
		 * 
		 * @return aEvent
		 */
		public function _onKeyDown (aEvent : KeyboardEvent) :void
		{
			if (!isPaused) {
				
				// Get references for our spatial position.
				_position_point = owner.getProperty(_position_propertyreference);
				
				//	MOVE UP / DOWN
				if (PBE.isKeyDown(InputKey.UP)) {
					_position_point.y -= _movementRadius_uint;
					_doPlayAnimationOnce ();
					
				} else if (PBE.isKeyDown(InputKey.DOWN) ) {
					_position_point.y += _movementRadius_uint;
					_doPlayAnimationOnce ();
					
				//	MOVE LEFT/RIGHT
				} else if (PBE.isKeyDown(InputKey.RIGHT) ) {
					_position_point.x += _movementRadius_uint;
					_doPlayAnimationOnce ();
					
				} else if (PBE.isKeyDown(InputKey.LEFT) ) {
					_position_point.x -= _movementRadius_uint;
					_doPlayAnimationOnce ();
					
				}    

				
				//	UPDATE PROPERTY REFERENCE(S)
				owner.setProperty(_position_propertyreference, _position_point);
			}
			
			
			//	PAUSE / UNPAUSE
			if (PBE.isKeyDown(InputKey.SPACE)) {
				if (!isPaused) {
					isPaused = true;
				} else {
					isPaused = false;
				}
			}
		}

		
		/**
		 * Handles the event: The user clicks the Mouse.  
		 * If its near the 'reset' text then reset the game.
		 * 
		 * @param aEvent MouseEvent
		 * 
		 * @return void
		 */
		private function _onMouseDown ( aEvent : MouseEvent ) :void
		{
			//TODO, USE A VARIABLE NOT '500'
			if (aEvent.stageY > 500) {
				_gameOverComponent.doResetGame ();
			}
			
		}

		
		
	}
}

