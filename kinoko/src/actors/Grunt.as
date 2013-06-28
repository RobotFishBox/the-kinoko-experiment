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
	public class Grunt extends KSprite implements ICharacter
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
		
		public function Grunt()
		{
			loadGraphic(AssetMap.GRUNT, true, true, 80, 80);
			currKBitmap.offset.make(40, 0);
			addAnimation("idle", [1, 2], 3, true);
			addAnimation("defend", [56, 57], 24, false);
			addAnimation("roll", [58, 59, 49], 12, false);
			addAnimation("walk", [4, 5, 6, 7, 6, 5], 12, true);
			addAnimation("run", [20, 21, 22, 21], 12, true);
			addAnimation("jump", [60, 61, 62], 24, false);
			addAnimation("jumpAttack", [14, 15], 12, false);
			addAnimation("attack", [10, 11, 12, 13], 12, false);
			addAnimation("runAttack", [84, 85, 86], 12, false);
			
			idle();
			
			//TODO set grunt properties
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
		 * plays defend animation
		 */
		public function defend():void
		{
			play("defend");
		}
		
		/**
		 * plays roll animation
		 */
		public function roll():void
		{
			play("roll");
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
		 * plays jump animation
		 */
		public function jumpAttack():void
		{
			play("jumpAttack");
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
			play("runAttack");
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
		 * distance before character rolls in pixels
		 */
		public function get rollThreshold():Number
		{
			return 150;
		}
		/**
		 * jump force measured in newtons
		 */
		public function get jumpForce():Number
		{
			return 25000;
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
	}

}