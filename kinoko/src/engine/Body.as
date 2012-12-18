package engine
{
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	
	/**
	 * a physical body for the widgets
	 * @author Anderson Li
	 */
	public class Body extends FlxSprite
	{
		/**
		 * The real mass value that is used with widgets, as opposed to
		 * <code>mass</code> that is used for collisions
		 */
		public var rmass:Number;
		/**
		 * Force applied to this body.
		 */
		public var force:FlxPoint;
		
		public function Body(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		/**
		 * Automatically called after update() by the game loop,
		 * this function just calls 
		 */
		override public function postUpdate():void 
		{
			
			super.postUpdate();
		}
	}
}