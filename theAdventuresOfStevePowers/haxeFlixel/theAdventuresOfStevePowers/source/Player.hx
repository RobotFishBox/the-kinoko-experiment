package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.input.touch.FlxTouch;

class Player extends FlxSprite
{
	private var _jumping:Bool;
	private var _crouching:Bool;

	private var _targetWidth:Int;
	private var _targetHeight:Int;

	private var _attacking:Bool;

	public function new() {
		super();

		this.loadGraphic('assets/images/player.png', true, true, 25, 34);

		this.animation.add('default', [0,1], 3);
		this.animation.add('jump', [2]);
		this.animation.play('default');

		this.x = 40;
		this.y = 80;

		this.acceleration.y = 150;
		this.drag.x = 100;

		_jumping = false;
		_crouching = false;

		this.health = 100;

		this._attacking = false;
	}

	public function setStageSize(w:Int, h:Int):Void {
		_targetWidth = w;
		_targetHeight = h;
	}

	override public function update():Void
	{
		var t:FlxTouch = FlxG.touches.getFirst();

		if (t != null) {
			trace("pchan: touch is " + t.screenX + "," + t.screenY +
				" stageWidth:" + _targetWidth + " stageHeight:" + _targetHeight);

			if (t.screenX > 2 * _targetWidth / 3) {
				this.velocity.x = 90;
				this.facing = FlxObject.RIGHT;
			} else if (t.screenX < _targetWidth / 3) {
				this.velocity.x = -90;
				this.facing = FlxObject.LEFT;
			}

			if (this.velocity.y == 0 && t.screenY < _targetHeight / 3 &&
				!_crouching) {
				this.velocity.y = -160;
				this.animation.play('jump');
				_jumping = true;
			} 
			if (this.velocity.y == 0 && t.screenY > 2 * _targetHeight / 3 &&
				 !_jumping && !_crouching) {
				this.animation.play('jump');
				_crouching = true;
			} else {
				this.animation.play('default');
				_crouching = false;
			}

			if (t.screenX > _targetWidth / 3 && t.screenX < 2 * _targetWidth / 3 &&
				t.screenY > _targetHeight / 3 && t.screenY < 2 * _targetHeight / 3) {
				this._attacking = true;
			}
		} else {
			if (_crouching) {
				this.animation.play('default');
				_crouching = false;
			}
		}

		if (_jumping && this.velocity.y == 0) {
			_jumping = false;
			this.animation.play('default');
		}

		super.update();
	}

	public function attack():Bool {
		if (this._attacking) {
			this._attacking = false;
			return true;
		}
		return false;
	}
}