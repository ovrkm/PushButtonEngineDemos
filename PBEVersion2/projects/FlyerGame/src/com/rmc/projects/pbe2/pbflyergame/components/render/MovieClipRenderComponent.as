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
package com.rmc.projects.pbe2.pbflyergame.components.render
{
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.pblabs.core.PBComponent;
	import com.pblabs.time.AnimatedComponent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>	This class renders <code>MovieClip</code> symbols. 
	 * 		When the embed tag is used AS3 converts one framed 
	 * 		MovieClips and Sprites to Sprites. It converts 2+ 
	 * 		framed MovieClips to MovieClips</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class MovieClipRenderComponent extends DisplayObjectRenderComponent
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER / SETTER
		// PRIVATE
		/**
		 * Describe this member. 
		 * 
		 */			
		public function get movieClipClass () 					: Class 	{ return super.displayObjectClass; }
		public function set movieClipClass (aValue : Class) 	: void 		
		{
			super.displayObjectClass = aValue;
		}
		
		/**
		 *  Keep as Sprite (one frame MC's are imported as sprites by Flash. No control over that fact)
		 */		
		public function get movieClip () 						: Sprite 	{ return super.displayObject as Sprite; }
		
		/**
		 *  PROXY: gotoAndPlay()
		 */		
		public function gotoAndPlay (aFrame_object: Object, aScene_str : String = null) : void 
		{
			
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				(movieClip as MovieClip).gotoAndPlay(aFrame_object, aScene_str);
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
		}
		
		
		/**
		 *  PROXY: gotoAndStop()
		 */		
		public function gotoAndStop (aFrame_object: Object, aScene_str : String = null) : void 
		{
			
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				(movieClip as MovieClip).gotoAndStop(aFrame_object, aScene_str);
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
		}
		
		/**
		 *  PROXY: play()
		 */		
		public function play () : void 
		{
			
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				(movieClip as MovieClip).play();
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
		}
		
		
		/**
		 *  PROXY: stop()
		 */		
		public function stop () : void 
		{
			
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				(movieClip as MovieClip).stop();
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
		}
		
		/**
		 *  
		 */		
		public function get currentFrame () 					: int 	{ 
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				return (movieClip as MovieClip).currentFrame
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
		}
		public function set currentFrame (aValue : int) : void 	{ 
			//IF ITS AN MC (NOT A SPRITE, THEN ALLOW IT)
			if (movieClip is MovieClip) {
				//NOTE: ISPLAYING IS FLASH PLAYER 10 ONLY (NOT BEFORE)
				if ((movieClip as MovieClip).isPlaying) {
					(movieClip as MovieClip).gotoAndPlay (aValue);
				} else {
					(movieClip as MovieClip).gotoAndStop (aValue);
					
				}
			} else {
				throw new Error ("movieClip is not a MovieClip. It is of type : " + movieClip);
			}
			
			return 
		}
		
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MovieClipRenderComponent(aMovieClip_class : Class):void
		{
			// SUPER
			super(aMovieClip_class);
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			
			// METHODS
			
			
		}
		
		
		/**
		 *  
		 * 
		 * @return void
		 * 
		 */
		override protected function _drawChild() : void 
		{
			
			super._drawChild();
			//ONE FRAME WILL BE A 'SPRITE' AND 2+ FRAMES WILL BE A 'MOVIECLIP'
			if (movieClip is MovieClip) {
				(movieClip as MovieClip).gotoAndStop(0);
			}
		}
		
		
	}
}