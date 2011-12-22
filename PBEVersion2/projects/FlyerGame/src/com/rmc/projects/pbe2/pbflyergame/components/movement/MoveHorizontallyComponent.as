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
	

	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class is the 'brain' of the obstacles (blimps and biplanes)
	 * 				This controls the movement and 'thinking'.</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class MoveHorizontallyComponent extends AbstractMoverComponent
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC CONSTANTS
		
		//PUBLIC
		/**
		 * Fun Property (Experiment with new values): Horizontal direction (Try -1 or 1)
		 */
		public var horizontalDirection_int:int = 1; 
		
		/**
		 * Horizontal speed (Try 1 to 100). To be overwritten from outside
		 */
		public var horizontalSpeed_num:int = 0; 
		
		//PRIVATE
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * Setup repeating 'thinking'
		 * 
		 */
		public function MoveHorizontallyComponent () : void 
		{
			
			//SUPER
			super ();
			
			//PROPERTIES
			
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
		 * Handles the event: Think about position and movement
		 * 
		 * @return void
		 */
		override public function onTick () :void
		{
			position.x += horizontalDirection_int * horizontalSpeed_num/2;

		}
		
		
	}
}

	