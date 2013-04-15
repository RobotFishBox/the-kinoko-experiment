package input 
{
	import graphics.KSprite;
	import org.flixel.FlxG;
	
	/**
	 * The Cursor for the game.
	 * @author Anderson Li
	 */
	public class Cursor extends KSprite
	{
		
		public function Cursor(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
			FlxG.mouse.show(); //TODO: use own sprite image
		}
		
	}

}