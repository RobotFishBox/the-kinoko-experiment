package graphics
{
	import engine.IKObject;
	import engine.KBody;
	import org.flixel.FlxG;
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class KSprite extends FlxSprite implements IKObject
	{
		/**
		 * KBody handles all the physics
		 */
		protected var _body:KBody = new KBody();
		/**
		 * Array to store all loaded graphics (Bitmaps)
		 */
		protected var _kBitmaps:Array = new Array();
		
		public function KSprite(X:Number = 0, Y:Number = 0, SimpleGraphic:Class = null)
		{
			super(X, Y, SimpleGraphic);
		}
		
		/**
		 * Load an image from an embedded graphic file and also saves the pixels created into _kBitmaps.
		 *
		 * @param	Graphic		The image you want to use.
		 * @param	Animated	Whether the Graphic parameter is a single sprite or a row of sprites.
		 * @param	Reverse		Whether you need this class to generate horizontally flipped versions of the animation frames.
		 * @param	Width		Optional, specify the width of your sprite (helps FlxSprite figure out what to do with non-square sprites or sprite sheets).
		 * @param	Height		Optional, specify the height of your sprite (helps FlxSprite figure out what to do with non-square sprites or sprite sheets).
		 * @param	Unique		Optional, whether the graphic should be a unique instance in the graphics cache.  Default is false.
		 *
		 * @return	This FlxSprite instance (nice for chaining stuff together, if you're into that).
		 */
		override public function loadGraphic(Graphic:Class, Animated:Boolean = false, Reverse:Boolean = false, Width:uint = 0, Height:uint = 0, Unique:Boolean = false):FlxSprite
		{
			super.loadGraphic(Graphic, Animated, Reverse, Width, Height, Unique);
			_kBitmaps.push(new KBitmap(_pixels, Reverse, Width, Height));
			return this;
		}
		
		override public function addAnimation(Name:String, Frames:Array, FrameRate:Number = 0, Looped:Boolean = true):void
		{
			if (_kBitmaps.length > 0)
			{
				_animations.push(new KAnim(Name, Frames, FrameRate, Looped, _kBitmaps.length - 1));
				return;
			}
			FlxG.log("WARNING: No loaded graphics available. Load at least one graphic first.");
		}
		
		override public function play(AnimName:String, Force:Boolean = false):void
		{
			if (!Force && (_curAnim != null) && (AnimName == _curAnim.name) && (_curAnim.looped || !finished))
				return;
			_curFrame = 0;
			_curIndex = 0;
			_frameTimer = 0;
			var i:uint = 0;
			var l:uint = _animations.length;
			while (i < l)
			{
				if (_animations[i].name == AnimName)
				{
					//use the bitmapIndex to set correct bitmap
					var kAnim:KAnim = _animations[i];
					var kBitmap:KBitmap = _kBitmaps[kAnim.bitmapIndex];
					_pixels = kBitmap.pixels;
					width = frameWidth = kBitmap.frameWidth;
					height = frameHeight = kBitmap.frameHeight;
					_flipped = kBitmap.flipped;
					offset.copyFrom(kBitmap.offset);
					resetHelpers();
					
					_curAnim = _animations[i];
					if (_curAnim.delay <= 0)
						finished = true;
					else
						finished = false;
					_curIndex = _curAnim.frames[_curFrame];
					dirty = true;
					return;
				}
				i++;
			}
			FlxG.log("WARNING: No animation called \"" + AnimName + "\"");
		}
		
		/**
		 * Match body physics with pixels
		 */
		override public function update():void
		{
			_body.update(FlxG.elapsed);
			x = _body.x * _body.pixelScale.x;
			y = _body.y * _body.pixelScale.y;
			velocity.x = _body.velocity.x * _body.pixelScale.x;
			velocity.y = _body.velocity.y * _body.pixelScale.y;
			maxVelocity.x = _body.maxVelocity.x * _body.pixelScale.x;
			maxVelocity.y = _body.maxVelocity.y * _body.pixelScale.y;
			
			super.update();
		}
		
		/**
		 * returns the current KBitmap
		 */
		public function get currKBitmap():KBitmap
		{
			if (_kBitmaps != null)
			{
				return _kBitmaps[_kBitmaps.length - 1];
			}
			else
			{
				return null;
			}
		}
		
		/* INTERFACE engine.IKObject */
		
		/**
		 * Syncs KBody with a sprite that gets displayed
		 */
		public function sync():void
		{
			_body.x = x / _body.pixelScale.x;
			_body.y = y / _body.pixelScale.y;
			_body.velocity.x = velocity.x / _body.pixelScale.x;
			_body.velocity.y = velocity.y / _body.pixelScale.y;
		}
		
		public function get body():KBody
		{
			return _body;
		}
	
	}

}