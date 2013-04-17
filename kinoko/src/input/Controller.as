package input
{
	import actors.ICharacter;
	import engine.KWorld;
	import engine.widgets.KDamper;
	import engine.widgets.KSpring;
	import graphics.KSprite;
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * The input controller for the actors
	 * @author Anderson Li
	 */
	public class Controller extends FlxBasic
	{
		/**
		 * spring that is attached to the cursor
		 */
		private var _kSpring:KSpring;
		/**
		 * the damper that is attached to the cursor
		 */
		private var _kDamper:KDamper;
		/**
		 * mouse cursor
		 */
		private var _mouse:KSprite;
		/**
		 * Character to control
		 */
		private var _char:ICharacter;
		
		public var grounded:Boolean = false;
		
		public function Controller()
		{
			_kSpring = new KSpring();
			_kDamper = new KDamper();
		}
		
		/**
		 * attach mouse and characters to the springs and damper
		 * @param	Mouse mouse object
		 * @param	Char character
		 */
		public function attach(Mouse:Cursor, Char:ICharacter):void
		{
			//save the mouse and character
			_mouse = Mouse;
			_char = Char;
			
			// attach objects
			_kSpring.attach(_mouse, _char);
			_kDamper.attach(_char);
			_kSpring.k = _char.springK;
			_kDamper.c = _char.damperC;
			
			// set directional effect
			_kDamper.effect.make(1, 0);
			_kSpring.effect.make(1, 0);
		}
		
		/**
		 * add controller objects to the world
		 * @param	World the world to add the controller objects to
		 */
		public function addToWorld(World:KWorld):void
		{
			World.addKObject(_char);
			World.addKObject(_mouse);
			World.addKWidget(_kSpring);
			World.addKWidget(_kDamper);
		}
		
		/**
		 * operates user interface
		 */
		override public function update():void
		{
			super.update();
			
			_kSpring.k = _char.springK;
			_kDamper.c = _char.damperC;
			
			_mouse.x = FlxG.mouse.x;
			_mouse.y = FlxG.mouse.y;
			
			if (FlxG.mouse.x < _char.kSprite.x)
			{
				_char.kSprite.facing = FlxObject.LEFT;
			}
			else
			{
				_char.kSprite.facing = FlxObject.RIGHT;
			}
			
			var distY:Number = _char.kSprite.y - _mouse.y;
			
			if (grounded)
			{
				if (distY > _char.jumpThreshold && grounded)
				{
					_char.body.velocity.y = 0;
					_char.body.acceleration.y = 0;
					_char.body.force.y -= _char.jumpForce;
					_char.jump();
					_char.kSprite.update();
				}
				else
				{
					var speedX:Number = Math.abs(_char.body.velocity.x);
					if (speedX > _char.runSpeed)
					{
						_char.run();
					}
					else if (speedX > _char.walkSpeed)
					{
						if (FlxG.mouse.pressed())
						{
							_char.attack();
						}
						else
						{
							_char.walk();
						}
					}
					else
					{
						if (FlxG.mouse.pressed())
						{
							_char.attack();
						}
						else
						{
							_char.idle();
						}
					}
				}
			}
		}
	}

}