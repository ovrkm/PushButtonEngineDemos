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

			if (positionDeltaX_num < 0) {
				//	MOVING LEFT
				rotation = -90;
			} else if (positionDeltaX_num > 0) {
				//	MOVING RIGHT
				rotation = 90;
			}
			
			if (positionDeltaY_num < 0) {
				//	MOVING UP
				rotation = 0;
			} else if (positionDeltaY_num > 0) {
				//	MOVING DOWN
				rotation = 180;
			}

			rotation = 100*Math.random();
			//	UPDATE PREVIOUS POSITION
			_positionPrevious_point = position.clone();
		}
		
		
	}
}

