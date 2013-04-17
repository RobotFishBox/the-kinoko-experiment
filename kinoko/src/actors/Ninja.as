package actors
{
	import assets.AssetMap;
	import graphics.KSprite;
	import org.flixel.FlxG;
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
		private var k:Number
		/**
		 * damper constant
		 */
		private var c:Number
		
		public function Ninja()
		{
			//graphics
			loadGraphic(AssetMap.NINJA, true, true, 80, 80);
			addAnimation("idle", [1, 2], 3, true);
			addAnimation("walk", [4, 5, 6, 7, 6, 5], 12, true);
			addAnimation("run", [20, 21, 22, 21], 12, true);
			addAnimation("jump", [60, 61, 62], 24, false);
			addAnimation("attack", [11, 12, 13, 14, 15], 12, false);
			offset.x = this.width / 2;
			idle();
			
			//set ninja properties
			k = 2000;
			c = 1000;
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
		
		override public function update():void
		{
			super.update();
			
			//for tweaking
			if (FlxG.keys.UP)
			{
				c++;
				trace("damper: " + c);
			}
			else if (FlxG.keys.DOWN)
			{
				c--;
				trace("damper: " + c);
			}
			
			if (FlxG.keys.LEFT)
			{
				k++;
				trace("spring: " + k);
			}
			else if (FlxG.keys.RIGHT)
			{
				k--;
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
		public function get springK():Number
		{
			return k;
		}
		
		/**
		 * Damper constant to be used with the widget
		 * @return damper constant
		 */
		public function get damperC():Number
		{
			return c;
		}
		
		/**
		 * minimum speed for movement in m/s
		 */
		public function get movementSpeed():Number
		{
			return 0.1;
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
			return 20000;
		}
	}

}