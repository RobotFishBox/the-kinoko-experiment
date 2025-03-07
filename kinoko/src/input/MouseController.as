package input 
{
	import actors.ICharacter;
	import engine.KWorld;
	import engine.widgets.KDamper;
	import engine.widgets.KSpring;
	import graphics.KSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	
	/**
	 * The Mouse Controller
	 * @author pchan
	 */
	public class MouseController extends Controller 
	{
		/**
		 * mouse states
		 */
		private var _mouseState:uint;
		private static const MOUSE_IDLE:uint = 0;
		private static const MOUSE_PRESSED:uint = 1;
		private static const MOUSE_JUST_PRESSED:uint = 2;
		private static const MOUSE_JUST_RELEASED:uint = 3;
		
		/**
		 * activates when mouse reaches upper limit
		 */
		private var attackUpperFlag:uint = 0;
		/**
		 * activates when mouse reach lower limits
		 */
		private var attackLowerFlag:uint = 0;
		
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
		
		public function MouseController() 
		{
			super();
			
			_kSpring = new KSpring();
			_kDamper = new KDamper();
			
			_mouseState = MOUSE_IDLE;
			setMouseControl = true;
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
			_kSpring.k = _char.k;
			_kDamper.c = _char.c;
			
			setMouseControl = true;
		}
		
		/**
		 * add controller objects to the world
		 * @param	World the world to add the controller objects to
		 */
		override public function addToWorld(World:KWorld):void
		{
			super.addToWorld(World);
			
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
			
			//incase the physics change(as in debugging)
			_kSpring.k = _char.k;
			_kDamper.c = _char.c;
			
			//update cursor position
			_mouse.x = FlxG.mouse.x;
			_mouse.y = FlxG.mouse.y;
			
			//update mouse state
			if (FlxG.mouse.justPressed())
				_mouseState = MOUSE_JUST_PRESSED;
			else if (FlxG.mouse.pressed())
				_mouseState = MOUSE_PRESSED;
			else if (FlxG.mouse.justReleased())
				_mouseState = MOUSE_JUST_RELEASED;
			else
				_mouseState = MOUSE_IDLE;
			
			//update character state
			switch (_charState)
			{
				case CHAR_IDLE:
					autoFacing();
					setMouseControl = true;
					autoMovement(CHAR_DEFEND);
					break;
				
				case CHAR_DEFEND:
					autoFacing();
					setMouseControl = false;
					attackUpperFlag = 0;
					attackLowerFlag = 0;
					
					_charState = CHAR_DEFEND_IDLE;
					break;
				
				case CHAR_DEFEND_IDLE: 
					autoFacing();
					
					var distX:Number = Math.abs(_char.kSprite.x - _mouse.x);
					
					if (_mouseState == MOUSE_JUST_RELEASED)
						_charState = CHAR_IDLE;
					else if (distX > _char.rollThreshold)
						_charState = CHAR_ROLL;
					else 
					{
						var distY:Number = (_char.kSprite.y + _char.kSprite.height/2)  - _mouse.y;
						if (distY > 0 && attackLowerFlag <= attackUpperFlag)
							attackLowerFlag ++;
							//TODO: make the flag increment 3 times before
						else if (distY < 0 && attackUpperFlag <= attackLowerFlag)
							attackUpperFlag ++;
						
						if (attackLowerFlag + attackUpperFlag > 3)
							_charState = CHAR_ATTACK;
					}
					break;
					
				case CHAR_ROLL:
					setMouseControl = true;
					_charState = CHAR_ROLL_IDLE;
					break;
					
				case CHAR_ROLL_IDLE:
					removeBounceBack();
					if (_char.kSprite.finished)
					{
						autoMovement(CHAR_IDLE);
						setMouseControl = true;
					}
					break;
					
				case CHAR_ATTACK:
					_charState = CHAR_ATTACK_IDLE;
					break;
				
				case CHAR_ATTACK_IDLE:
					if (_char.kSprite.finished)
						_charState = CHAR_IDLE;
					break;
				
				case CHAR_WALK:
					autoFacing();
					autoMovement(CHAR_DEFEND);
					break;
				
				case CHAR_RUN:
					autoFacing();
					autoMovement(CHAR_RUN_ATTACK);
					break;
				
				case CHAR_RUN_ATTACK:
					removeBounceBack();
					_charState = CHAR_RUN_ATTACK_IDLE;
					break;
				
				case CHAR_RUN_ATTACK_IDLE: 
					removeBounceBack();
					if (_char.kSprite.finished)
					{
						autoMovement(CHAR_IDLE);
						setMouseControl = true;
					}
					break;
				
				case CHAR_JUMP:
					autoFacing();
					_charState = CHAR_JUMP_IDLE;
					break;
				
				case CHAR_JUMP_IDLE: 
					autoFacing();
					if (_char.body.grounded)
						_charState = CHAR_IDLE;
					else if (_mouseState == MOUSE_JUST_PRESSED)
						_charState = CHAR_JUMP_ATTACK;
					break;
				
				case CHAR_JUMP_ATTACK:
					autoFacing();
					if (_char.body.grounded)
						_charState = CHAR_IDLE;
					else
						_charState = CHAR_JUMP_ATTACK_IDLE;
					break;
				
				case CHAR_JUMP_ATTACK_IDLE: 
					autoFacing();
					if (_char.body.grounded)
						_charState = CHAR_IDLE;
			}
		}
		
		/**
		 * if a character has no autofacing you might want to remove all
		 * motion opposite to the direction the charater is facing.
		 */
		private function removeBounceBack():void
		{
			if (_char.kSprite.facing == FlxObject.LEFT)
			{
				if (FlxG.mouse.x < _char.kSprite.x)
					setMouseControl = true;
				else
					setMouseControl = false;
			}
			else if (_char.kSprite.facing == FlxObject.RIGHT)
			{
				if (FlxG.mouse.x > _char.kSprite.x)
					setMouseControl = true;
				else
					setMouseControl = false;
			}
		}
		
		/**
		 * enable or disable mouse control over the character.
		 */
		private function set setMouseControl(enable:Boolean):void
		{
			if (enable)
			{
				_kDamper.effect.make(1, 0);
				_kSpring.effect.make(1, 0);
			}
			else
			{
				_kDamper.effect.make(0, 0);
				_kSpring.effect.make(0, 0);
			}
		}
		
		/**
		 * automatically set character movement state based on speed.
		 * You can set it to do something different on mouse press and release.
		 */
		private function autoMovement(pressedState:uint):void
		{
			switch (_mouseState)
			{
				case MOUSE_JUST_PRESSED: 
					_charState = pressedState;
					break;
				default:
					
					var distY:Number = _char.kSprite.y - _mouse.y;
					if (distY > _char.jumpThreshold && jumpFlag == true)
					{
						_charState = CHAR_JUMP;
						jumpFlag = false;
					}
					else
					{
						if (distY < _char.jumpThreshold) 
							jumpFlag = true;
						
						var speedX:Number = Math.abs(_char.body.velocity.x);
						if (speedX > _char.runSpeed)
							_charState = CHAR_RUN;
						else if (speedX > _char.walkSpeed)
							_charState = CHAR_WALK;
						else
							_charState = CHAR_IDLE;
						
					}
					break;
			}
		}
		
		/**
		 * decide character facing automatically based on position of mouse
		 */
		private function autoFacing():void
		{
			if (FlxG.mouse.x < _char.kSprite.x)
			{
				_char.kSprite.facing = FlxObject.LEFT;
			}
			else
			{
				_char.kSprite.facing = FlxObject.RIGHT;
			}
		}
	}

}