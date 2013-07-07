package input
{
	import actors.ICharacter;
	import engine.KWorld;
	import org.flixel.FlxBasic;
	
	/**
	 * The input controller for the actors
	 * @author Anderson Li
	 */
	public class Controller extends FlxBasic
	{
		/**
		 * character states
		 */
		protected var _charState:uint;
		
		protected static const CHAR_IDLE:uint = 0;
		protected static const CHAR_WALK:uint = 1;
		protected static const CHAR_ATTACK:uint = 2;
		protected static const CHAR_ATTACK_IDLE:uint = 3;
		protected static const CHAR_RUN:uint = 4;
		protected static const CHAR_RUN_ATTACK:uint = 5;
		protected static const CHAR_RUN_ATTACK_IDLE:uint = 6;
		protected static const CHAR_DEFEND:uint = 7;
		protected static const CHAR_DEFEND_IDLE:uint = 8;
		protected static const CHAR_ROLL:uint = 9;
		protected static const CHAR_ROLL_IDLE:uint = 10;
		protected static const CHAR_JUMP:uint = 11;
		protected static const CHAR_JUMP_IDLE:uint = 12;
		protected static const CHAR_JUMP_ATTACK:uint = 13;
		protected static const CHAR_JUMP_ATTACK_IDLE:uint = 14;
		
		/**
		 * jump flag lets the character know if it is okay to jump.
		 */
		protected var jumpFlag:Boolean = true;
		 
		/**
		 * Character to control
		 */
		protected var _char:ICharacter;
		
		public function Controller()
		{
			_charState = CHAR_IDLE;
		}
		
		
		/**
		 * add controller objects to the world
		 * @param	World the world to add the controller objects to
		 */
		public function addToWorld(World:KWorld):void
		{
			World.addKObject(_char);
		}
		
		/**
		 * operates user interface
		 */
		override public function update():void
		{
			super.update();
			
			//update character state
			switch (_charState)
			{
				case CHAR_IDLE: 
					_char.idle();
					break;
				
				case CHAR_DEFEND: 
					_char.defend();
					
					_char.body.velocity.make(0, 0);
					_char.kSprite.update();
					
					//_charState = CHAR_DEFEND_IDLE;
					break;
				
				case CHAR_DEFEND_IDLE:
					_char.body.velocity.make(0, 0);
					_char.kSprite.update();
					
					// TODO Make him ROLL based on velocity
					
					break;
					
				case CHAR_ROLL:
					_char.roll();
					//_charState = CHAR_ROLL_IDLE;
					break;
					
				case CHAR_ROLL_IDLE:
					break;
					
				case CHAR_ATTACK: 
					_char.attack();
					//_charState = CHAR_ATTACK_IDLE;
					break;
				
				case CHAR_ATTACK_IDLE: 
					//if (_char.kSprite.finished)
						//_charState = CHAR_IDLE;
					break;
				
				case CHAR_WALK: 
					_char.walk();
					break;
				
				case CHAR_RUN: 
					_char.run();
					break;
				
				case CHAR_RUN_ATTACK: 
					_char.runAttack();
					//_charState = CHAR_RUN_ATTACK_IDLE;
					break;
				
				case CHAR_RUN_ATTACK_IDLE:
					break;
				
				case CHAR_JUMP: 
					_char.jump();
					
					_char.body.velocity.y = 0;
					_char.body.acceleration.y = 0;
					_char.body.force.y -= _char.jumpForce;
					_char.kSprite.update();
					
					//_charState = CHAR_JUMP_IDLE;
					break;
				
				case CHAR_JUMP_IDLE: 
					//if (_char.body.grounded)
						//_charState = CHAR_IDLE;
					break;
				
				case CHAR_JUMP_ATTACK: 
					_char.jumpAttack();
					//if (_char.body.grounded)
						//_charState = CHAR_IDLE;
					//else
						//_charState = CHAR_JUMP_ATTACK_IDLE;
					break;
				
				case CHAR_JUMP_ATTACK_IDLE: 
					//if (_char.body.grounded)
						//_charState = CHAR_IDLE;
			}
		}

		
	}

}