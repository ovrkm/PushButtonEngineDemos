/***************************************************************************************************
 * Copyright (C) 2007 - 2010  : Rivello Multimedia Consulting
 * For more information email : presentations2010@RivelloMultimediaConsulting.com
 * For more information see   : http://www.RivelloMultimediaConsulting.com
 * 
 * This file and/or its constituents are licensed under the terms of the MIT license, 
 * which is included in the License.html file at the root directory of this SDK.
 ***************************************************************************************************/

//Marks the right margin of code *******************************************************************
package com.rmc.projects.pbe2.pbflyergame.components
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.rmc.projects.pbe2.pbflyergame.components.movement.AbstractMoverComponent;
	import com.rmc.projects.pbe2.pbflyergame.gameobjects.MovieClipGameObject;
	
	import flash.geom.Point;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>This class Listen for collisions (From Box2DSpatialManager) and handle reactions. </p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */
	public class CollisionDetectComponent extends AbstractMoverComponent
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		// PUBLIC GETTER/SETTER
		/**
		 *  
		 */		
		private var _collideType : String;
		public function get collideType () 					: String 	{ return _collideType; }
		public function set collideType (aValue : String) 	: void 		{ _collideType = aValue; }
		
		/**
		 *  
		 */		
		private var _collidesWithType : String;
		public function get collidesWithType () 					: String 	{ return _collidesWithType; }
		public function set collidesWithType (aValue : String) 	: void 		{ _collidesWithType = aValue; }
		
		/**
		 *  
		 */		
		private var _collisionDetectionRadius : Number;
		public function get collisionDetectionRadius () 					: Number 	{ return _collisionDetectionRadius; }
		public function set collisionDetectionRadius (aValue : Number) 	: void 		{ _collisionDetectionRadius = aValue; }
		/**
		 *  
		 */		
		private var _isCheckingCollisions : Boolean;
		public function get isCheckingCollisions () 					: Boolean 	{ return _isCheckingCollisions; }
		public function set isCheckingCollisions (aValue : Boolean) 	: void 		{ _isCheckingCollisions = aValue; }
		
		
		// PRIVATE

		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function CollisionDetectComponent ()
		{
			//SUPER
			super (); 
			
			//VARIABLES
			
			//PROPERTIES
			collidesWithType = "";
			collideType		 = "";
			
			//METHODS
			
			//EVENTS
			
			
		}
		
		// --------------------------------------
		// Methods
		// --------------------------------------
		// PUBLIC
		
		// PRIVATE
		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		// Event Handlers
		/**
		 * Handles the event: 'Tick' to update facing direction
		 * 
		 * @return void
		 */
		override public function onTick () :void
		{
			if (_isCheckingCollisions) {
				var movieClipGameObject : MovieClipGameObject;
				var collisionDetectComponent : CollisionDetectComponent;
				for (var i : uint = 0; i < FlyerGame._root_pbset.length; i++) {
					movieClipGameObject = FlyerGame._root_pbset.getPBObjectAt(i) as MovieClipGameObject;
					collisionDetectComponent = movieClipGameObject.lookupComponent("CollisionDetectComponent");
				
					//
					if (collisionDetectComponent && collidesWithType == collisionDetectComponent.collideType) {
						if (Point.distance( (owner as MovieClipGameObject).spatial.position , movieClipGameObject.spatial.position)  < _collisionDetectionRadius) {
							onCollision (movieClipGameObject);
						}
					} 
				}
			}
		}
		
		/**
		 * Handles the event: When there is detection
		 * 
		 * @return void
		 */
		public function onCollision (currentlyHitting_movieClipGameObject : MovieClipGameObject) :void
		{
			FlyerGame.getInstance().doEndGameWithLoss();
		}
		
		
	}
}

