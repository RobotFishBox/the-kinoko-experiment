package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class Enemy extends FlxSprite
{
	private var _jumping:Bool;

	private var targ:FlxSprite;

	public function new() {
		super();

		this.loadGraphic('assets/images/enemy.png', true, true, 25, 34);

		this.animation.add('default', [0,1], 3);
		this.animation.add('jump', [2]);
		this.animation.play('default');

		this.x = 40;
		this.y = 80;

		this.acceleration.y = 150;
		this.drag.x = 100;

		_jumping = false;
	}

	public function setTarget(t:FlxSprite) {
		targ = t;
	}

	override public function update():Void
	{
		var distX:Float = this.x - targ.x;
		var distY:Float = this.y - targ.y;

		if (distX > 0) {
			this.velocity.x = -50;
			this.facing = FlxObject.LEFT;
		} else {
			this.velocity.x = 50;
			this.facing = FlxObject.RIGHT;
		}

		if (distY > 0 && !_jumping) {
			this.velocity.y = -150;
			this.animation.play('jump');
			_jumping = true;
		}

		if (_jumping && this.velocity.y == 0) {
			_jumping = false;
			this.animation.play('default');
		}

		super.update();
	}
}