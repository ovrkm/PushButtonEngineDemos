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
// Marks the right margin of code *******************************************************************package com.rmc.projects.pbe2.pbflyergame.resources{	//--------------------------------------	//  Imports	//--------------------------------------		import flash.media.Sound;	import flash.sampler.Sample;		import mx.resources.ResourceBundle;
			// --------------------------------------
	// Class
	// --------------------------------------
	/**
	 * <p>This class holds all artwork and sounds</p>
	 * 
	 * <p>AUTHOR  		: Samuel Asher Rivello</p>
	 * <p>COMPANY 		: Rivello Multimedia Consulting</p>
	 * 
	 */	public class FlyerGameResources extends ResourceBundle	{						//--------------------------------------		//  Properties		//--------------------------------------		//PUBLIC CONST		/**		 * ASSET: Background Is embedded as a class to so it can be added via 'addChild' in a non-PBE way too.  Both ways work!		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='BackgroundMC')]		public static var MOVIE_CLIP_BACKGROUND_MC		: Class;				/**		 * ASSET: 		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='BiplaneMC')]		public static var MOVIE_CLIP_BIPLANE_MC		: Class;				/**		 * ASSET: 		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='BlimpMC')]		public static var MOVIE_CLIP_BLIMP_MC		: Class;				/**		 * ASSET: 		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='FlyerMC')]		public static var MOVIE_CLIP_FLYER_MC		: Class;				/**		 * ASSET: Sound class loaded - Each time the user moves the flyer		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='MoveFlyerSound')]		private static 	var 	MOVE_FLYER_SOUND_CLASS 	: Class;		public static 	var 	MOVE_FLYER_SOUND			: Sound = new MOVE_FLYER_SOUND_CLASS ();				/**		 * ASSET: Sound class loaded - When the user wins		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='WinFlyerSound')]		private static 	var 	WIN_FLYER_SOUND_CLASS 	: Class;		public static 	var 	WIN_FLYER_SOUND			: Sound = new WIN_FLYER_SOUND_CLASS ();				/**		 * ASSET: Sound class loaded - When the user loses		 * 		 */		[Embed(source='../libs/FlyerGame_assets_v1.swf', symbol='LoseFlyerSound')]		private static 	var 	LOSE_FLYER_SOUND_CLASS 	: Class;		public static 	var 	LOSE_FLYER_SOUND			: Sound = new LOSE_FLYER_SOUND_CLASS ();					}}