package states
{
	import engine.widgets.KDamper;
	import engine.widgets.KSpring;
	import graphics.KSprite;
	import engine.KWorld;
	import org.flixel.FlxCamera;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
	import org.flixel.FlxState;
	import org.flixel.FlxTileblock;
	
	/**
	 * a blank canvas state that can be used for testing
	 * code and other good stuff
	 *
	 * @author Anderson Li
	 */
	public class CanvasState extends FlxState
	{
		private var _floor:FlxTileblock = new FlxTileblock(-50, 250, 600, 32);
		private var _world:KWorld = new KWorld();
		private var _mouse:KSprite = new KSprite();
		private var _ninja:KSprite = new KSprite();
		private var _kSpring:KSpring = new KSpring(_mouse, _ninja, 2000);
		private var _kDamper:KDamper = new KDamper(600);
		
		override public function create():void
		{
			FlxG.mouse.show();
			_floor.makeGraphic(600, 32, 0xff689c16);
			FlxG.camera.drawDebug(FlxG.camera);
			add(_floor);
			
			_world.pixelScale.make(30, 30);
			_world.gravity.make(0.5, 10);
			
			//spring and damper test
			_mouse.body.fixed = true;
			_kDamper.attach(_ninja);
			_kDamper.effect.make(1, 0);
			_kSpring.effect.make(1, 0);
			
			_ninja.body.maxVelocity.make(10, 10);
			_ninja.body.mass = 60;
			add(_ninja);
			
			_world.addKObject(_ninja);
			_world.addKObject(_mouse);
			_world.addKWidget(_kSpring);
			_world.addKWidget(_kDamper);
			
			FlxG.camera.follow(_ninja, FlxCamera.STYLE_PLATFORMER);
			FlxG.camera.setBounds(0, -2000, 500, 5000);
		}
		
		override public function update():void
		{
			_mouse.x = FlxG.mouse.x;
			_mouse.y = FlxG.mouse.y;
			if (FlxG.mouse.justPressed()) {
				_ninja.body.velocity.y = 0;
				_ninja.body.acceleration.y = 0;
				_ninja.body.force.y -= 20000;
				_ninja.update();
			}
			if (FlxG.keys.UP) {
				_kDamper.c ++;
				trace("damper: " + _kDamper.c);
			}
			else if (FlxG.keys.DOWN) {
				_kDamper.c --;
				trace("damper: " + _kDamper.c);
			}
			
			if (FlxG.keys.LEFT) {
				_kSpring.k ++;
				trace("spring: " + _kSpring.k);
			}
			else if (FlxG.keys.RIGHT) {
				_kSpring.k --;
				trace("spring: " + _kSpring.k);
			}
			
			_world.update();
			super.update();
			FlxG.collide(_floor, _ninja);
		}
	
	}

}