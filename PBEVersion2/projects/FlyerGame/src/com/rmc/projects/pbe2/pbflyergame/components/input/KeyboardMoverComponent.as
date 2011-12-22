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
package com.rmc.projects.pbe2.pbflyergame.components.input
{
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.pblabs.input.KeyboardKey;
	import com.pblabs.input.KeyboardManager;
	import com.pblabs.time.TimeManager;
	import com.rmc.projects.pbe2.pbflyergame.components.movement.AbstractMoverComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.render.MovieClipRenderComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.spatial.SpatialComponent;
	
	import flash.geom.Point;

	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class MOVES based on keyboard input</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class KeyboardMoverComponent extends AbstractMoverComponent
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//SETTER/GETTERS
		/**
		 *  
		 */		
		public function get movieClipRenderComponent () 			: MovieClipRenderComponent 	{ return owner.lookupComponent("render"); }
		
		/**
		 *  
		 */		
		public function get spatialComponent () 					: SpatialComponent 	{ return owner.lookupComponent("spatial"); }
		
		//PUBLIC
		[Inject]
		public var keyboardManager:KeyboardManager;
		
		
		//PRIVATE
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function KeyboardMoverComponent()
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			
			// METHODS
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------	
		//PRIVATE
		/**
		 * DO: 
		 * 
		 * @return void
		 */
		private function _doPlayAnimationOnce () :void
		{
			//ANIMATE THE LIGHTS ON THE SHIP
			if (movieClipRenderComponent.currentFrame == 0) {
				movieClipRenderComponent.gotoAndStop(1);
			} else {
				movieClipRenderComponent.gotoAndStop(0);
				
			}
			
			//PLAY SOUND
			FlyerGame.getInstance().playMoveFlyerSound();

		}

		
		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		//Event Handlers
		/**
		 * Handles the event: KeyboardEvent.KEY_DOWN
		 * 
		 * @return aEvent
		 */
		override public function onTick () :void
		{
			if (!FlyerGame.getInstance().isPaused) {
				
				//	MOVE UP / DOWN
				if (keyboardManager.isKeyDown(KeyboardKey.UP.keyCode) ) {
					position.y -= FlyerGame.FLYER_MOVEMENT_RADIUS;
					_doPlayAnimationOnce ();
					
				} else if (keyboardManager.isKeyDown(KeyboardKey.DOWN.keyCode) ) {
					position.y += FlyerGame.FLYER_MOVEMENT_RADIUS;
					_doPlayAnimationOnce ();
					
					//	MOVE LEFT/RIGHT
				} else if (keyboardManager.isKeyDown(KeyboardKey.RIGHT.keyCode) ) {
					position.x += FlyerGame.FLYER_MOVEMENT_RADIUS;
					_doPlayAnimationOnce ();
					
				} else if (keyboardManager.isKeyDown(KeyboardKey.LEFT.keyCode) ) {
					position.x -= FlyerGame.FLYER_MOVEMENT_RADIUS;
					_doPlayAnimationOnce ();
					
				}   
				
				

			}

		}
		
	}
}