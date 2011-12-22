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
	public class DisplayObjectRenderComponent extends AnimatedComponent
	{
		
		// --------------------------------------
		// Properties
		// --------------------------------------
		// PUBLIC GETTER / SETTER
		/**
		 * Describe this member. 
		 * 
		 */		
		private var _position_point : Point = new Point ();
		public function get position () 				: Point { return _position_point; }
		public function set position (aValue : Point) 	: void 	{ 
			
			//if (aValue != _position_point) {
				_position_point = aValue; 
				
				_displayObject.x = _position_point.x;
				_displayObject.y = _position_point.y;  
				
			//}
		}
		
		
		/**
		 * Describe this member. 
		 * 
		 */			
		private var _size_point : Point = new Point ();
		public function get size () 				: Point { return _size_point; }
		public function set size (aValue : Point) 	: void 	{ 
			
			if (aValue != _size_point) {
				_size_point = aValue; 
				
				_displayObject.width 	= _size_point.x;
				_displayObject.height 	= _size_point.y;
			}
			
		}
		
		
		/**
		 * Describe this member. 
		 * 
		 */			
		private var _rotation_num : Number;
		public function get rotation () 				: Number { return _rotation_num; }
		public function set rotation (aValue : Number) 	: void 	{ 
			
			//if (aValue != _rotation_num) {
				_rotation_num = aValue; 
				
				_displayObject.rotation = _rotation_num;
				trace ("_displayObject.rotation: " + _displayObject.rotation);
			//}
		}
		
		
		// PUBLIC
		/**
		 * Describe this member. 
		 * 
		 */		
		[Inject]
		public var stage:Stage;
		
		// PRIVATE
		/**
		 * Describe this member. 
		 * 
		 */			
		private var _displayObject_class : Class;
		public function get displayObjectClass () 					: Class 	{ return _displayObject_class; }
		public function set displayObjectClass (aValue : Class) 	: void 		
		{
			_displayObject_class = aValue;
			_drawChild();
		}
		
		/**
		 *  TODO: make super class that has DO property, this just strong types it casting to MC (or sprite?)
		 */		
		private var _displayObject : DisplayObject;
		public function get displayObject () 					: DisplayObject 	{ return _displayObject; }
		
		
		
		// --------------------------------------
		// Constructor
		// --------------------------------------
		/**
		 * This is the constructor.
		 * 
		 */
		public function DisplayObjectRenderComponent(aDisplayObject_class : Class):void
		{
			// SUPER
			super();
			
			// EVENTS
			
			// VARIABLES
			
			// PROPERTIES
			addBinding("position"	, "@spatial.position");
			addBinding("size"		, "@spatial.size");
			addBinding("rotation"	, "@spatial.rotation");
			displayObjectClass = aDisplayObject_class;
			
			// METHODS
			
			
		}
		
		
		/**
		 *  
		 * 
		 * @return void
		 * 
		 */
		protected override function onAdd():void
		{
			super.onAdd();
			if (_displayObject_class) {
				_drawChild();
			}
		}
		
		/**
		 *  
		 * 
		 * @return void
		 * 
		 */
		protected function _drawChild() : void {
			
			//ONE FRAME WILL BE A 'SPRITE' AND 2+ FRAMES WILL BE A 'MOVIECLIP'
			if (stage) {
				_displayObject = new _displayObject_class();
				stage.addChild(_displayObject);
			}
		}
		
		/**
		 *  
		 * 
		 * @return void
		 * 
		 */
		protected override function onRemove():void
		{
			stage.removeChild(_displayObject);
			removeBinding("position"	, "@spatial.position");
			removeBinding("size"		, "@spatial.size");
			removeBinding("rotation"	, "@spatial.rotation");
			super.onRemove();
		}
		
	}
}