package graphics 
{
	import org.flixel.system.FlxAnim;
	/**
	 * adds an extra properties to FlxAnim
	 * @author Anderson Li
	 */
	public class KAnim extends FlxAnim
	{
		/**
		 * Seconds between frames (basically the framerate)
		 */
		public var bitmapIndex:uint;
		
		/**
		 * Constructor
		 * 
		 * @param	Name		What this animation should be called (e.g. "run")
		 * @param	Frames		An array of numbers indicating what frames to play in what order (e.g. 1, 2, 3)
		 * @param	FrameRate	The speed in frames per second that the animation should play at (e.g. 40)
		 * @param	Looped		Whether or not the animation is looped or just plays once
		 */
		public function KAnim(Name:String, Frames:Array, FrameRate:Number=0, Looped:Boolean=true, BitmapIndex:uint = 0)
		{
			bitmapIndex = BitmapIndex;
			super(Name, Frames, FrameRate, Looped);
		}
		
	}

}