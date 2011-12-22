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
package com.rmc.projects.pbe2.pbflyergame.components.movement 
{

	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.pbe2.pbflyergame.components.spatial.SpatialComponent;
	
	import flash.geom.Point;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class  Change rotation of the asset to match the direction of travel </p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class FaceForwardComponent extends AbstractMoverComponent
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC CONSTANTS
		
		//PUBLIC
		/**
		 * Store position for calculating angle of movement
		 * 
		 */
		private var _positionPrevious_point : Point;
		
		/**
		 *  
		 */		
		public function get spatialComponent () 					: SpatialComponent 	{ return owner.lookupComponent("spatial"); }
		
		//PRIVATE
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * Setup repeating 'thinking'
		 * 
		 */
		public function FaceForwardComponent () : void 
		{
			
			//SUPER
			super ();
			
			//PROPERTIES
			_positionPrevious_point = new Point (0,0); //WILL BE OVERWRITTEN
			
			//METHODS
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------		

		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		//Event Handlers
		/**
		 * Handles the event: 'Tick' to update facing direction
		 * 
		 * @return void
		 */
		override public function onTick () :void
		{
			
			var positionDeltaX_num : Number = position.x - _positionPrevious_point.x;
			var positionDeltaY_num : Number = position.y - _positionPrevious_point.y;
			var nextRotation_num : Number;
			
			if (positionDeltaX_num < 0) {
				//	MOVING LEFT
				nextRotation_num = -90;
			} else if (positionDeltaX_num > 0) {
				//	MOVING RIGHT
				nextRotation_num = 90;
			}
			
			if (positionDeltaY_num < 0) {
				//	MOVING UP
				nextRotation_num = 0;
			} else if (positionDeltaY_num > 0) {
				//	MOVING DOWN
				nextRotation_num = 180;
			}

			//CREATE SEPARATE FUNCTION - DUE TO ISSUE BELOW
			if (nextRotation_num) {
				_updateRotationOnSpatial(nextRotation_num);
			}
			
			//	UPDATE PREVIOUS POSITION
			_positionPrevious_point = position.clone();
		}
		
		
		
		private function _updateRotationOnSpatial(aNextRotation_num : Number):void
		{
			//1. IDEALLY THIS WILL WORK, BUT BINDING IS FAILING FOR ME. NOT SURE WHY
			//rotation = aNextRotation_num;
			
			//2. SO I USE THIS, WHICH IS (MORE COUPLED = BAD) ALTERNATIVE
			spatialComponent.rotation = aNextRotation_num;
			
		}		
		
	}
}

