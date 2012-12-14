package characters 
{
	import flash.display.DisplayObject;
	import math.KPoint;
	/**
	 * ...
	 * @author Kinoko
	 */
	public interface ICharacters 
	{	
		function get frameRate():Number; // each character has his own frame rate
		function get point():KPoint; // location of the character
		function get body():DisplayObject; // body of the character
			
		function load():void; // loads assets to the character
		function animate():void; // which frame to use upon render
		function render():void; // displays the character on screen
		function cleanUp():void; //remove assets, free memory
	}

}