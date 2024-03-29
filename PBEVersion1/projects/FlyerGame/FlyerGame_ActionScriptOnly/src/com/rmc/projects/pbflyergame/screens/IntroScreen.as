/***************************************************************************************************
 * Copyright (C) 2007 - 2010  : Rivello Multimedia Consulting
 * For more information email : presentations2010@RivelloMultimediaConsulting.com
 * For more information see   : http://www.RivelloMultimediaConsulting.com
 * 
 * This file and/or its constituents are licensed under the terms of the MIT license, 
 * which is included in the License.html file at the root directory of this SDK.
 ***************************************************************************************************/

//Marks the right margin of code *******************************************************************
package com.rmc.projects.pbflyergame.screens
{
	//--------------------------------------
	//  Imports
	//--------------------------------------
	import com.pblabs.screens.BaseScreen;
	import com.pblabs.screens.ScreenManager;
	import com.rmc.projects.pbflyergame.PBFlyerGameResources;
	
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	
	//--------------------------------------
	//  Class
	//--------------------------------------
	/**
	 * <p>CLASS   : </p>
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
	public class IntroScreen extends BaseScreen
	{		
		
		//--------------------------------------
		//  Properties
		//--------------------------------------
		
		//--------------------------------------
		//  Constructor
		//--------------------------------------
		/**
		 * 
		 */
		public function IntroScreen ()
		{
			//SUPER
			super (); 
			
			//VARIABLES
			
			//PROPERTIES
			
			//METHODS
			
			//EVENTS
			addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			
			
		}
		
		//--------------------------------------
		//  Methods
		//--------------------------------------		

		
		//--------------------------------------
		//  Events
		//--------------------------------------		
		//Event Handlers
		/**
		 * Handles the event: SHOW
		 * 
		 */
		override public function onShow () : void 
		{				
			addChild( new PBFlyerGameResources.MOVIE_CLIP_BACKGROUND_MC ());
			
			var textField : TextField = new TextField ();
			textField.width = 500;
			textField.height = 400;
			textField.multiline = true;
			textField.wordWrap = true;
			textField.htmlText = "<P ALIGN='CENTER'><FONT SIZE='50'>Click Anywhere to Play</FONT><BR><FONT SIZE='20'>Use The Arrow Keys to Move to the Top of the Screen. Avoid Hitting Obstacles.  Refresh this webpage to restart.</FONT></P>";
			textField.selectable = false;
			textField.x = 400 - textField.width/2;
			textField.y = 300;
			addChild(textField);

		}
		
		
		/**
		 * Handles the event: HIDE
		 * 
		 */
		override public function onHide () : void 
		{				
			
		}
		
		/**
		 * Handles the event: MouseEvent.MOUSE_DOWN
		 * 
		 */
		private function _onMouseDown (aEvent : MouseEvent) : void 
		{				
			ScreenManager.instance.goto("game_screen");
		}
		
		
	}
}