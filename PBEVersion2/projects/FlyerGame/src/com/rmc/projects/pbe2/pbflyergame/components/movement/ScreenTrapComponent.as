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
	import flash.display.Stage;
	

	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class Keep the owner entity within the screen bounds</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class ScreenTrapComponent extends AbstractMoverComponent
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC
		
		
		[Inject]
		public var stage:Stage;

		//PRIVATE
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function ScreenTrapComponent ()
		{
			//SUPER
			super (); 
			
			//VARIABLES
			
			//PROPERTIES
			
			//METHODS
			
			//EVENTS
			
			
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		//Event Handlers
		/**
		 * Handles the event: 'Tick' 
		 * 
		 * @return void
		 */
		override public function onTick () : void
		{
			//	CHECK PROPERTIES
			
			//	CHECK BOUNDS: HORIZONTAL
			if (position.x + size.x > stage.stageWidth) {
				position.x = stage.stageWidth - size.x;
			} else if (position.x - size.x < stage.x) {
				position.x = stage.x + size.x;
			}

			//	CHECK BOUNDS: VERTICAL
			if (position.y + size.y > stage.stageHeight) {
				position.y = stage.stageHeight - size.y;
			} else if (position.y - size.y < stage.y) {
				position.y = stage.y + size.y;
			}
			
			
		}
		
		
	}
}

