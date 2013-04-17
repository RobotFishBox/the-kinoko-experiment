package actors
{
	import assets.AssetMap;
	import flash.display.BitmapData;
	import graphics.KSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxPoint;
	
	/**
	 * ...
	 * @author Anderson Li
	 */
	public class Ninja extends KSprite implements ICharacter
	{
		/**
		 * spring constant
		 */
		private var _k:Number
		/**
		 * damper constant
		 */
		private var _c:Number
		
		private var _temp:BitmapData;
		
		public function Ninja()
		{
			loadGraphic(AssetMap.NINJA, true, true, 80, 80);
			currKBitmap.offset.make(40, 0);
			addAnimation("idle", [1, 2], 3, true);
			addAnimation("walk", [4, 5, 6, 7, 6, 5], 12, true);
			addAnimation("run", [20, 21, 22, 21], 12, true);
			addAnimation("jump", [60, 61, 62], 24, false);
			addAnimation("attack", [11, 12, 13, 14, 15], 12, false);
			
			loadGraphic(AssetMap.NINJA2, true, false, 150, 80);
			currKBitmap.offset.make(40, 0);
			addAnimation("runAttackRight", [1, 2, 3, 4, 5], 20, false);
			
			loadGraphic(AssetMap.NINJA3, true, false, 150, 80);
			currKBitmap.offset.make(110, 0);
			addAnimation("runAttackLeft", [5, 4, 3, 2, 1], 20, false);
			
			idle();
			
			//set ninja properties
			_k = 2000;
			_c = 1000;
			_body.maxVelocity.make(10, 10);
			_body.mass = 60;
		}
		
		/**
		 * plays idle animation
		 */
		public function idle():void
		{
			play("idle");
		}
		
		/**
		 * plays walk animation
		 */
		public function walk():void
		{
			play("walk");
		}
		
		/**
		 * plays running animation
		 */
		public function run():void
		{
			play("run");
		}
		
		/**
		 * plays jump animation
		 */
		public function jump():void
		{
			play("jump");
		}
		
		/**
		 * plays attack animation
		 */
		public function attack():void
		{
			play("attack");
		}
		
		/**
		 * plays run attack animation
		 */
		public function runAttack():void
		{
			if (facing == FlxObject.RIGHT)
			{
				play("runAttackRight");
			}
			else if (facing == FlxObject.LEFT)
			{
				play("runAttackLeft");
			}
		
		}
		
		override public function update():void
		{
			super.update();
			
			//for tweaking
			if (FlxG.keys.UP)
			{
				_c++;
				trace("damper: " + c);
			}
			else if (FlxG.keys.DOWN)
			{
				_c--;
				trace("damper: " + c);
			}
			
			if (FlxG.keys.LEFT)
			{
				_k++;
				trace("spring: " + k);
			}
			else if (FlxG.keys.RIGHT)
			{
				_k--;
				trace("spring: " + k);
			}
		}
		
		/**
		 * Allows other classes to control this actor as a character.
		 * @return itself
		 */
		public function get kSprite():KSprite
		{
			return this;
		}
		
		/**
		 * Spring constant to be used with the widget
		 * @return spring constant
		 */
		public function get k():Number
		{
			return _k;
		}
		
		/**
		 * Damper constant to be used with the widget
		 * @return damper constant
		 */
		public function get c():Number
		{
			return _c;
		}
		
		/**
		 * running speed in m/s
		 */
		public function get runSpeed():Number
		{
			return 3;
		}
		
		/**
		 * walking speed in m/s
		 */
		public function get walkSpeed():Number
		{
			return 0.05;
		}
		
		/**
		 * distance before character jumps in pixels
		 */
		public function get jumpThreshold():Number
		{
			return 25;
		}
		
		/**
		 * jump force measured in newtons
		 */
		public function get jumpForce():Number
		{
			return 25000;
		}
	}

}