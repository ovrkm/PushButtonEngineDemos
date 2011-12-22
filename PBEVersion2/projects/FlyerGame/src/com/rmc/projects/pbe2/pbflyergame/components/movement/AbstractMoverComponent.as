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
	
	// --------------------------------------
	// Imports
	// --------------------------------------
	import com.pblabs.core.PBComponent;
	import com.pblabs.time.ITicked;
	import com.pblabs.time.TimeManager;
	
	import flash.geom.Point;
	
	// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class holds common properties for components that help objects move around</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class AbstractMoverComponent extends PBComponent implements ITicked
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER / SETTER
		
		// PUBLIC
		/**
		 * Describe this member.
		 * 
		 */
		[Inject]
		public var timeManager:TimeManager;
		
		/**
		 * Describe this member.
		 * 
		 */
		public var position:Point;
		public var positionReference:String;
		
		/**
		 * Describe this member.
		 * 
		 */
		public var sizeReference: String;
		public var size:Point;
		
		/**
		 * Describe this member.
		 * 
		 */
		public var rotationReference: String;
		public var rotation:Number;
		
		
		// PRIVATE
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function AbstractMoverComponent()
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			positionReference 	= "@spatial.position";
			sizeReference		= "@spatial.size";
			rotationReference 	= "@spatial.rotation";
			
			// METHODS
			
		}
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		
		// PRIVATE
		/**
		 * Describe this member. 
		 * 
		 * @return void
		 * 
		 */
		override protected function onAdd():void
		{

			super.onAdd();
			timeManager.addTickedObject(this);
			addBinding("rotation", 	rotationReference);
			addBinding("size", 		sizeReference);
			addBinding("position", 	positionReference);
		}
		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		/**
		 * Dispatches the event: <code>Event.SAMPLE</code>
		 *  
		 * @param aEvent : <code>Event</code>
		 * 
		 * return void
		 * 
		 */
		public function onTick():void
		{
			applyBindings();
		}
		
		/**
		 * Dispatches the event: <code>Event.SAMPLE</code>
		 *  
		 * @param aEvent : <code>Event</code>
		 * 
		 * return void
		 * 
		 */
		override protected function onRemove():void
		{
			timeManager.removeTickedObject(this);
			removeBinding("position", 	positionReference);
			removeBinding("size", 		sizeReference);
			removeBinding("rotation",	rotationReference);
			super.onRemove();
		}
	}
}