﻿/**
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
// Marks the right margin of code *******************************************************************package com.rmc.projects.pbe2.pbflyergame.components{	//--------------------------------------	//  Imports	//--------------------------------------	import com.rmc.projects.pbe2.pbflyergame.components.movement.AbstractMoverComponent;
			// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class looks for win/loss states</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */	public class GameOverComponent extends AbstractMoverComponent	{						//--------------------------------------		//  Properties		//--------------------------------------		//PUBLIC CONSTANTS				//--------------------------------------		//  Constructor		//--------------------------------------		public function GameOverComponent ()		{			//SUPER			super (); 						//VARIABLES						//PROPERTIES						//METHODS						//EVENTS								}						//--------------------------------------		//  Methods		//--------------------------------------		//	PUBLIC				//--------------------------------------		//  Events		//--------------------------------------				//Event Handlers		/**		 * Handles the event: 'Tick' to update facing direction		 * 		 * @return void		 */		override public function onTick () :void		{						if (position.y < FlyerGame.STAGE_VICTORY_Y_POSITION) {				FlyerGame.getInstance().doEndGameWithWin();			}					}			}}