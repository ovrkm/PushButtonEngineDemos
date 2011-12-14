/***************************************************************************************************
 * Copyright (C) 2007 - 2010  : Rivello Multimedia Consulting
 * For more information email : presentations2010@RivelloMultimediaConsulting.com
 * For more information see   : http://www.RivelloMultimediaConsulting.com
 * 
 * This file and/or its constituents are licensed under the terms of the MIT license, 
 * which is included in the License.html file at the root directory of this SDK.
 ***************************************************************************************************/

//Marks the right margin of code *******************************************************************
package com.rmc.utils.pbe
{
	
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.pblabs.box2D.Box2DManagerComponent;
	import com.pblabs.box2D.Box2DSpatialComponent;
	import com.pblabs.box2D.PolygonCollisionShape;
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.core.ObjectType;
	import com.pblabs.engine.entity.IEntity;
	import com.pblabs.engine.entity.PropertyReference;
	import com.pblabs.engine.resource.SWFResource;
	import com.pblabs.rendering2D.SpriteSheetRenderer;
	import com.pblabs.rendering2D.spritesheet.SWFSpriteSheetComponent;
	import com.rmc.projects.pbflyergame.components.MoveByKeyboardInputComponent;
	
	import flash.geom.Point;
	
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : Holds Helper Functions and Common Constants</p>
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
	public class FlyerGameHelper
	{
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		//PUBLIC CONST
		/**
		 * ...
		 * 
		 */
		public static var SPATIAL				: String 	=	"Spatial";//TODO, RENAME "SPATIAL_COMPONENT"????, same with others here...
		public static var SPATIAL_POSITION		: String 	=	"@Spatial.position";//TODO, RENAME "SPATIAL_COMPONENT"????, same with others here...
		public static var SPATIAL_ROTATION		: String 	=	"@Spatial.rotation";//TODO, RENAME "SPATIAL_COMPONENT"????, same with others here...
		public static var SPATIAL_SIZE			: String 	=	"@Spatial.size";//TODO, RENAME "SPATIAL_COMPONENT"????, same with others here...
		
		/**
		 * ...
		 * 
		 */
		public static var RENDER					: String 	=	"Render";
		public static var RENDER_SPRITE_SHEET	: String 	=	"@Render.spriteSheet";
		public static var RENDER_SPRITE_INDEX	: String 	=	"@Render.spriteIndex";
		
		/**
		 * ...
		 * 
		 */
		public static var ANIMATION_IDLE				: String 	=	"idle";
		public static var ANIMATION_MOVE				: String 	=	"move";
		public static var ANIMATION_CHANGE_EVENT		: String 	=	"ANIMATION_CHANGE_EVENT";
		
		//todo, fix. I don't think this is working because its wrong after the '.'
		public static var CURRENT_ANIMATION_REFERENCE	: String 	=	"@" + MoveByKeyboardInputComponent.NAME + ".danimationName";
		
		/**
		 * ...
		 * 
		 */
		public static var ANIMATION_CONTROLLER : String 	=	"ANIMATION_CONTROLLER";
		
		/**
		 * ...
		 * 
		 */
		public static var CONTROLLER			: String 	=	"Controller";
		
		
		/**
		 * ...
		 * 
		 */
		public static var SCENE				: String 	=	"Scene";
		
		
		
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		/**
		 * PBE: This is a shortcut function to help simplify the creation of spatial components
		 * 
		 * @param aIEntity
		 * @param aPosition_point
		 * @param aSize_point
		 * 
		 * @return void
		 */
		// 
		public static function createSpatialEntity( aIEntity:IEntity, aPosition_point:Point, aSize_point:Point = null ):void
		{
			// Create our spatial component
			var box2DSpatialComponent:Box2DSpatialComponent = new Box2DSpatialComponent();
			
			// Do a named lookup to register our background with the scene spatial database
			box2DSpatialComponent.spatialManager = PBE.spatialManager as Box2DManagerComponent;
			
			// Set our background position in space
			box2DSpatialComponent.position = aPosition_point;
			
			// Set size 
			if (aSize_point != null) {
				box2DSpatialComponent.size = aSize_point;
			} 
			
			// Add 
			aIEntity.addComponent(box2DSpatialComponent,		FlyerGameHelper.SPATIAL);
		}
		
		
		
		/**
		 * PBE: Shortcut: Load a SWF MovieClip and register into component
		 * 
		 * @param aSWFSpriteSheetComponent
		 * @param aSWFURL_str
		 * @param aMovieClipName_str
		 * 
		 * @return void
		 */
		public static function loadMovieClipAsset ( aSWFSpriteSheetComponent : SWFSpriteSheetComponent, 
													aSWFURL_str : String, 
													aMovieClipName_str : String	) : void
		{
			aSWFSpriteSheetComponent.swf = PBE.resourceManager.load (aSWFURL_str, SWFResource) as SWFResource;
			aSWFSpriteSheetComponent.clipName = aMovieClipName_str;
		}
		
		/**
		 * PBE: Shortcut: Setup a Recently Loaded MovieClip as PBE visual entity
		 * 
		 * @param aaSpriteSheetRenderer
		 * @param aSWFSpriteSheetComponent
		 * @param aLayerIndex_uint
		 * @param aZIndex_uint
		 * 
		 * @return void
		 */
		public static function setupSpriteSheetRenderer ( 	aSpriteSheetRenderer 		: SpriteSheetRenderer, 
															aSWFSpriteSheetComponent 	: SWFSpriteSheetComponent, 
															aLayerIndex_uint			: uint,
															aZIndex_uint				: uint ) : void
		{
			aSpriteSheetRenderer.positionProperty 	= new PropertyReference (FlyerGameHelper.SPATIAL_POSITION);
			aSpriteSheetRenderer.rotationProperty 	= new PropertyReference (FlyerGameHelper.SPATIAL_ROTATION);
			aSpriteSheetRenderer.scene = PBE.scene;
			aSpriteSheetRenderer.layerIndex = aLayerIndex_uint;
			aSpriteSheetRenderer.zIndex = aZIndex_uint;
			aSpriteSheetRenderer.scale = new Point (1, 1);
			aSpriteSheetRenderer.spriteSheet = aSWFSpriteSheetComponent;
		}
		
		
		/**
		 * PBE: Shortcut: Help simplify the creation of spatial components
		 * 
		 * @param aIEntity The entity (to be filled with components) to create
		 * @param aCollisionType_str The string which defines 'obstacle' or 'flyer' so that objects WITHIN a group don't collide with each other
		 * @param aCollidesWithCollisionTypes_array
		 * 
		 * @return void
		 */
		public static function enableCollisionDetection( aIEntity:IEntity, aCollisionType_str : String, aCollidesWithCollisionTypes_array : Array, aIsMovedAutomaticallyByCollision_boolean : Boolean):void
		{
			
			var box2DSpatialComponent : Box2DSpatialComponent = aIEntity.lookupComponentByType(Box2DSpatialComponent) as Box2DSpatialComponent;
			
			var polygonCollisionShape:PolygonCollisionShape = new PolygonCollisionShape();
			polygonCollisionShape.vertices = new Array();
			polygonCollisionShape.vertices.push(new Point(-1, -1));
			polygonCollisionShape.vertices.push(new Point(1, -1));
			polygonCollisionShape.vertices.push(new Point(1, 1));
			polygonCollisionShape.vertices.push(new Point(-1, 1));
			
			box2DSpatialComponent.collisionShapes 		= new Array();
			box2DSpatialComponent.collisionShapes.push 	(polygonCollisionShape); 
			
			box2DSpatialComponent.collisionType 		= new ObjectType(aCollisionType_str);
			box2DSpatialComponent.collidesWithTypes 	= new ObjectType(aCollidesWithCollisionTypes_array[0]);
			box2DSpatialComponent.canMove 				= aIsMovedAutomaticallyByCollision_boolean;
			box2DSpatialComponent.canSleep 				= false;
			box2DSpatialComponent.canRotate 			= false;
			box2DSpatialComponent.size 					= new Point(100, 100); 
			box2DSpatialComponent.spatialManager		= PBE.spatialManager as Box2DManagerComponent;
		}
		
		
	}
}
