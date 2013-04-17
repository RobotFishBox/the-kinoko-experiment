package graphics
{
	import flash.display.BitmapData;
	import org.flixel.FlxPoint;
	
	/**
	 * A class to manage bitmaps in KSprite. This class helps allow multiple bitmaps in a sprite
	 * @author Anderson Li
	 */
	public class KBitmap
	{
		/**
		 * Internal, stores the entire source graphic (not the current displayed animation frame), used with Flash getter/setter.
		 */
		protected var _pixels:BitmapData;
		/**
		 * The width of the actual graphic or image being displayed (not necessarily the game object/bounding box).
		 */
		protected var _frameWidth:uint;
		/**
		 * The height of the actual graphic or image being displayed (not necessarily the game object/bounding box).
		 */
		protected var _frameHeight:uint;
		/**
		 * Internal, keeps track of whether the sprite was loaded with support for automatic reverse/mirroring.
		 */
		protected var _flipped:uint;
		/**
		 * offset center adjustment
		 */
		public var offset:FlxPoint = new FlxPoint(); 
		
		public function KBitmap(Pixels:BitmapData, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0):void
		{
			_pixels = Pixels;
			if (Reverse)
			{
				_flipped = _pixels.width >> 1;
			}
			else
			{
				_flipped = 0;
			}
			
			_frameWidth = Width;
			_frameHeight = Height
		}
		
		public function get pixels():BitmapData
		{
			return _pixels;
		}
		
		public function get frameWidth():uint
		{
			return _frameWidth;
		}
		
		public function get frameHeight():uint
		{
			return _frameHeight;
		}
		
		public function get flipped():uint
		{
			return _flipped;
		}
		
		/**
		 * Clean up memory.
		 */
		public function destroy():void
		{
			_pixels = null;
		}
	
	}

}