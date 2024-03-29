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
	import com.pblabs.box2D.CollisionEvent;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.ITickedObject;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : Listen for collisions (From Box2DSpatialManager) and handle reactions.</p>
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
	public class CollisionDetectComponent extends TickedComponent implements ITickedObject
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC CONSTANTS
		/**
		 * Name of Component
		 */
		public static const NAME : String	 = "CollisionDetectComponent";
		
		//PRIVATE
		/**
		 * Quick Component Reference
		 */
		private function get _gameOverComponent () 	: GameOverComponent 	{ 	return owner.lookupComponentByType(GameOverComponent) as GameOverComponent; 		}

		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function CollisionDetectComponent ()
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
		 * Handles the event: ADD 
		 * 
		 * @return void
		 */
		protected override function onAdd() : void
		{
			super.onAdd();
			owner.eventDispatcher.addEventListener(CollisionEvent.COLLISION_EVENT, onCollisionEvent);		
		}
		
		/**
		 * Handles the event: Remove 
		 * 
		 * @return void
		 */
		protected override function onRemove() : void
		{
			super.onRemove();
			owner.eventDispatcher.removeEventListener(CollisionEvent.COLLISION_EVENT, onCollisionEvent);
		}
		
		
		/**
		 * Handles the event: CollisionEvent.COLLISION_EVENT 
		 * 
		 * @return void
		 */
		private function onCollisionEvent(aEvent:CollisionEvent) : void
		{
			//trace ("Collision : " + aEvent.collidee.owner.name + " and " + aEvent.collider.owner.name);
			_gameOverComponent.doLoss();
		}
		
	}
}

