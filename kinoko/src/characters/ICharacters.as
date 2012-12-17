package characters 
{
	import engine.Body;
	import flash.display.DisplayObject;
	/**
	 * ...
	 * @author Anderson Li
	 */
	public interface ICharacters 
	{	
		function get frameRate():Number; // each character has his own frame rate
		function get body():Body; // body of the character
		function get displayObj():DisplayObject; // display of the character
			
		function load():void; // loads assets to the character
		function animate():void; // which frame to use upon render
		function render():void; // displays the character on screen
		function cleanUp():void; //remove assets, free memory
	}

}