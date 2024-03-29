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
	import com.pblabs.engine.PBE;
	import com.pblabs.engine.components.TickedComponent;
	import com.pblabs.engine.core.ITickedObject;
	import com.pblabs.engine.entity.PropertyReference;
	import com.rmc.projects.pbflyergame.PBFlyerGame;
	import com.rmc.projects.pbflyergame.PBFlyerGameResources;
	import com.rmc.utils.pbe.FlyerGameHelper;
	
	import flash.geom.Point;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : Handles the Victory and Loss Within the Game</p>
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
	public class GameOverComponent extends TickedComponent implements ITickedObject
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		//PUBLIC CONSTANTS
		/**
		 * Name of Component
		 */
		public static const NAME : String	 = "GameOverComponent";
		
		//PRIVATE
		/**
		 * Property Reference: The position of the entity
		 */
		public var _position_propertyreference:PropertyReference;
		
		/**
		 * Property Reference: The size of the entity
		 */
		private var _size_propertyreference : PropertyReference;
		
		/**
		 * The current position
		 */
		private var _position_point : Point;
		
		/**
		 * The size position
		 */
		private var _size_point : Point;
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		public function GameOverComponent ()
		{
			//SUPER
			super (); 
			
			//VARIABLES
			
			//PROPERTIES
			_position_propertyreference = new PropertyReference (FlyerGameHelper.SPATIAL_POSITION);
			_size_propertyreference 	= new PropertyReference (FlyerGameHelper.SPATIAL_SIZE);
			
			//METHODS
			
			//EVENTS
			
			
		}
		
		
		//--------------------------------------
		//  Methods
		//--------------------------------------
		//	PUBLIC
		/**
		 * Do: Win
		 * 
		 * @return void
		 */
		public function doWin () : void
		{
			//PLAY SOUND
			PBE.soundManager.play( PBFlyerGameResources.WIN_FLYER_SOUND);
			
			_doEndGame();
		}
		
		/**
		 * Do: Loss
		 * 
		 * @return void
		 */
		public function doLoss () : void
		{
			//PLAY SOUND
			PBE.soundManager.play( PBFlyerGameResources.LOSE_FLYER_SOUND);
			
			_doEndGame();
		}
		
		/**
		 * Do: Reset The Game
		 * 
		 * @return void
		 */
		public function doResetGame () : void
		{
			//	THERE IS A BUG WHEN DOING THIS RESTART, SO IT IS DISABLED
			//(PBE.mainClass as PBFlyerGame).restartGame();
			
		}
		
		//	PRIVATE
		/**
		 * Do: End Game
		 * 
		 * @return void
		 */
		private function _doEndGame () : void
		{
			PBE.processManager.stop();
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
			//NEEDED?
		}
		
		/**
		 * Handles the event: Remove 
		 * 
		 * @return void
		 */
		protected override function onRemove() : void
		{
			super.onRemove();
			//NEEDED?
		}

		/**
		 * Handles the event: 'Tick' to update facing direction
		 * 
		 * @return void
		 */
		override public function onTick (aDeltaTime_num : Number ) :void
		{
			// Get references for our spatial position.
			_position_point = owner.getProperty (_position_propertyreference);
			_size_point 	= owner.getProperty (_size_propertyreference);
			
			if (_position_point.y < 60) {
				doWin();
			}
			
		}

		
	}
}

