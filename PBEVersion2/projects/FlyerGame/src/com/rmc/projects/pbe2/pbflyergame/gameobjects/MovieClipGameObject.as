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
package com.rmc.projects.pbe2.pbflyergame.gameobjects
{

	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.pblabs.core.PBGameObject;
	import com.pblabs.simpler.SimpleSpriteRenderer;
	import com.pblabs.simplest.SimplestSpatialComponent;
	
	import flash.geom.Point;
	import com.rmc.projects.pbe2.pbflyergame.components.spatial.SpatialComponent;
	import com.rmc.projects.pbe2.pbflyergame.components.render.MovieClipRenderComponent;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class wraps common components</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class MovieClipGameObject extends PBGameObject
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER / SETTER
		
		/**
		 * Describe this member.
		 * 
		 */
		public var spatial:SpatialComponent;
		
		/**
		 * Describe this member.
		 * 
		 */
		public var render:MovieClipRenderComponent;

		// PRIVATE

		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function MovieClipGameObject (aMovieClipClass : Class):void {
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			spatial = new SpatialComponent();
			addComponent(spatial, "spatial");
			render = new MovieClipRenderComponent(aMovieClipClass);
			addComponent(render, "render");
			
			// METHODS
			
		}
		
			

			
		}
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		/**
		 * Describe this member. 
		 * 
		 * @return void
		 * 
		 */
		override public function initialize():void {
			
			super.initialize();
			
			//CORRECT THE SIZE TO MATCH THE CLIP
			
			//TODO. WHY IS width always 0? The current solution works, but not sure why its needed
			if (render.movieClip.width > 0) {
				spatial.size = new Point (render.movieClip.width, render.movieClip.height);
			} else {
				spatial.size = new Point (render.movieClip["measuredWidth"], render.movieClip["measuredHeight"]); //render.movieClip, render.movieClip.height);
			}
			
		}
		
	}
	

		
		
}